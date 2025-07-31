#![no_std]
use soroban_sdk::{
    contract, contractimpl, contracttype, symbol_short, Address, Bytes, Env, Symbol, token
};

mod types;
use types::{DataKey, Error, Order, OrderInput};

const MAX_AUCTION_TIME: u64 = 10 * 60; // 10 minutes in seconds
const AUCTION_START_BUFFER: u64 = 2 * 60; // 2 minutes in seconds

#[contract]
pub struct DutchAuction;

#[contractimpl]
impl DutchAuction {
    pub fn initialize(env: Env, owner: Address, escrow_factory: Address) {
        env.storage().instance().set(&DataKey::Owner, &owner);
        env.storage().instance().set(&DataKey::EscrowFactory, &escrow_factory);
    }

    pub fn start_auction(env: Env, order_input: OrderInput) -> Result<(), Error> {
        let relayer = env.storage().instance().get::<DataKey, Address>(&DataKey::Relayer)
            .ok_or(Error::NotAuthorized)?;
        
        if env.current_contract_address() != relayer {
            return Err(Error::NotAuthorized);
        }

        let order = Order {
            maker: order_input.maker,
            token_in: order_input.token_in,
            token_out: order_input.token_out,
            amount_in: order_input.amount_in,
            amount_out: 0,
            min_amount_out: order_input.min_amount_out,
            max_amount_out: order_input.max_amount_out,
            resolver_assigned: None,
            path: order_input.path,
            start_time: env.ledger().timestamp() + AUCTION_START_BUFFER,
            hash_lock: order_input.hash_lock,
        };

        env.storage().persistent().set(&DataKey::Order(order_input.order_id), &order);
        Ok(())
    }

    pub fn fill_order(env: Env, order_id: Bytes, security_deposit: u128) -> Result<Address, Error> {
        let relayer = env.storage().instance().get::<DataKey, Address>(&DataKey::Relayer)
            .ok_or(Error::NotAuthorized)?;
        
        if env.current_contract_address() != relayer {
            return Err(Error::NotAuthorized);
        }

        let mut order = env.storage().persistent().get::<DataKey, Order>(&DataKey::Order(order_id.clone()))
            .ok_or(Error::OrderNotFound)?;

        if env.ledger().timestamp() < order.start_time {
            return Err(Error::AuctionNotStarted);
        }

        let amount_out = Self::get_amount_out(env.clone(), order_id.clone())?;
        order.amount_out = amount_out;
        env.storage().persistent().set(&DataKey::Order(order_id.clone()), &order);

        // Deploy src escrow contract
        let escrow_factory = env.storage().instance().get::<DataKey, Address>(&DataKey::EscrowFactory)
            .ok_or(Error::InvalidCall)?;

        // Call escrow factory to deploy src escrow
        let src_escrow: Address = env.invoke_contract(
            &escrow_factory,
            &symbol_short!("deploy_src"),
            (order_id.clone(), env.current_contract_address(), order.hash_lock, security_deposit).into(),
        );

        // Move tokens to escrow
        let token_contract = Address::from_string(&String::from_utf8(order.token_in.to_vec()).unwrap());
        let token_client = token::Client::new(&env, &token_contract);
        token_client.transfer(&order.maker, &src_escrow, &(order.amount_in as i128));

        Ok(src_escrow)
    }

    pub fn get_amount_out(env: Env, order_id: Bytes) -> Result<u128, Error> {
        let order = env.storage().persistent().get::<DataKey, Order>(&DataKey::Order(order_id))
            .ok_or(Error::OrderNotFound)?;

        let start_time = order.start_time;
        let end_time = start_time + MAX_AUCTION_TIME;
        let current_time = env.ledger().timestamp().max(start_time).min(end_time);

        if end_time == start_time {
            return Ok(order.max_amount_out);
        }

        let amount_out = (order.max_amount_out * (end_time - current_time) + 
                         order.min_amount_out * (current_time - start_time)) / 
                         (end_time - start_time);

        Ok(amount_out)
    }

    pub fn set_relayer(env: Env, relayer: Address) -> Result<(), Error> {
        let owner = env.storage().instance().get::<DataKey, Address>(&DataKey::Owner)
            .ok_or(Error::NotAuthorized)?;
        
        owner.require_auth();
        env.storage().instance().set(&DataKey::Relayer, &relayer);
        Ok(())
    }

    pub fn get_hash_lock_by_order_id(env: Env, order_id: Bytes) -> Result<Bytes, Error> {
        let order = env.storage().persistent().get::<DataKey, Order>(&DataKey::Order(order_id))
            .ok_or(Error::OrderNotFound)?;
        Ok(order.hash_lock)
    }

    pub fn get_order_by_id(env: Env, order_id: Bytes) -> Result<Order, Error> {
        env.storage().persistent().get::<DataKey, Order>(&DataKey::Order(order_id))
            .ok_or(Error::OrderNotFound)
    }

    pub fn get_escrow_factory(env: Env) -> Result<Address, Error> {
        env.storage().instance().get::<DataKey, Address>(&DataKey::EscrowFactory)
            .ok_or(Error::InvalidCall)
    }
}