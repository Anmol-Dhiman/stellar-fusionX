#![no_std]
use soroban_sdk::{contract, contractimpl, contracttype, Address, Bytes, BytesN, Env};

mod relayer {
    soroban_sdk::contractimport!(file = "G:\\EthUnite\\stellar-fusionX\\contracts\\stellar\\target\\wasm32v1-none\\release\\relayer.wasm");
}

mod escrow_factory {
    soroban_sdk::contractimport!(file = "G:\\EthUnite\\stellar-fusionX\\contracts\\stellar\\target\\wasm32v1-none\\release\\escrowfactory.wasm");
}

const MAX_AUCTION_TIME: u128 = 10 * 60; // 10 minutes in seconds
const AUCTION_START_BUFFER: u128 = 2 * 60; // 2 minutes in seconds

#[contract]
pub struct DutchAuction;

#[derive(Clone, Debug, Eq, PartialEq)]
#[contracttype]
pub enum DataKey {
    Owner,             // owner address
    EscrowFactory,     // escrow factory address
    Relayer,           // relayer contract address
    Order(BytesN<32>), // order ID
}

#[derive(Clone)]
#[contracttype]
pub struct Order {
    pub maker: Address,
    pub tokenIn: Address,
    pub tokenOut: BytesN<32>,
    pub amountIn: u128,
    pub amountOut: u128,
    pub minAmountOut: u128,
    pub maxAmountOut: u128,
    pub resolverAssigned: Address,
    pub startTime: u128,
    pub hashLock: BytesN<32>,
}

#[derive(Clone)]
#[contracttype]
pub struct OrderInput {
    pub orderId: BytesN<32>,
    pub maker: Address,
    pub tokenIn: Address,
    pub tokenOut: BytesN<32>,
    pub amountIn: u128,
    pub minAmountOut: u128,
    pub maxAmountOut: u128,
    pub hashLock: BytesN<32>,
}

#[contractimpl]
impl DutchAuction {
    pub fn initialize(env: Env, owner: Address) {
        env.storage().persistent().set(&DataKey::Owner, &owner);
    }

    pub fn start_auction(env: Env, order_input: OrderInput) {
        Self::only_relayer(env.clone());
        let block_time: u128 = env.ledger().timestamp().into();
        let order = Order {
            maker: order_input.maker,
            tokenIn: order_input.tokenIn,
            tokenOut: order_input.tokenOut,
            amountIn: order_input.amountIn,
            amountOut: 0,
            minAmountOut: order_input.minAmountOut,
            maxAmountOut: order_input.maxAmountOut,
            resolverAssigned: Self::zero_address(&env),
            startTime: block_time + AUCTION_START_BUFFER,
            hashLock: order_input.hashLock,
        };

        env.storage()
            .persistent()
            .set(&DataKey::Order(order_input.orderId), &order);
    }

    pub fn fillOrder(env: Env, caller: Address, order_id: BytesN<32>) {
        Self::only_resolver(env.clone(), caller.clone());
        let block_time: u128 = env.ledger().timestamp().into();
        let mut order = env
            .storage()
            .persistent()
            .get::<DataKey, Order>(&DataKey::Order(order_id.clone()))
            .unwrap_or_else(|| {
                panic!("Order not found");
            });
        if order.startTime > block_time {
            panic!("Auction has not started yet");
        }
        let amount_out = Self::get_amount_out(env.clone(), order_id.clone());
        order.amountOut = amount_out;
        env.storage()
            .persistent()
            .set(&DataKey::Order(order_id.clone()), &order);

        // deploy escrow src
        let escrow_factory_contract =
            escrow_factory::Client::new(&env.clone(), &Self::get_escrow_factory(env.clone()));

        let escrow_src_address = escrow_factory_contract.deploy_src(
            &order_id.clone(),
            &order.hashLock.clone(),
            &order.tokenIn.clone(),
            &order.amountIn.clone(),
            &order.maker.clone(),
            &caller.clone(), //executive_resolver
            &env.current_contract_address().clone(),
        );

        // move funds from relayer to escrow
        let relayer = relayer::Client::new(&env.clone(), &Self::get_relayer(env.clone()));

        relayer.move_tokens_to_escrow(
            &order.maker.clone(),
            &order.tokenIn.clone(),
            &escrow_src_address.clone(),
            &order.amountIn.clone(),
        );
    }

    pub fn get_amount_out(env: Env, order_id: BytesN<32>) -> u128 {
        let order = env
            .storage()
            .persistent()
            .get::<DataKey, Order>(&DataKey::Order(order_id))
            .unwrap_or_else(|| {
                panic!("Order not found");
            });

        let start_time: u128 = order.startTime;
        let end_time: u128 = start_time + MAX_AUCTION_TIME;
        let block_time: u128 = env.ledger().timestamp().into();
        let current_time: u128 = block_time.max(start_time).min(end_time);

        let amount_out = (order.maxAmountOut * (end_time - current_time)
            + order.minAmountOut * (current_time - start_time))
            / (end_time - start_time);

        amount_out
    }

    fn zero_address(env: &Env) -> Address {
        let zero_bytes = Bytes::from_array(env, &[0u8; 32]);
        Address::from_string_bytes(&zero_bytes)
    }

    fn only_resolver(env: Env, caller: Address) {
        let relayer = relayer::Client::new(&env.clone(), &Self::get_relayer(env));
        let value = relayer.is_resolver(&caller);
        if !value {
            panic!("Only resolvers can call this function");
        }
    }

    pub fn get_relayer(env: Env) -> Address {
        env.storage().persistent().get(&DataKey::Relayer).unwrap()
    }

    pub fn get_escrow_factory(env: Env) -> Address {
        env.storage()
            .persistent()
            .get(&DataKey::EscrowFactory)
            .unwrap()
    }

    pub fn get_owner(env: Env) -> Address {
        env.storage().persistent().get(&DataKey::Owner).unwrap()
    }

    fn only_owner(env: Env) {
        let owner = Self::get_owner(env);
        owner.require_auth();
    }

    fn only_relayer(env: Env) {
        let relayer = Self::get_relayer(env);
        relayer.require_auth();
    }

    pub fn set_relayer(env: Env, relayer: Address) {
        Self::only_owner(env.clone());
        env.storage().persistent().set(&DataKey::Relayer, &relayer);
    }

    pub fn set_escrow_factory(env: Env, escrow_factory: Address) {
        Self::only_owner(env.clone());
        env.storage()
            .persistent()
            .set(&DataKey::EscrowFactory, &escrow_factory);
    }
}
