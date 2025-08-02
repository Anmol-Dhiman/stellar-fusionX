1. Deploy the Stellar smart contracts
2. Run the `initializeContract.js`
3. Run these commands
```
soroban contract invoke \
  --id CCYMG6TSUAQCKP7NHAZVEIP2ON5J2GNZ4VOSZVA2G3QEQDYNOZ6HD4QC \
  --source alice \
  --network testnet \
  -- \
  set_relayer \
  --relayer CC5MRCCFFRNTBKYGNH6COX2WGJPNNAW2DYGLH3BYFUEQS4UUHP444PZK

soroban contract invoke \
  --id CCYMG6TSUAQCKP7NHAZVEIP2ON5J2GNZ4VOSZVA2G3QEQDYNOZ6HD4QC \
  --source alice \
  --network testnet \
  -- \
  set_escrow_factory \
  --escrow_factory CC3X2OOS45ZETELRNXEK5FTPCOSQ3TBURMZHX647OP7FLYTTWPKVNXJN

soroban contract invoke \
  --id CC5MRCCFFRNTBKYGNH6COX2WGJPNNAW2DYGLH3BYFUEQS4UUHP444PZK \
  --source alice \
  --network testnet \
  -- \
  add_resolver \
  --resolver CCAYPNN44LTM5JJAAIDRJPUNSHOHCR56WY6UZYPDQ7B26UAT46NMNXPS

soroban contract invoke \
  --id CCYMG6TSUAQCKP7NHAZVEIP2ON5J2GNZ4VOSZVA2G3QEQDYNOZ6HD4QC \
  --source alice \
  --network testnet \
  -- \
  get_relayer

soroban contract invoke \
  --id CCYMG6TSUAQCKP7NHAZVEIP2ON5J2GNZ4VOSZVA2G3QEQDYNOZ6HD4QC \
  --source alice \
  --network testnet \
  -- \
  get_escrow_factory

soroban contract invoke \
  --id CC5MRCCFFRNTBKYGNH6COX2WGJPNNAW2DYGLH3BYFUEQS4UUHP444PZK \
  --source alice \
  --network testnet \
  -- \
  is_resolver \
  --resolver CCAYPNN44LTM5JJAAIDRJPUNSHOHCR56WY6UZYPDQ7B26UAT46NMNXPS
```
4. Fund Testnet - stellar keys fund GCPS23IDUCDBJKUTR54PFOGP7WPY56MRO7RFUHRW2IMFSKNR4QNDPP6K