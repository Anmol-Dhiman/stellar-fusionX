// lib/stellar-utils.ts
const StellarSdk = require("@stellar/stellar-sdk");
const { Keypair, TransactionBuilder, Networks, Contract, nativeToScVal, rpc } =
  StellarSdk;

// Configuration
const WRAPPED_TOKEN_CONTRACT_ADDRESS =
  "CB27AJYW32SYXRGGTZSWHZ6ZRURIXP5ANARZ6DCAWID6UWVY6P2Z3IGZ";
const server = new rpc.Server("https://soroban-testnet.stellar.org");
const networkPassphrase = Networks.TESTNET;

// Helper functions
export function tokensToUnits(tokens: string | number): string {
  return (BigInt(tokens) * BigInt(10 ** 18)).toString();
}

export function unitsToTokens(units: string | number): number {
  return Number(BigInt(units) / BigInt(10 ** 18));
}

/**
 * Approve an address to spend mock tokens on behalf of the caller
 * @param {string} tokenAddress - Mock token contract address
 * @param {string} spenderAddress - Address to approve for spending
 * @param {string} amount - Amount to approve (in token units with 18 decimals)
 * @param {string} callerPrivateKey - Private key of the token owner
 * @returns {Promise<string>} - Transaction hash
 */
export async function approveMockToken(
  tokenAddress: string,
  spenderAddress: string,
  amount: string,
  callerPrivateKey: string
): Promise<string> {
  try {
    const callerKeypair = Keypair.fromSecret(callerPrivateKey);

    console.log(`Approving ${amount} token units for ${spenderAddress}...`);
    console.log(`Caller: ${callerKeypair.publicKey()}`);

    const account = await server.getAccount(callerKeypair.publicKey());
    const contract = new Contract(tokenAddress);

    // Contract function: approve(env: Env, amount: u128, to: Address, caller: Address)
    const operation = contract.call(
      "approve",
      nativeToScVal(BigInt(amount), { type: "u128" }), // amount parameter
      nativeToScVal(spenderAddress, { type: "address" }), // to parameter (spender)
      nativeToScVal(callerKeypair.publicKey(), { type: "address" }) // caller parameter
    );

    // Set caller as source for authorization (caller.require_auth())
    operation.source = callerKeypair.publicKey();

    const transaction = new TransactionBuilder(account, {
      fee: "10000000",
      networkPassphrase: networkPassphrase,
    })
      .addOperation(operation)
      .setTimeout(300)
      .build();

    console.log("Simulating transaction...");
    const simulationResponse = await server.simulateTransaction(transaction);

    if (simulationResponse.error) {
      throw new Error(`Simulation failed: ${simulationResponse.error}`);
    }

    console.log("Preparing and submitting transaction...");
    const preparedTransaction = await server.prepareTransaction(transaction);
    preparedTransaction.sign(callerKeypair);

    const response = await server.sendTransaction(preparedTransaction);

    console.log(`✅ Transaction submitted: ${response.hash}`);
    return response.hash;
  } catch (error: any) {
    console.error("❌ Approve failed:", error.message);
    throw error;
  }
}

/**
 * Deposit mock tokens into the wrapped token contract
 * @param {string} tokenAddress - Mock token contract address
 * @param {string} amount - Amount to deposit (in token units with 18 decimals)
 * @param {string} callerPrivateKey - Private key of the depositor
 * @returns {Promise<string>} - Transaction hash
 */
export async function depositMockToken(
  tokenAddress: string,
  amount: string,
  callerPrivateKey: string
): Promise<string> {
  try {
    const callerKeypair = Keypair.fromSecret(callerPrivateKey);

    console.log(`Depositing ${amount} token units...`);
    console.log(`Token: ${tokenAddress}`);
    console.log(`Caller: ${callerKeypair.publicKey()}`);

    const account = await server.getAccount(callerKeypair.publicKey());
    const wrappedContract = new Contract(WRAPPED_TOKEN_CONTRACT_ADDRESS);

    // Contract function: deposit(env: Env, token: Address, amount: u128, caller: Address)
    const operation = wrappedContract.call(
      "deposit",
      nativeToScVal(tokenAddress, { type: "address" }), // token parameter
      nativeToScVal(BigInt(amount), { type: "u128" }), // amount parameter
      nativeToScVal(callerKeypair.publicKey(), { type: "address" }) // caller parameter
    );

    // Set caller as source for authorization (caller.require_auth())
    operation.source = callerKeypair.publicKey();

    const transaction = new TransactionBuilder(account, {
      fee: "10000000",
      networkPassphrase: networkPassphrase,
    })
      .addOperation(operation)
      .setTimeout(300)
      .build();

    console.log("Simulating transaction...");
    const simulationResponse = await server.simulateTransaction(transaction);

    if (simulationResponse.error) {
      throw new Error(`Simulation failed: ${simulationResponse.error}`);
    }

    console.log("Preparing and submitting transaction...");
    const preparedTransaction = await server.prepareTransaction(transaction);
    preparedTransaction.sign(callerKeypair);

    const response = await server.sendTransaction(preparedTransaction);

    console.log(`✅ Transaction submitted: ${response.hash}`);
    return response.hash;
  } catch (error: any) {
    console.error("❌ Deposit failed:", error.message);
    throw error;
  }
}

/**
 * Check token balance for an address
 * @param {string} tokenAddress - Token contract address
 * @param {string} address - Address to check
 * @returns {Promise<string>} - Balance amount
 */
export async function checkBalance(
  tokenAddress: string,
  address: string
): Promise<string> {
  try {
    console.log(`Checking balance for: ${address}`);

    const account = await server.getAccount(address);
    const contract = new Contract(tokenAddress);

    const transaction = new TransactionBuilder(account, {
      fee: "1000000",
      networkPassphrase: networkPassphrase,
    })
      .addOperation(
        contract.call(
          "get_balance",
          nativeToScVal(address, { type: "address" })
        )
      )
      .setTimeout(300)
      .build();

    const simulationResponse = await server.simulateTransaction(transaction);

    if (simulationResponse.error) {
      console.error("❌ Balance check failed:", simulationResponse.error);
      return "0";
    }

    const balance = simulationResponse.result?.retval || "0";
    console.log(`Balance: ${balance}`);

    return balance;
  } catch (error: any) {
    console.error("❌ Error checking balance:", error.message);
    return "0";
  }
}

/**
 * Check wrapped token balance for an address
 * @param {string} tokenAddress - Mock token contract address
 * @param {string} userAddress - User address to check
 * @returns {Promise<string>} - Wrapped balance amount
 */
export async function checkWrappedBalance(
  tokenAddress: string,
  userAddress: string
): Promise<string> {
  try {
    console.log(`Checking wrapped balance for: ${userAddress}`);
    console.log(`Token: ${tokenAddress}`);

    const account = await server.getAccount(userAddress);
    const wrappedContract = new Contract(WRAPPED_TOKEN_CONTRACT_ADDRESS);

    const transaction = new TransactionBuilder(account, {
      fee: "1000000",
      networkPassphrase: networkPassphrase,
    })
      .addOperation(
        wrappedContract.call(
          "get_balance",
          nativeToScVal(tokenAddress, { type: "address" }), // token
          nativeToScVal(userAddress, { type: "address" }) // user
        )
      )
      .setTimeout(300)
      .build();

    const simulationResponse = await server.simulateTransaction(transaction);

    if (simulationResponse.error) {
      console.error("❌ Balance check failed:", simulationResponse.error);
      return "0";
    }

    const balance = simulationResponse.result?.retval || "0";
    console.log(`Wrapped Balance: ${balance}`);

    return balance;
  } catch (error: any) {
    console.error("❌ Error checking wrapped balance:", error.message);
    return "0";
  }
}

/**
 * Convenience function to wrap mock tokens (approve + deposit in one call)
 * @param {string} tokenAddress - Mock token contract address
 * @param {string} amount - Amount in normal token units
 * @param {string} callerPrivateKey - Private key of the user
 * @returns {Promise<{approveHash: string, depositHash: string}>} - Transaction hashes
 */
export async function wrapTokens(
  tokenAddress: string,
  amount: string,
  callerPrivateKey: string
): Promise<{ approveHash: string; depositHash: string }> {
  const amountInUnits = tokensToUnits(amount);

  // Step 1: Approve the wrapped token contract to spend mock tokens
  const approveHash = await approveMockToken(
    tokenAddress,
    WRAPPED_TOKEN_CONTRACT_ADDRESS,
    amountInUnits,
    callerPrivateKey
  );

  // Step 2: Deposit mock tokens to get wrapped tokens
  const depositHash = await depositMockToken(
    tokenAddress,
    amountInUnits,
    callerPrivateKey
  );

  return { approveHash, depositHash };
}
