use soroban_sdk::{contracttype, Address, Bytes, Env};

#[derive(Clone, Debug, Eq, PartialEq)]
#[contracttype]
pub enum Path {
    ETHToStellar,
    StellarToETH,
}

#[derive(Clone, Debug, Eq, PartialEq)]
#[contracttype]
pub struct Order {
    pub maker: Address,
    pub token_in: Bytes,  // address on eth or stellar, convert address to bytes32 if eth-stellar swap
    pub token_out: Bytes, // address on eth or stellar
    pub amount_in: u128,
    pub amount_out: u128,
    pub min_amount_out: u128,
    pub max_amount_out: u128,
    pub resolver_assigned: Option<Address>,
    pub path: Path,
    pub start_time: u64,
    pub hash_lock: Bytes,
}

#[derive(Clone, Debug, Eq, PartialEq)]
#[contracttype]
pub struct OrderInput {
    pub order_id: Bytes,
    pub maker: Address,
    pub token_in: Bytes,
    pub token_out: Bytes,
    pub amount_in: u128,
    pub min_amount_out: u128,
    pub max_amount_out: u128,
    pub hash_lock: Bytes,
    pub path: Path,
}

#[derive(Clone, Debug, Eq, PartialEq)]
#[contracttype]
pub enum DataKey {
    Order(Bytes),
    Relayer,
    EscrowFactory,
    Owner,
    Resolver(Address),
    OrderToEscrow(Bytes),
    EscrowToOrder(Address),
    SecurityDeposit,
    DutchAuction,
    DeployedAt,
    HashLockSecret,
    OrderId,
    ExecutiveResolver,
}

#[derive(Clone, Debug, Eq, PartialEq)]
#[contracttype]
pub enum Error {
    NotAuthorized = 1,
    InvalidTime = 2,
    InvalidSecret = 3,
    AuctionNotStarted = 4,
    InsufficientDeposit = 5,
    InvalidCall = 6,
    OrderNotFound = 7,
    TransferFailed = 8,
}