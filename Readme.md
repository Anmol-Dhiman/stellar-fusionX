Stellar Fusion X

# Websocket Activities
1. Listen to all the Factory smart contracts
2. In factory contracts, a event should be emitted with these parameters - Order Id, Escrow Address. Add the Escrow addresses to the MongoDB with the Order Id
3. Check if the 1) Token is correct, 2) Token Amount is correct, in both the contracts and wait for finality (5 blocks)
4. Before allowing the maker to submit the "Secret" make sure the 5 blocks is confirmed  

# Fusion+ Step-by-step
Pre-requisites
1. Solver registers in the relayer
2. Solver sets up their server and ready to receive orders

Process Starts
1. [Maker] User signs a Permit2 in Ethereum or equivalent message for Stellar
2. [Order] is received by the relayer through API
3. [Relayer] triggers the Dutch auction for the Order ID. Use 10%+ for max (starting) price and 10%- for min price
4. [Relayer] broadcasts the Order to the solver network
5. [Solver] accepts a price in the Dutch auction and deploys a HTL Escrow contract in the src chain with maker's tokens (the Permit2 sign allows an address decided dynamically to move tokens from maker's wallet to escrow)
6. [Solver] deploys a HTL Escrow contract in the dest chain along with security tokens (paid in native)
7. [Relayer] (2) In factory contracts, a event should be emitted with these parameters - Order Id, Escrow Address. Add the Escrow addresses to the MongoDB with the Order Id
8. [Relayer] (3) Checks if the 1) Token is correct, 2) Token Amount is correct, in both the contracts and wait for finality (5 blocks)
9. [Relayer] (4) Before allowing the maker to submit the "Secret" make sure the 5 blocks is confirmed
10. [Relayer] broadcasts the "Secret" to the network but only the solver gets some intial timelock to retrieve their tokens from src chain
11. [Solver] withdraws the token in dest chain and sends it to maker
12. Recovery Phase (Optional)

# Notes
1. Get state from smart contract like if the swap is completed successfully, what is the timelock status, status of transaction

# Good to have
1. UI 
2. Partial Fill
3. Relayer Dashboard
4. Explorer
5. Scripts to deploy relayer on cloud