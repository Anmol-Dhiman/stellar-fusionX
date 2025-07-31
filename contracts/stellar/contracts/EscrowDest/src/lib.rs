// #![no_std]
// use soroban_sdk::{
//     contract, contractimpl, Address, Bytes, Env, token, crypto::Hash
// };

// mod types;
// use types::{DataKey, Error, Order};

// // Base Escrow functionality
// pub struct BaseEscrow;

// impl BaseEscrow {
//     pub fn initialize_base(
//         env: &Env,
//         resolver: Address,
//         dutch_auction: Address,
//         hash_lock_secret: Bytes,
//         order_id: Bytes,
//         relayer: Address,
//     ) {
//         env.storage().instance().set(&DataKey::DeployedAt, &env.ledger().timestamp());
//         env.storage().instance().set(&DataKey::HashLockSecret, &hash_lock_secret);
//         env.storage().instance().set(&DataKey::OrderId, &order_id);
//         env.storage().instance().set(&DataKey::ExecutiveResolver, &resolver);
//         env.storage().instance().set(&DataKey::DutchAuction, &dutch_auction);
//         env.storage().instance().set(&DataKey::Relayer, &relayer);
//     }

//     pub fn check_time_after(env: &Env, start: u64) -> Result<(), Error> {
//         let deployed_at = env.storage().instance().get::<DataKey, u64>(&DataKey::DeployedAt)
//             .ok_or(Error::InvalidTime)?;
        
//         if env.ledger().timestamp() < deployed_at + start {
//             return Err(Error::InvalidTime);
//         }
//         Ok(())
//     }

//     pub fn check_time_before(env: &Env, stop: u64) -> Result<(), Error> {
//         let deployed_at = env.storage().instance().get::<DataKey, u64>(&DataKey::DeployedAt)
//             .ok_or(Error::InvalidTime)?;
        
//         if env.ledger().timestamp() >= deployed_at + stop {
//             return Err(Error::InvalidTime);
//         }
//         Ok(())
//     }

//     pub fn check_valid_secret(env: &Env, secret: Bytes) -> Result<(), Error> {
//         let hash_lock_secret = env.storage().instance().get::<DataKey, Bytes>(&DataKey::HashLockSecret)
//             .ok_or(Error::InvalidSecret)?;
        
//         let secret_hash = env.crypto().keccak256(&secret);
//         if secret_hash.to_bytes() != hash_lock_secret {
//             return Err(Error::InvalidSecret);
//         }
//         Ok(())
//     }

//     pub fn check_relayer(env: &Env, caller: &Address) -> Result<(), Error> {
//         let relayer = env.storage().instance().get::<DataKey, Address>(&DataKey::Relayer)
//             .ok_or(Error::NotAuthorized)?;
        
//         if *caller != relayer {
//             return Err(Error::NotAuthorized);
//         }
//         Ok(())
//     }

//     pub fn check_resolver(env: &Env, caller: &Address) -> Result<(), Error> {
//         let relayer = env.storage().instance().get::<DataKey, Address>(&DataKey::Relayer)
//             .ok_or(Error::NotAuthorized)?;
        
//         // Check if caller is a resolver through relayer contract
//         let is_resolver: bool = env.invoke_contract(
//             &relayer,
//             &soroban_sdk::symbol_short!("is_resolver"),
//             (*caller,).into(),
//         );
        
//         if !is_resolver {
//             return Err(Error::NotAuthorized);
//         }
//         Ok(())
//     }

//     pub fn check_executive_resolver(env: &Env, caller: &Address) -> Result<(), Error> {
//         let executive_resolver = env.storage().instance().get::<DataKey, Address>(&DataKey::ExecutiveResolver)
//             .ok_or(Error::NotAuthorized)?;
        
//         if *caller != executive_resolver {
//             return Err(Error::NotAuthorized);
//         }
//         Ok(())
//     }

//     pub fn withdraw_token(env: &Env, token: Address, to: Address, amount: u128) {
//         let token_client = token::Client::new(env, &token);
//         token_client.transfer(&env.current_contract_address(), &to, &(amount as i128));
//     }

//     pub fn transfer_security_deposit(env: &Env, to: Address) {
//         // In Soroban, we would handle native token (XLM) transfers differently
//         // This is a simplified version - actual implementation would depend on 
//         // how security deposits are handled in Soroban
//         let balance = env.current_contract_address().balance();
//         if balance > 0 {
//             to.transfer(&balance);
//         }
//     }
// }

// #[contract]
// pub struct EscrowDest;

// const FINALITY_LOCK: u64 = 2 * 60; // 2 minutes
// const RESOLVER_UNLOCK_PERIOD: u64 = FINALITY_LOCK + 2 * 60; // 4 minutes total
// const ANYONE_UNLOCK_PERIOD: u64 = RESOLVER_UNLOCK_PERIOD + 2 * 60; // 6 minutes total

// #[contractimpl]
// impl EscrowDest {
//     pub fn initialize(
//         env: Env,
//         resolver: Address,
//         dutch_auction: Address,
//         hash_lock_secret: Bytes,
//         order_id: Bytes,
//         relayer: Address,
//         token_out: Address,
//         amount_out: u128,
//         maker: Address,
//     ) {
//         BaseEscrow::initialize_base(&env, resolver, dutch_auction, hash_lock_secret, order_id, relayer);
//         env.storage().instance().set(&DataKey::TokenOut, &token_out);
//         env.storage().instance().set(&DataKey::AmountOut, &amount_out);
//         env.storage().instance().set(&DataKey::Maker, &maker);
//     }

//     pub fn withdraw(env: Env, secret: Bytes) -> Result<(), Error> {
//         let caller = env.current_contract_address(); // In practice, get actual caller
        
//         BaseEscrow::check_time_after(&env, FINALITY_LOCK)?;
//         BaseEscrow::check_time_before(&env, RESOLVER_UNLOCK_PERIOD)?;
//         BaseEscrow::check_valid_secret(&env, secret)?;
//         BaseEscrow::check_executive_resolver(&env, &caller)?;

//         let token_out = env.storage().instance().get::<DataKey, Address>(&DataKey::TokenOut)
//             .ok_or(Error::InvalidCall)?;
//         let amount_out = env.storage().instance().get::<DataKey, u128>(&DataKey::AmountOut)
//             .ok_or(Error::InvalidCall)?;
//         let maker = env.storage().instance().get::<DataKey, Address>(&DataKey::Maker)
//             .ok_or(Error::InvalidCall)?;

//         BaseEscrow::withdraw_token(&env, token_out, maker, amount_out);
//         BaseEscrow::transfer_security_deposit(&env, caller);
//         Ok(())
//     }

//     pub fn public_withdraw(env: Env, secret: Bytes) -> Result<(), Error> {
//         let caller = env.current_contract_address(); // In practice, get actual caller
        
//         BaseEscrow::check_resolver(&env, &caller)?;
//         BaseEscrow::check_time_after(&env, RESOLVER_UNLOCK_PERIOD)?;
//         BaseEscrow::check_time_before(&env, ANYONE_UNLOCK_PERIOD)?;
//         BaseEscrow::check_valid_secret(&env, secret)?;

//         let token_out = env.storage().instance().get::<DataKey, Address>(&DataKey::TokenOut)
//             .ok_or(Error::InvalidCall)?;
//         let amount_out = env.storage().instance().get::<DataKey, u128>(&DataKey::AmountOut)
//             .ok_or(Error::InvalidCall)?;
//         let maker = env.storage().instance().get::<DataKey, Address>(&DataKey::Maker)
//             .ok_or(Error::InvalidCall)?;

//         BaseEscrow::withdraw_token(&env, token_out, maker, amount_out);
//         BaseEscrow::transfer_security_deposit(&env, caller);
//         Ok(())
//     }

//     pub fn cancel(env: Env) -> Result<(), Error> {
//         let caller = env.current_contract_address(); // In practice, get actual caller
        
//         BaseEscrow::check_time_after(&env, ANYONE_UNLOCK_PERIOD)?;
//         BaseEscrow::check_executive_resolver(&env, &caller)?;

//         let token_out = env.storage().instance().get::<DataKey, Address>(&DataKey::TokenOut)
//             .ok_or(Error::InvalidCall)?;
//         let amount_out = env.storage().instance().get::<DataKey, u128>(&DataKey::AmountOut)
//             .ok_or(Error::InvalidCall)?;

//         BaseEscrow::withdraw_token(&env, token_out, caller, amount_out);
//         BaseEscrow::transfer_security_deposit(&env, caller);
//         Ok(())
//     }
// }

// #[contract]
// pub struct EscrowSrc;

// const SRC_FINALITY_LOCK: u64 = 2 * 60; // 2 minutes
// const SRC_RESOLVER_UNLOCK_PERIOD: u64 = SRC_FINALITY_LOCK + 4 * 60; // 6 minutes total
// const SRC_ANYONE_UNLOCK_PERIOD: u64 = SRC_RESOLVER_UNLOCK_PERIOD + 4 * 60; // 10 minutes total
// const SRC_RESOLVER_CANCEL: u64 = SRC_ANYONE_UNLOCK_PERIOD + 2 * 60; // 12 minutes total
// const SRC_ANYONE_CANCEL: u64 = SRC_RESOLVER_CANCEL + 2 * 60; // 14 minutes total

// #[contractimpl]
// impl EscrowSrc {
//     pub fn initialize(
//         env: Env,
//         resolver: Address,
//         dutch_auction: Address,
//         hash_lock_secret: Bytes,
//         order_id: Bytes,
//         relayer: Address,
//     ) {
//         BaseEscrow::initialize_base(&env, resolver, dutch_auction, hash_lock_secret, order_id, relayer);
//     }

//     pub fn withdraw(env: Env, secret: Bytes) -> Result<(), Error> {
//         let caller = env.current_contract_address(); // In practice, get actual caller
        
//         BaseEscrow::check_time_after(&env, SRC_FINALITY_LOCK)?;
//         BaseEscrow::check_time_before(&env, SRC_RESOLVER_UNLOCK_PERIOD)?;
//         BaseEscrow::check_valid_secret(&env, secret)?;
//         BaseEscrow::check_executive_resolver(&env, &caller)?;

//         let order_id = env.storage().instance().get::<DataKey, Bytes>(&DataKey::OrderId)
//             .ok_or(Error::InvalidCall)?;
//         let dutch_auction = env.storage().instance().get::<DataKey, Address>(&DataKey::DutchAuction)
//             .ok_or(Error::InvalidCall)?;

//         let order: Order = env.invoke_contract(
//             &dutch_auction,
//             &soroban_sdk::symbol_short!("get_order"),
//             (order_id,).into(),
//         );

//         let token_in = Address::from_string(&String::from_utf8(order.token_in.to_vec()).unwrap());
//         BaseEscrow::withdraw_token(&env, token_in, caller.clone(), order.amount_in);
//         BaseEscrow::transfer_security_deposit(&env, caller);
//         Ok(())
//     }

//     pub fn public_withdraw(env: Env, secret: Bytes) -> Result<(), Error> {
//         let caller = env.current_contract_address(); // In practice, get actual caller
        
//         BaseEscrow::check_resolver(&env, &caller)?;
//         BaseEscrow::check_time_after(&env, SRC_RESOLVER_UNLOCK_PERIOD)?;
//         BaseEscrow::check_time_before(&env, SRC_ANYONE_UNLOCK_PERIOD)?;
//         BaseEscrow::check_valid_secret(&env, secret)?;

//         let order_id = env.storage().instance().get::<DataKey, Bytes>(&DataKey::OrderId)
//             .ok_or(Error::InvalidCall)?;
//         let dutch_auction = env.storage().instance().get::<DataKey, Address>(&DataKey::DutchAuction)
//             .ok_or(Error::InvalidCall)?;
//         let executive_resolver = env.storage().instance().get::<DataKey, Address>(&DataKey::ExecutiveResolver)
//             .ok_or(Error::InvalidCall)?;

//         let order: Order = env.invoke_contract(
//             &dutch_auction,
//             &soroban_sdk::symbol_short!("get_order"),
//             (order_id,).into(),
//         );

//         let token_in = Address::from_string(&String::from_utf8(order.token_in.to_vec()).unwrap());
//         BaseEscrow::withdraw_token(&env, token_in, executive_resolver, order.amount_in);
//         BaseEscrow::transfer_security_deposit(&env, caller);
//         Ok(())
//     }

//     pub fn cancel(env: Env) -> Result<(), Error> {
//         let caller = env.current_contract_address(); // In practice, get actual caller
        
//         BaseEscrow::check_time_after(&env, SRC_ANYONE_UNLOCK_PERIOD)?;
//         BaseEscrow::check_time_before(&env, SRC_RESOLVER_CANCEL)?;
//         BaseEscrow::check_executive_resolver(&env, &caller)?;

//         let order_id = env.storage().instance().get::<DataKey, Bytes>(&DataKey::OrderId)
//             .ok_or(Error::InvalidCall)?;
//         let dutch_auction = env.storage().instance().get::<DataKey, Address>(&DataKey::DutchAuction)
//             .ok_or(Error::InvalidCall)?;

//         let order: Order = env.invoke_contract(
//             &dutch_auction,
//             &soroban_sdk::symbol_short!("get_order"),
//             (order_id,).into(),
//         );

//         let token_in = Address::from_string(&String::from_utf8(order.token_in.to_vec()).unwrap());
//         BaseEscrow::withdraw_token(&env, token_in, order.maker, order.amount_in);
//         BaseEscrow::transfer_security_deposit(&env, caller);
//         Ok(())
//     }

//     pub fn public_cancel(env: Env) -> Result<(), Error> {
//         let caller = env.current_contract_address(); // In practice, get actual caller
        
//         BaseEscrow::check_resolver(&env, &caller)?;
//         BaseEscrow::check_time_before(&env, SRC_RESOLVER_CANCEL)?;

//         let order_id = env.storage().instance().get::<DataKey, Bytes>(&DataKey::OrderId)
//             .ok_or(Error::InvalidCall)?;
//         let dutch_auction = env.storage().instance().get::<DataKey, Address>(&DataKey::DutchAuction)
//             .ok_or(Error::InvalidCall)?;

//         let order: Order = env.invoke_contract(
//             &dutch_auction,
//             &soroban_sdk::symbol_short!("get_order"),
//             (order_id,).into(),
//         );

//         let token_in = Address::from_string(&String::from_utf8(order.token_in.to_vec()).unwrap());
//         BaseEscrow::withdraw_token(&env, token_in, order.maker, order.amount_in);
//         BaseEscrow::transfer_security_deposit(&env, caller);
//         Ok(())
//     }
// }