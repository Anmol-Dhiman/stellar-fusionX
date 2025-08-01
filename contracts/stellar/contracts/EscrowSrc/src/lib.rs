#![no_std]
use soroban_sdk::{
    contract, contractimpl, contracttype, crypto::Hash, token, Address, Bytes, BytesN, Env, String,
};
mod relayer {
    soroban_sdk::contractimport!(file = "/Users/anmol/Desktop/i/College/hackathons/unidefi/main-repo/stellar-fusionX/contracts/stellar/target/wasm32v1-none/release/relayer.wasm");
}

#[contract]
pub struct EscrowSrc;

#[derive(Clone, Debug, Eq, PartialEq)]
#[contracttype]
pub enum DataKey {
    DeployedAt,        // Timestamp when the contract was deployed
    HashLock,          // Hash lock for the escrow
    OrderId,           // Order ID associated with the escrow
    ExecutiveResolver, // Address of the executive resolver
    Relayer,           // Address of the relayer contract
    TokenIn,           // Address of the token to be released
    AmountIn,          // Amount of tokens to be released
    Maker,             // Address of the maker
}

const SRC_FINALITY_LOCK: u128 = 2 * 60;
const SRC_RESOLVER_UNLOCK_PERIOD: u128 = SRC_FINALITY_LOCK + 4 * 60;
const SRC_ANYONE_UNLOCK_PERIOD: u128 = SRC_RESOLVER_UNLOCK_PERIOD + 4 * 60;
const SRC_RESOLVER_CANCEL: u128 = SRC_ANYONE_UNLOCK_PERIOD + 2 * 60;

#[contractimpl]
impl EscrowSrc {
    pub fn initialize(
        env: Env,
        order_id: BytesN<32>,
        hash_lock: BytesN<32>,
        token_in: Address,
        amount_in: u128,
        maker: Address,
        executive_resolver: Address,
        relayer: Address,
    ) {
        let deployed_at: u128 = env.ledger().timestamp().into();
        env.storage()
            .persistent()
            .set(&DataKey::DeployedAt, &deployed_at);
        env.storage()
            .persistent()
            .set(&DataKey::HashLock, &hash_lock);
        env.storage().persistent().set(&DataKey::OrderId, &order_id);
        env.storage().persistent().set(&DataKey::TokenIn, &token_in);

        env.storage()
            .persistent()
            .set(&DataKey::AmountIn, &amount_in);
        env.storage().persistent().set(&DataKey::Maker, &maker);
        env.storage()
            .persistent()
            .set(&DataKey::ExecutiveResolver, &executive_resolver);

        env.storage().persistent().set(&DataKey::Relayer, &relayer);
    }

    pub fn withdraw(env: Env, secret: BytesN<32>, caller: Address) {
        caller.require_auth();
        Self::onlyAfter(env.clone(), SRC_FINALITY_LOCK);
        Self::onlyBefore(env.clone(), SRC_RESOLVER_UNLOCK_PERIOD);
        Self::validateSecret(env.clone(), secret);
        Self::onlyExecutiveResolver(env.clone(), caller.clone());
        Self::withdraw_token(
            env.clone(),
            Self::get_token_in(env.clone()),
            caller.clone(),
            Self::get_amount_in(env.clone()),
        );
        Self::transfer_security_deposit(env.clone(), caller.clone());
    }

    pub fn public_withdraw(env: Env, secret: BytesN<32>, caller: Address) {
        Self::onlyAfter(env.clone(), SRC_RESOLVER_UNLOCK_PERIOD);
        Self::onlyBefore(env.clone(), SRC_ANYONE_UNLOCK_PERIOD);
        Self::validateSecret(env.clone(), secret);
        Self::only_resolver(env.clone(), caller.clone());
        Self::withdraw_token(
            env.clone(),
            Self::get_token_in(env.clone()),
            Self::get_executive_resolver(env.clone()),
            Self::get_amount_in(env.clone()),
        );
        Self::transfer_security_deposit(env.clone(), caller.clone());
    }

    pub fn cancel(env: Env, caller: Address) {
        Self::onlyAfter(env.clone(), SRC_ANYONE_UNLOCK_PERIOD);
        Self::onlyBefore(env.clone(), SRC_RESOLVER_CANCEL);
        Self::onlyExecutiveResolver(env.clone(), caller.clone());

        Self::withdraw_token(
            env.clone(),
            Self::get_token_in(env.clone()),
            Self::get_maker(env.clone()),
            Self::get_amount_in(env.clone()),
        );
        Self::transfer_security_deposit(env.clone(), caller.clone());
    }
    pub fn public_cancel(env: Env, caller: Address) {
        Self::onlyAfter(env.clone(), SRC_RESOLVER_CANCEL);
        Self::only_resolver(env.clone(), caller.clone());
        Self::withdraw_token(
            env.clone(),
            Self::get_token_in(env.clone()),
            Self::get_maker(env.clone()),
            Self::get_amount_in(env.clone()),
        );
        Self::transfer_security_deposit(env.clone(), caller.clone());
    }

    // internal functions
    fn withdraw_token(env: Env, token: Address, to: Address, amount: u128) {
        let token_client = token::Client::new(&env, &token);
        token_client.transfer(&env.current_contract_address(), &to, &(amount as i128));
    }

    fn transfer_security_deposit(env: Env, to: Address) {
        let native_token_contract_id: Address = Address::from_string(&String::from_str(
            &env,
            "CDLZFC3SYJYDZT7K67VZ75HPJVIEUVNIXF47ZG2FB2RMQQVU2HHGCYSC",
        ));

        let token_client = token::Client::new(&env, &native_token_contract_id);

        // Get contract's own address as sender
        let from_addr = env.current_contract_address();

        // Check the full balance of wrapped XLM the contract holds
        let balance = token_client.balance(&from_addr);

        if balance > 0 {
            // Transfer full balance to recipient 'to'
            token_client.transfer(&from_addr, &to, &balance);
        }
    }

    fn get_token_in(env: Env) -> Address {
        env.storage().persistent().get(&DataKey::TokenIn).unwrap()
    }
    fn get_amount_in(env: Env) -> u128 {
        env.storage().persistent().get(&DataKey::AmountIn).unwrap()
    }
    fn get_maker(env: Env) -> Address {
        env.storage().persistent().get(&DataKey::Maker).unwrap()
    }

    fn get_executive_resolver(env: Env) -> Address {
        env.storage()
            .persistent()
            .get(&DataKey::ExecutiveResolver)
            .unwrap()
    }

    fn validateSecret(env: Env, secret: BytesN<32>) {
        let hash_lock: BytesN<32> = env.storage().persistent().get(&DataKey::HashLock).unwrap();
        let _secret: Bytes = secret.into();
        let secret_bytes: BytesN<32> = env.crypto().keccak256(&_secret).into();
        if hash_lock != secret_bytes {
            panic!("Invalid secret");
        }
    }

    fn onlyExecutiveResolver(env: Env, caller: Address) {
        let executive_resolver: Address = env
            .storage()
            .persistent()
            .get(&DataKey::ExecutiveResolver)
            .unwrap();
        if caller != executive_resolver {
            panic!("Unauthorized caller");
        }
    }
    fn onlyAfter(env: Env, start: u128) {
        let deployed_at: u128 = env
            .storage()
            .persistent()
            .get(&DataKey::DeployedAt)
            .unwrap_or(0);
        let block_timestamp: u128 = env.ledger().timestamp().into();
        if block_timestamp < deployed_at + start {
            panic!("Invalid time");
        }
    }
    fn onlyBefore(env: Env, stop: u128) {
        let deployed_at: u128 = env
            .storage()
            .persistent()
            .get(&DataKey::DeployedAt)
            .unwrap_or(0);
        let block_timestamp: u128 = env.ledger().timestamp().into();
        if block_timestamp >= deployed_at + stop {
            panic!("Invalid time");
        }
    }

    fn only_resolver(env: Env, caller: Address) {
        let relayer = relayer::Client::new(&env.clone(), &Self::get_relayer(env));
        let value = relayer.is_resolver(&caller);
        if !value {
            panic!("Only resolvers can call this function");
        }
    }

    //     public getters
    pub fn get_relayer(env: Env) -> Address {
        env.storage().persistent().get(&DataKey::Relayer).unwrap()
    }
}
