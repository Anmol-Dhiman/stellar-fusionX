#![no_std]

pub mod types;
pub mod interfaces;

// Re-export main contracts
pub mod dutch_auction;
pub mod escrow_contracts;
pub mod escrow_factory;
pub mod relayer;
pub mod resolver;

// Re-export types for convenience
pub use types::{DataKey, Error, Order, OrderInput, Path};

// Re-export contract clients
pub use interfaces::{
    DutchAuctionClient, EscrowClient, EscrowDestClient, EscrowFactoryClient, 
    EscrowSrcClient, RelayerClient, ResolverClient
};

// Re-export contracts
pub use dutch_auction::DutchAuction;
pub use escrow_contracts::{EscrowDest, EscrowSrc};
pub use escrow_factory::EscrowFactory;
pub use relayer::Relayer;
pub use resolver::Resolver;