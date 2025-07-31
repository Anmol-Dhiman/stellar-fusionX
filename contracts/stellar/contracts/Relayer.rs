#![no_std]
use soroban_sdk::{
    contract, contractimpl, contracttype, Address, Bytes, Env, Vec, token, 
    symbol_short, Symbol
};

mod types;
use types::{DataKey, Error, OrderInput};

#[derive(Clone)]
#[contracttype]
pub struct SignalSecretShare {
    pub escrow_src: Bytes,
    pub escrow_dest: Bytes,
    pub order_id: Bytes,
    pub resolver: Address,
}

#[contract]
pub struct Relayer;

#[contractimpl]
impl Relayer {
    pub fn initialize(env: Env, owner: Address, dutch_auction: Address) {
        env.storage().instance().set(&DataKey::Owner, &owner);
        env.storage().instance().set(&DataKey::DutchAuction, &dutch_auction);
    }

    pub fn add_resolver(env: Env, resolver: Address) -> Result<(), Error> {
        let owner = env.storage().instance().get::<DataKey, Address>(&DataKey::Owner)
            .ok_or(Error::NotAuthorized)?;
        
        owner.require_auth();
        
        if resolver == Address::from_string("") {
            return Err(Error::InvalidCall);
        }

        env.storage().persistent().set(&DataKey::Resolver(resolver), &true);
        Ok(())
    }

    pub fn remove_resolver(env: Env, resolver: Address) -> Result<(), Error> {
        let owner = env.storage().instance().get::<DataKey, Address>(&DataKey::Owner)
            .ok_or(Error::NotAuthorized)?;
        
        owner.require_auth();
        
        if resolver == Address::from_string("") {
            return Err(Error::InvalidCall);
        }

        env.storage().persistent().set(&DataKey::Resolver(resolver), &false);
        Ok(())
    }

    pub fn is_resolver(env: Env, resolver: Address) -> bool {
        env.storage().persistent().get(&DataKey::Resolver(resolver)).unwrap_or(false)
    }

    pub fn place_order(env: Env, order_input: OrderInput) -> Result<(), Error> {
        let owner = env.storage().instance().get::<DataKey, Address>(&DataKey::Owner)
            .ok_or(Error::NotAuthorized)?;
        
        owner.require_auth();

        // In Soroban, we don't have the exact equivalent of ERC20 permit
        // This would need to be implemented differently, possibly with pre-authorization
        // or a different token authorization mechanism

        // For now, we'll assume the token transfer authorization is handled separately
        let dutch_auction = env.storage().instance().get::<DataKey, Address>(&DataKey::DutchAuction)
            .ok_or(Error::InvalidCall)?;

        let _: () = env.invoke_contract(
            &dutch_auction,
            &symbol_short!("start_auction"),
            (order_input,).into(),
        );

        Ok(())
    }

    pub fn move_tokens_to_escrow(
        env: Env,
        maker: Address,
        token: Address,
        src_escrow: Address,
        amount_in: u128,
    ) -> Result<(), Error> {
        let dutch_auction = env.storage().instance().get::<DataKey, Address>(&DataKey::DutchAuction)
            .ok_or(Error::NotAuthorized)?;
        
        // Only dutch auction can call this
        if env.current_contract_address() != dutch_auction {
            return Err(Error::NotAuthorized);
        }

        let token_client = token::Client::new(&env, &token);
        token_client.transfer_from(
            &env.current_contract_address(),
            &maker,
            &src_escrow,
            &(amount_in as i128)
        );

        Ok(())
    }

    pub fn signal_share_secret(
        env: Env,
        // TODO change this to stellar signature handling
        escrow_src: Bytes,
        escrow_dest: Bytes,
        order_id: Bytes,
    ) -> Result<(), Error> {
        let caller = env.current_contract_address(); // In practice, get actual caller
        
        let is_resolver = env.storage().persistent().get(&DataKey::Resolver(caller.clone()))
            .unwrap_or(false);

        if !is_resolver {
            return Err(Error::NotAuthorized);
        }

        // Emit event (in Soroban, events are published differently)
        let event_data = SignalSecretShare {
            escrow_src,
            escrow_dest,
            order_id,
            resolver: caller,
        };

        env.events().publish(
            (symbol_short!("signal"), symbol_short!("secret")),
            event_data
        );

        Ok(())
    }

    pub fn get_dutch_auction(env: Env) -> Result<Address, Error> {
        env.storage().instance().get(&DataKey::DutchAuction)
            .ok_or(Error::InvalidCall)
    }

    pub fn set_dutch_auction(env: Env, dutch_auction: Address) -> Result<(), Error> {
        let owner = env.storage().instance().get::<DataKey, Address>(&DataKey::Owner)
            .ok_or(Error::NotAuthorized)?;
        
        owner.require_auth();
        env.storage().instance().set(&DataKey::DutchAuction, &dutch_auction);
        Ok(())
    }

    pub fn get_owner(env: Env) -> Result<Address, Error> {
        env.storage().instance().get(&DataKey::Owner)
            .ok_or(Error::InvalidCall)
    }

    pub fn transfer_ownership(env: Env, new_owner: Address) -> Result<(), Error> {
        let owner = env.storage().instance().get::<DataKey, Address>(&DataKey::Owner)
            .ok_or(Error::NotAuthorized)?;
        
        owner.require_auth();
        env.storage().instance().set(&DataKey::Owner, &new_owner);
        Ok(())
    }
}