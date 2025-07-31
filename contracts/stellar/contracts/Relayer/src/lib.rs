#![no_std]

use soroban_sdk::{
    contract, contractimpl, contracttype, symbol_short, token, Address, BytesN, Env,
};

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
