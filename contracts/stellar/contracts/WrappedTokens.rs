#![no_std]
use soroban_sdk::{contract, contractimpl, contracttype, token, Address, BytesN, Env};

#[contract]
pub struct WrappedTokens;

#[derive(Clone, Debug, Eq, PartialEq)]
#[contracttype]
pub enum DataKey {
    Balance(Address, Address),            // (token, user) -> balance
    Allowance(Address, Address, Address), // (token, owner, spender) -> allowance
    SignatureUsed(Address, BytesN<32>),   // (owner, hash) -> bool
}

#[contractimpl]
impl WrappedTokens {
    pub fn permit(
        env: Env,
        token: Address,
        owner: Address,
        spender: Address,
        amount: u128,
        public_key: BytesN<32>,
        signature: BytesN<64>,
        hash: BytesN<32>,
    ) {
        if Self::isSignatureUsed(env.clone(), owner.clone(), hash.clone()) {
            panic!("Invalid signature hash");
        }

        env.storage()
            .persistent()
            .set(&DataKey::SignatureUsed(owner.clone(), hash.clone()), &true);

        env.crypto()
            .ed25519_verify(&public_key, &hash.clone().into(), &signature);

        env.storage()
            .persistent()
            .set(&DataKey::Allowance(token, owner, spender), &amount);
    }

    pub fn isSignatureUsed(env: Env, owner: Address, hash_bytes: BytesN<32>) -> bool {
        let key = DataKey::SignatureUsed(owner, hash_bytes);
        env.storage().persistent().has(&key)
    }

    pub fn deposit(env: Env, token: Address, amount: u128, caller: Address) {
        caller.require_auth();

        if amount == 0 {
            panic!("Invalid Amount");
        }

        // Transfer tokens from caller to this contract
        let token_client = token::Client::new(&env, &token);
        token_client.transfer_from(
            &env.current_contract_address(),
            &caller,
            &env.current_contract_address(),
            &(amount as i128),
        );

        // Update balance
        let current_balance = Self::get_balance(env.clone(), token.clone(), caller.clone());
        let new_balance = current_balance + amount;

        env.storage()
            .persistent()
            .set(&DataKey::Balance(token, caller), &new_balance);
    }

    /// Withdraw tokens from the wrapper
    pub fn withdraw(env: Env, token: Address, amount: u128, caller: Address) {
        caller.require_auth();
        if amount == 0 {
            panic!("Invalid amount");
        }
        let current_balance = Self::get_balance(env.clone(), token.clone(), caller.clone());
        if amount > current_balance {
            panic!("Invalid balance");
        }
        // Update balance
        let new_balance = current_balance - amount;
        env.storage().persistent().set(
            &DataKey::Balance(token.clone(), caller.clone()),
            &new_balance,
        );

        // Transfer tokens from this contract to caller
        let token_client = token::Client::new(&env, &token);
        token_client.transfer(&env.current_contract_address(), &caller, &(amount as i128));
    }

    pub fn approve(env: Env, token: Address, amount: u128, to: Address, caller: Address) {
        caller.require_auth();

        let user_balance = Self::get_balance(env.clone(), token.clone(), caller.clone());

        if amount > user_balance {
            panic!("Invalid amount");
        }

        env.storage()
            .persistent()
            .set(&DataKey::Allowance(token, caller, to), &amount);
    }

    /// Transfer tokens within the wrapper (internal transfer)
    pub fn transfer(env: Env, token: Address, amount: u128, to: Address, caller: Address) {
        caller.require_auth();

        if amount == 0 {
            panic!("Invalid amount");
        }

        let sender_balance = Self::get_balance(env.clone(), token.clone(), caller.clone());

        if amount > sender_balance {
            panic!("Invalid balance");
        }

        // Update sender balance
        let new_sender_balance = sender_balance - amount;
        env.storage().persistent().set(
            &DataKey::Balance(token.clone(), caller),
            &new_sender_balance,
        );

        // Update recipient balance
        let recipient_balance = Self::get_balance(env.clone(), token.clone(), to.clone());
        let new_recipient_balance = recipient_balance + amount;
        env.storage()
            .persistent()
            .set(&DataKey::Balance(token, to), &new_recipient_balance);
    }

    /// Transfer tokens from one address to another using allowance
    pub fn transfer_from(
        env: Env,
        token: Address,
        amount: u128,
        from: Address,
        to: Address,
        caller: Address,
    ) {
        caller.require_auth();

        if amount == 0 {
            panic!("Invalid amount");
        }

        // Check allowance
        let current_allowance =
            Self::get_allowance(env.clone(), token.clone(), from.clone(), caller.clone());

        if amount > current_allowance {
            panic!("Invalid allowance");
        }

        // Check balance
        let from_balance = Self::get_balance(env.clone(), token.clone(), from.clone());

        if amount > from_balance {
            panic!("Invalid balance");
        }

        // Update allowance
        let new_allowance = current_allowance - amount;
        env.storage().persistent().set(
            &DataKey::Allowance(token.clone(), from.clone(), caller),
            &new_allowance,
        );

        // Update from balance
        let new_from_balance = from_balance - amount;
        env.storage().persistent().set(
            &DataKey::Balance(token.clone(), from.clone()),
            &new_from_balance,
        );

        // Update to balance
        let to_balance = Self::get_balance(env.clone(), token.clone(), to.clone());
        let new_to_balance = to_balance + amount;
        env.storage()
            .persistent()
            .set(&DataKey::Balance(token, to), &new_to_balance);
    }

    pub fn get_allowance(env: Env, token: Address, owner: Address, spender: Address) -> u128 {
        env.storage()
            .persistent()
            .get(&DataKey::Allowance(token, owner, spender))
            .unwrap_or(0)
    }

    pub fn get_balance(env: Env, token: Address, user: Address) -> u128 {
        env.storage()
            .persistent()
            .get(&DataKey::Balance(token, user))
            .unwrap_or(0)
    }
}
