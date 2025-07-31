use soroban_sdk::{contractclient, Address, Bytes, Env};

use crate::types::{Order, OrderInput, Error};

// Dutch Auction Interface
#[contractclient(name = "DutchAuctionClient")]
pub trait DutchAuctionInterface {
    fn initialize(env: Env, owner: Address, escrow_factory: Address);
    fn start_auction(env: Env, order_input: OrderInput) -> Result<(), Error>;
    fn fill_order(env: Env, order_id: Bytes, security_deposit: u128) -> Result<Address, Error>;
    fn get_amount_out(env: Env, order_id: Bytes) -> Result<u128, Error>;
    fn set_relayer(env: Env, relayer: Address) -> Result<(), Error>;
    fn get_hash_lock_by_order_id(env: Env, order_id: Bytes) -> Result<Bytes, Error>;
    fn get_order_by_id(env: Env, order_id: Bytes) -> Result<Order, Error>;
    fn get_escrow_factory(env: Env) -> Result<Address, Error>;
}

// Base Escrow Interface
#[contractclient(name = "EscrowClient")]
pub trait EscrowInterface {
    fn withdraw(env: Env, secret: Bytes) -> Result<(), Error>;
    fn cancel(env: Env) -> Result<(), Error>;
}

// Extended Escrow Interface for Src
#[contractclient(name = "EscrowSrcClient")]
pub trait EscrowSrcInterface: EscrowInterface {
    fn initialize(
        env: Env,
        resolver: Address,
        dutch_auction: Address,
        hash_lock_secret: Bytes,
        order_id: Bytes,
        relayer: Address,
    );
    fn public_withdraw(env: Env, secret: Bytes) -> Result<(), Error>;
    fn public_cancel(env: Env) -> Result<(), Error>;
}

// Extended Escrow Interface for Dest
#[contractclient(name = "EscrowDestClient")]
pub trait EscrowDestInterface: EscrowInterface {
    fn initialize(
        env: Env,
        resolver: Address,
        dutch_auction: Address,
        hash_lock_secret: Bytes,
        order_id: Bytes,
        relayer: Address,
        token_out: Address,
        amount_out: u128,
        maker: Address,
    );
    fn public_withdraw(env: Env, secret: Bytes) -> Result<(), Error>;
}

// Escrow Factory Interface
#[contractclient(name = "EscrowFactoryClient")]
pub trait EscrowFactoryInterface {
    fn initialize(env: Env, dutch_auction: Address, relayer: Address);
    fn deploy_src_escrow(
        env: Env,
        order_id: Bytes,
        resolver: Address,
        hash_lock: Bytes,
        security_deposit: u128,
    ) -> Result<Address, Error>;
    fn deploy_dest_escrow(
        env: Env,
        order_id: Bytes,
        token_out: Address,
        amount_out: u128,
        maker: Address,
        security_deposit: u128,
    ) -> Result<Address, Error>;
    fn get_escrow_by_order(env: Env, order_id: Bytes) -> Option<Address>;
    fn get_order_by_escrow(env: Env, escrow: Address) -> Option<Bytes>;
    fn get_security_deposit(env: Env) -> u128;
    fn set_security_deposit(env: Env, amount: u128) -> Result<(), Error>;
}

// Relayer Interface
#[contractclient(name = "RelayerClient")]
pub trait RelayerInterface {
    fn initialize(env: Env, owner: Address, dutch_auction: Address);
    fn add_resolver(env: Env, resolver: Address) -> Result<(), Error>;
    fn remove_resolver(env: Env, resolver: Address) -> Result<(), Error>;
    fn is_resolver(env: Env, resolver: Address) -> bool;
    fn place_order(env: Env, order_input: OrderInput) -> Result<(), Error>;
    fn move_tokens_to_escrow(
        env: Env,
        maker: Address,
        token: Address,
        src_escrow: Address,
        amount_in: u128,
    ) -> Result<(), Error>;
    fn signal_share_secret(
        env: Env,
        escrow_src: Bytes,
        escrow_dest: Bytes,
        order_id: Bytes,
    ) -> Result<(), Error>;
    fn get_dutch_auction(env: Env) -> Result<Address, Error>;
    fn set_dutch_auction(env: Env, dutch_auction: Address) -> Result<(), Error>;
    fn get_owner(env: Env) -> Result<Address, Error>;
    fn transfer_ownership(env: Env, new_owner: Address) -> Result<(), Error>;
}

// Resolver Interface
#[contractclient(name = "ResolverClient")]
pub trait ResolverInterface {
    fn initialize(
        env: Env,
        owner: Address,
        dutch_auction: Address,
        relayer: Address,
        escrow_factory: Address,
    );
    fn deploy_src(env: Env, order_id: Bytes, security_deposit: u128) -> Result<Address, Error>;
    fn deploy_dest(
        env: Env,
        order_id: Bytes,
        token: Address,
        amount: u128,
        maker: Address,
        security_deposit: u128,
    ) -> Result<Address, Error>;
    fn withdraw(env: Env, escrow: Address, secret: Bytes) -> Result<(), Error>;
    fn cancel(env: Env, escrow: Address) -> Result<(), Error>;
    fn public_withdraw(env: Env, escrow: Address, secret: Bytes) -> Result<(), Error>;
    fn public_cancel(env: Env, escrow: Address) -> Result<(), Error>;
    fn notify_relayer(
        env: Env,
        escrow_src: Bytes,
        escrow_dest: Bytes,
        order_id: Bytes,
    ) -> Result<(), Error>;
    fn get_dutch_auction(env: Env) -> Result<Address, Error>;
    fn get_relayer(env: Env) -> Result<Address, Error>;
    fn get_escrow_factory(env: Env) -> Result<Address, Error>;
    fn get_owner(env: Env) -> Result<Address, Error>;
    fn transfer_ownership(env: Env, new_owner: Address) -> Result<(), Error>;
}