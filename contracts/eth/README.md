# Limit Order Protocol - Dummy only need to redeploy

| Contract               | Address                                                                                                                            |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| MockToken              | [0x3fBDD9b963F556348054E4625DebCce7462Af02F](https://amoy.polygonscan.com/address/0x3fBDD9b963F556348054E4625DebCce7462Af02F#code) |
| LimitOrderProtocol     | [0x4bdC8626b6a14546Fcd64b9FCfF33935cAb0b896](https://amoy.polygonscan.com/address/0x4bdC8626b6a14546Fcd64b9FCfF33935cAb0b896#code) |
| DutchAuctionCalculator | [0xd08F5a5226622EB7275d5Fd045E80C0789F6a307](https://amoy.polygonscan.com/address/0xd08F5a5226622EB7275d5Fd045E80C0789F6a307#code) |
| EscrowFactory          | [0xdC9e07671f8b96d2D74Fc2A183C9C505Fafd66bc](https://amoy.polygonscan.com/address/0xdC9e07671f8b96d2D74Fc2A183C9C505Fafd66bc#code) |
| Resolver               | [0x753eCDD9D2d8390e26698899Fa58F850d2Be6F58](https://amoy.polygonscan.com/address/0x753eCDD9D2d8390e26698899Fa58F850d2Be6F58#code) |

### Deploy Command

```bash
source .env
```

```bash
forge script script/deploy.s.sol --rpc-url https://polygon-amoy.g.alchemy.com/v2/${ALCHEMY_KEY} --broadcast --verify --chain polygon-amoy -vvvv
```
