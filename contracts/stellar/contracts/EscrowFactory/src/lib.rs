#![no_std]
use soroban_sdk::{
    contract, contractimpl, contracttype, crypto::Hash, token, Address, Bytes, BytesN, Env, String,
};

const SECURITY_DEPOSIT: u128 = 500_000_000; // 1 XLM in stroops (assuming XLM as security deposit)

mod escrow_src {
    soroban_sdk::contractimport!(file = "G:\\EthUnite\\stellar-fusionX\\contracts\\stellar\\target\\wasm32v1-none\\release\\escrowsrc.wasm");
    pub type EscrowSrcClient<'a> = Client<'a>;
}
use escrow_src::EscrowSrcClient;

mod escrow_dest {
    soroban_sdk::contractimport!(file = "G:\\EthUnite\\stellar-fusionX\\contracts\\stellar\\target\\wasm32v1-none\\release\\escrowdest.wasm");
    pub type EscrowDestClient<'a> = Client<'a>;
}
use escrow_dest::EscrowDestClient;

#[contract]
pub struct EscrowFactory;

#[derive(Clone, Debug, Eq, PartialEq)]
#[contracttype]
pub enum DataKey {
    DutchAuction,
    Relayer,
    OrderIdToEscrow(BytesN<32>),
    EscrowToOrderId(Address),
}

#[contractimpl]
impl EscrowFactory {
    pub fn initialize(env: Env, dutch_auction: Address, relayer: Address) {
        env.storage()
            .instance()
            .set(&DataKey::DutchAuction, &dutch_auction);
        env.storage().instance().set(&DataKey::Relayer, &relayer);
    }

    // this function would be called by dutch auction
    pub fn deploy_src(
        env: Env,
        order_id: BytesN<32>,
        hash_lock: BytesN<32>,
        token_in: Address,
        amount_in: u128,
        maker: Address,
        executive_resolver: Address,
        caller: Address,
    ) -> Address {
        executive_resolver.require_auth();
        Self::check_security_deposit(env.clone(), executive_resolver.clone());

        let escrow_src_wasm = include_bytes!("G:\\EthUnite\\stellar-fusionX\\contracts\\stellar\\target\\wasm32v1-none\\release\\escrowsrc.wasm");
        let escrow_src_wasm_bytes = Bytes::from_array(&env, escrow_src_wasm);
        let wasm_hash = env.deployer().upload_contract_wasm(escrow_src_wasm_bytes);
        let escrow_contract_address = env
            .deployer()
            .with_current_contract(order_id.clone())
            .deploy(wasm_hash);
        let escrow_client = EscrowSrcClient::new(&env, &escrow_contract_address);

        escrow_client.initialize(
            &order_id,
            &hash_lock,
            &token_in,
            &amount_in,
            &maker,
            &executive_resolver,
            &Self::get_relayer(env.clone()),
        );

        // transfer security deposit to the escrow contract
        Self::transfer_security_deposit(env.clone(), escrow_contract_address.clone());
        Self::set_orderid_and_escrow(
            env.clone(),
            order_id.clone(),
            escrow_contract_address.clone(),
        );
        // Return the deployed contract address
        escrow_contract_address
    }

    pub fn deploy_dest(
        env: Env,
        order_id: BytesN<32>,
        hash_lock: BytesN<32>,
        token_out: Address,
        amount_out: u128,
        maker: Address,
        executive_resolver: Address,
    ) -> Address {
        executive_resolver.require_auth();
        Self::check_security_deposit(env.clone(), executive_resolver.clone());

        let escrow_dest_wasm = include_bytes!("G:\\EthUnite\\stellar-fusionX\\contracts\\stellar\\target\\wasm32v1-none\\release\\escrowdest.wasm");
        let escrow_dest_wasm_bytes = Bytes::from_array(&env, escrow_dest_wasm);
        let wasm_hash = env.deployer().upload_contract_wasm(escrow_dest_wasm_bytes);

        let escrow_contract_address = env
            .deployer()
            .with_current_contract(order_id.clone())
            .deploy(wasm_hash);

        let escrow_client = EscrowDestClient::new(&env, &escrow_contract_address);

        escrow_client.initialize(
            &order_id,
            &hash_lock,
            &token_out,
            &amount_out,
            &maker,
            &executive_resolver,
            &Self::get_relayer(env.clone()),
        );

        //transfer security deposit to the escrow contract
        Self::transfer_security_deposit(env.clone(), escrow_contract_address.clone());

        Self::set_orderid_and_escrow(
            env.clone(),
            order_id.clone(),
            escrow_contract_address.clone(),
        );
        // Return the deployed contract address
        escrow_contract_address
    }

    fn transfer_security_deposit(env: Env, escrow_contract_address: Address) {
        let native_token_address = Address::from_string(&String::from_str(
            &env,
            "CDLZFC3SYJYDZT7K67VZ75HPJVIEUVNIXF47ZG2FB2RMQQVU2HHGCYSC",
        ));

        let native_token_client = token::Client::new(&env, &native_token_address);
        // Transfer security deposit from caller to this factory contract
        native_token_client.transfer(
            &env.current_contract_address(),
            &escrow_contract_address,
            &(SECURITY_DEPOSIT as i128),
        );
    }

    fn check_security_deposit(env: Env, resolver: Address) {
        let native_token_address = Address::from_string(&String::from_str(
            &env,
            "CDLZFC3SYJYDZT7K67VZ75HPJVIEUVNIXF47ZG2FB2RMQQVU2HHGCYSC",
        ));

        let native_token_client = token::Client::new(&env, &native_token_address);
        // Check if caller has sufficient balance for security deposit
        let relayer_balance = native_token_client.balance(&resolver);
        if relayer_balance < (SECURITY_DEPOSIT as i128) {
            panic!("Insufficient balance for security deposit");
        }

        // Transfer security deposit from caller to this factory contract first
        native_token_client.transfer(
            &resolver,
            &env.current_contract_address(),
            &(SECURITY_DEPOSIT as i128),
        );
    }

    fn only_dutch_auction(env: Env, caller: Address) {
        let dutch_auction: Address = env
            .storage()
            .instance()
            .get(&DataKey::DutchAuction)
            .unwrap();
        if caller != dutch_auction {
            panic!("Only Dutch Auction can call this function");
        }
    }

    fn set_orderid_and_escrow(env: Env, order_id: BytesN<32>, escrow_address: Address) {
        env.storage()
            .persistent()
            .set(&DataKey::OrderIdToEscrow(order_id.clone()), &escrow_address);
        env.storage()
            .persistent()
            .set(&DataKey::EscrowToOrderId(escrow_address.clone()), &order_id);
    }

    pub fn get_orderid_from_escrow(env: Env, escrow_address: Address) -> BytesN<32> {
        env.storage()
            .persistent()
            .get::<DataKey, BytesN<32>>(&DataKey::EscrowToOrderId(escrow_address))
            .unwrap_or_else(|| {
                panic!("Escrow address not found");
            })
    }
    pub fn get_escrow_from_orderid(env: Env, order_id: BytesN<32>) -> Address {
        env.storage()
            .persistent()
            .get::<DataKey, Address>(&DataKey::OrderIdToEscrow(order_id))
            .unwrap_or_else(|| {
                panic!("Order ID not found");
            })
    }

    pub fn get_relayer(env: Env) -> Address {
        env.storage()
            .instance()
            .get::<DataKey, Address>(&DataKey::Relayer)
            .unwrap_or_else(|| {
                panic!("Relayer not set");
            })
    }
}
