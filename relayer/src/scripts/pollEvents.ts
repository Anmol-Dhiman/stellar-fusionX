import { ethers } from "ethers";
import { Server, xdr } from "@stellar/stellar-sdk";
import axios from "axios";
import {
  ethSrcFactory,
  xlmSrcFactory,
  ethDestFactory,
  xlmDestFactory,
} from "../utils/contractFactories.util";

// Ethereum setup
const ETH_RPC_URL = "https://mainnet.infura.io/v3/YOUR_INFURA_PROJECT_ID"; // Replace this
const ethProvider = new ethers.JsonRpcProvider(ETH_RPC_URL);

// Soroban setup
const SOROBAN_RPC_URL = "https://soroban-testnet.stellar.org";

// Dummy ABI for Ethereum events (replace with actual ABI)
const exampleAbi = [
  "event OrderSubmitted(address indexed user, uint256 amount)",
];

const ethereumContracts = [ethSrcFactory, ethDestFactory].map((factory) => ({
  address: factory.contractAddress,
  contract: new ethers.Contract(
    factory.contractAddress,
    exampleAbi,
    ethProvider
  ),
  direction: factory.direction,
}));

const sorobanContracts = [xlmSrcFactory, xlmDestFactory];

let lastSorobanCursor: string | undefined = undefined;

async function pollEthereumEvents() {
  for (const { address, contract, direction } of ethereumContracts) {
    try {
      const latestBlock = await ethProvider.getBlockNumber();
      const fromBlock = latestBlock - 10; // Adjust window
      const toBlock = latestBlock;

      const events = await contract.queryFilter(
        "OrderSubmitted",
        fromBlock,
        toBlock
      );

      events.forEach((event) => {
        console.log(`[Ethereum][${direction}] New Event:`, {
          user: event.args?.user,
          amount: event.args?.amount.toString(),
          blockNumber: event.blockNumber,
        });
      });
    } catch (err) {
      console.error(
        `[Ethereum][${direction}] Error polling events:`,
        err.message
      );
    }
  }
}

async function pollSorobanEvents() {
  try {
    const response = await axios.post(SOROBAN_RPC_URL, {
      jsonrpc: "2.0",
      id: 1,
      method: "getEvents",
      params: {
        startCursor: lastSorobanCursor,
        limit: 20,
        filters: sorobanContracts.map((contract) => ({
          type: "contract",
          contractIds: [contract.contractAddress],
        })),
      },
    });

    const events = response.data.result?.events || [];
    for (const event of events) {
      console.log("📣 Event Received:");
      console.log("Topic:", event.topic);
      console.log("Value:", event.value);
      console.log("Ledger:", event.ledger);
      console.log("Event Type:", event.type);
      console.log("---");
      lastSorobanCursor = event.pagingToken;
    }

    if (events.length > 0) {
      lastSorobanCursor =
        events[events.length - 1].pagingToken();
    }
  } catch (err) {
    if (err instanceof Error) {
      console.error("[Soroban] Error polling events:", err.message);
    } else {
      console.error("[Soroban] Error polling events:", err);
    }
  }
}

async function pollAll() {
  await Promise.all([pollEthereumEvents(), pollSorobanEvents()]);
}

console.log("🔁 Starting event polling every 5 seconds...");
setInterval(pollAll, 5000);
