#![no_std]
use soroban_sdk::{
    contract, contractimpl, contractmeta, Address, Bytes, Env, token
};

mod types;
use types::{DataKey, Error};

const SECURITY_DEPOSIT: u128 = 10_000_000; // 1 XLM in stroops (assuming XLM as security deposit)

#[contract]
pub struct EscrowFactory;

#[contractimpl]
impl EscrowFactory {
    pub fn initialize(env: Env, dutch_auction: Address, relayer: Address) {
        env.storage().instance().set(&DataKey::DutchAuction, &dutch_auction);
        env.storage().instance().set(&DataKey::Relayer, &relayer);
        env.storage().instance().set(&DataKey::SecurityDeposit, &SECURITY_DEPOSIT);
    }

    pub fn deploy_src_escrow(
        env: Env,
        order_id: Bytes,
        resolver: Address,
        hash_lock: Bytes,
        security_deposit: u128,
    ) -> Result<Address, Error> {
        let dutch_auction = env.storage().instance().get::<DataKey, Address>(&DataKey::DutchAuction)
            .ok_or(Error::NotAuthorized)?;
        
        // Only dutch auction can call this
        if env.current_contract_address() != dutch_auction {
            return Err(Error::NotAuthorized);
        }

        let required_deposit = env.storage().instance().get::<DataKey, u128>(&DataKey::SecurityDeposit)
            .unwrap_or(SECURITY_DEPOSIT);

        if security_deposit < required_deposit {
            return Err(Error::InsufficientDeposit);
        }

        // Deploy new EscrowSrc contract
        let salt = env.crypto().keccak256(&order_id);
        let escrow_src_wasm = env.deployer().get_contract_wasm(&env.current_contract_address());
        
        let escrow_src = env.deployer().with_current_contract(salt)
            .deploy(&escrow_src_wasm);

        // Initialize the escrow
        let relayer = env.storage().instance().get::<DataKey, Address>(&DataKey::Relayer)
            .ok_or(Error::InvalidCall)?;

        let _: () = env.invoke_contract(
            &escrow_src,
            &soroban_sdk::symbol_short!("init"),
            (resolver, dutch_auction, hash_lock, order_id.clone(), relayer).into(),
        );

        // Store mappings
        env.storage().persistent().set(&DataKey::OrderToEscrow(order_id), &escrow_src);
        env.storage().persistent().set(&DataKey::EscrowToOrder(escrow_src.clone()), &order_id);

        Ok(escrow_src)
    }

    pub fn deploy_dest_escrow(
        env: Env,
        order_id: Bytes,
        token_out: Address,
        amount_out: u128,
        maker: Address,
        security_deposit: u128,
    ) -> Result<Address, Error> {
        let relayer = env.storage().instance().get::<DataKey, Address>(&DataKey::Relayer)
            .ok_or(Error::NotAuthorized)?;
        
        // Check if caller is a resolver
        let caller = env.current_contract_address(); // In practice, get actual caller
        let is_resolver: bool = env.invoke_contract(
            &relayer,
            &soroban_sdk::symbol_short!("is_resolver"),
            (caller.clone(),).into(),
        );

        if !is_resolver {
            return Err(Error::NotAuthorized);
        }

        let required_deposit = env.storage().instance().get::<DataKey, u128>(&DataKey::SecurityDeposit)
            .unwrap_or(SECURITY_DEPOSIT);

        if security_deposit < required_deposit {
            return Err(Error::InsufficientDeposit);
        }

        // Get hash lock from dutch auction
        let dutch_auction = env.storage().instance().get::<DataKey, Address>(&DataKey::DutchAuction)
            .ok_or(Error::InvalidCall)?;

        let hash_lock: Bytes = env.invoke_contract(
            &dutch_auction,
            &soroban_sdk::symbol_short!("get_hash_lock"),
            (order_id.clone(),).into(),
        );

        // Deploy new EscrowDest contract
        let salt = env.crypto().keccak256(&order_id);
        let escrow_dest_wasm = env.deployer().get_contract_wasm(&env.current_contract_address());
        
        let escrow_dest = env.deployer().with_current_contract(salt)
            .deploy(&escrow_dest_wasm);

        // Initialize the escrow
        let _: () = env.invoke_contract(
            &escrow_dest,
            &soroban_sdk::symbol_short!("init"),
            (caller, dutch_auction, hash_lock, order_id.clone(), relayer, token_out, amount_out, maker).into(),
        );

        // Store mappings
        env.storage().persistent().set(&DataKey::OrderToEscrow(order_id), &escrow_dest);
        env.storage().persistent().set(&DataKey::EscrowToOrder(escrow_dest.clone()), &order_id);

        Ok(escrow_dest)
    }