#![no_std]
use soroban_sdk::{contract, contractimpl, contracttype, Address, Env};

mod relayer {
    soroban_sdk::contractimport!(file = "/Users/anmol/Desktop/i/College/hackathons/unidefi/main-repo/stellar-fusionX/contracts/stellar/target/wasm32v1-none/release/relayer.wasm");
}

#[contract]
pub struct DutchAuction;

#[derive(Clone, Debug, Eq, PartialEq)]
#[contracttype]
pub enum DataKey {
    Owner,         // owner address
    EscrowFactory, // escrow factory address
    Relayer,       // relayer contract address
}

// #[derive(Clone)]
// #[contracttype]
// pub struct Order {
//     pub maker: Address,
//     pub tokenIn: BytesN<32>,
//     pub tokenOut: BytesN<32>,
//     pub amountIn: u128,
//     pub amountOut: u128,
//     pub minAmountOut: u128,
//     pub maxAmountOut: u128,
//     pub resolverAssigned: Address,
//     pub startTime: u64,
//     pub hashLock: BytesN<32>,
// }

// #[derive(Clone)]
// #[contracttype]
// pub struct OrderInput {
//     pub orderId: BytesN<32>,
//     pub maker: Address,
//     pub tokenIn: BytesN<32>,
//     pub tokenOut: BytesN<32>,
//     pub amountIn: u128,
//     pub minAmountOut: u128,
//     pub maxAmountOut: u128,
//     pub hashLock: BytesN<32>,
// }

#[contractimpl]
impl DutchAuction {
    pub fn initialize(env: Env, owner: Address) {
        env.storage().persistent().set(&DataKey::Owner, &owner);
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
