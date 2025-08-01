#![no_std]

use soroban_sdk::xdr::FromXdr;
use soroban_sdk::{
    contract, contractimpl, contracttype, symbol_short, token, Address, BytesN, Env,
};

mod dutch_auction {
    soroban_sdk::contractimport!(file = "/Users/anmol/Desktop/i/College/hackathons/unidefi/main-repo/stellar-fusionX/contracts/stellar/target/wasm32v1-none/release/dutchauction.wasm");
}

mod wrapped_tokens {
    soroban_sdk::contractimport!(file = "/Users/anmol/Desktop/i/College/hackathons/unidefi/main-repo/stellar-fusionX/contracts/stellar/target/wasm32v1-none/release/wrappedtoken.wasm");
}

#[derive(Clone, Debug, Eq, PartialEq)]
#[contracttype]
pub enum DataKey {
    Resolvers(Address), // address -> bool whitelisted resolvers
    DutchAuction,       // dutch auction contract address
    Owner,              // owner address
}

#[derive(Clone)]
#[contracttype]
pub struct SignalSecretShare {
    pub escrow_src: BytesN<32>,
    pub escrow_dest: BytesN<32>,
    pub order_id: BytesN<32>,
    pub resolver: Address,
}


#[derive(Clone)]
#[contracttype]
pub struct OrderInput {
    pub orderId: BytesN<32>,
    pub maker: Address,
    pub tokenIn: BytesN<32>,
    pub tokenOut: BytesN<32>,
    pub amountIn: u128,
    pub minAmountOut: u128,
    pub maxAmountOut: u128,
    pub hashLock: BytesN<32>,
}



#[contract]
pub struct Relayer;

#[contractimpl]
impl Relayer {
    pub fn initialize(env: Env, owner: Address, dutch_auction: Address) {
        env.storage().persistent().set(&DataKey::Owner, &owner);
        env.storage()
            .persistent()
            .set(&DataKey::DutchAuction, &dutch_auction);
    }

    pub fn add_resolver(env: Env, resolver: Address) {
        Self::only_owner(env.clone());

        env.storage()
            .persistent()
            .set(&DataKey::Resolvers(resolver), &true);
    }

    pub fn remove_resolver(env: Env, resolver: Address) {
        Self::only_owner(env.clone());
        env.storage()
            .persistent()
            .set(&DataKey::Resolvers(resolver), &false);
    }

    pub fn is_resolver(env: Env, resolver: Address) -> bool {
        env.storage()
            .persistent()
            .get(&DataKey::Resolvers(resolver))
            .unwrap_or(false)
    }

    pub fn place_order(
        env: Env,
        order_input: dutch_auction::OrderInput,
        public_key: BytesN<32>,
        signature: BytesN<64>,
        hash: BytesN<32>,
    ) {
        Self::only_owner(env.clone());
        let token_in = Self::bytesn32_to_address(env.clone(), order_input.tokenIn.clone());
        let _wrappedtoken = wrapped_tokens::Client::new(&env.clone(), &token_in);
        _wrappedtoken.permit(
            &token_in,
            &order_input.maker.clone(),
            &env.current_contract_address(),
            &order_input.amountIn,
            &public_key,
            &signature,
            &hash,
        );

        // start dutch auction
        let _dutch_auction =
            dutch_auction::Client::new(&env.clone(), &Self::get_dutch_auction(env.clone()));
        _dutch_auction.start_auction(&order_input);
    }

    fn bytesn32_to_address(env: Env, bytes: BytesN<32>) -> Address {
        Address::from_xdr(&env, &bytes.into()).unwrap()
    }
    pub fn move_tokens_to_escrow(
        env: Env,
        maker: Address,
        token: Address,
        src_escrow: Address,
        amount_in: u128,
    ) {
        let dutch_auction = Self::get_dutch_auction(env.clone());
        dutch_auction.require_auth();

        let token_client = token::Client::new(&env, &token);
        token_client.transfer_from(
            &env.current_contract_address(),
            &maker,
            &src_escrow,
            &(amount_in as i128),
        );
    }

    pub fn signal_share_secret(
        env: Env,
        escrow_src: BytesN<32>,
        escrow_dest: BytesN<32>,
        order_id: BytesN<32>,
        resolver: Address,
    ) {
        resolver.require_auth();

        let event_data = SignalSecretShare {
            escrow_src,
            escrow_dest,
            order_id,
            resolver,
        };

        env.events().publish(
            (symbol_short!("signal"), symbol_short!("secret")),
            event_data,
        );
    }

    pub fn get_owner(env: Env) -> Address {
        env.storage().persistent().get(&DataKey::Owner).unwrap()
    }

    pub fn set_dutch_auction(env: Env, dutch_auction: Address) {
        Self::only_owner(env.clone());
        env.storage()
            .persistent()
            .set(&DataKey::DutchAuction, &dutch_auction);
    }

    fn only_owner(env: Env) {
        let owner = Self::get_owner(env);
        owner.require_auth();
    }

    pub fn get_dutch_auction(env: Env) -> Address {
        env.storage()
            .persistent()
            .get(&DataKey::DutchAuction)
            .unwrap()
    }

    pub fn transfer_ownership(env: Env, new_owner: Address) {
        Self::only_owner(env.clone());
        env.storage().persistent().set(&DataKey::Owner, &new_owner);
    }
}
