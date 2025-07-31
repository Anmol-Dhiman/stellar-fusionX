1. Compile: stellar contract build --package wrappedtoken
2. Deploy: stellar contract deploy --wasm target/wasm32v1-none/release/wrappedtoken.wasm --source alice --network testnet
- Deploy Address: CAHP43PLRNMDOQEPSS66C5MBRWQYM2UV3SOQSUW7VWO73R47V7CO272T
3. Compile: stellar contract build --package mocktoken
4. Deploy: stellar contract deploy --wasm target/wasm32v1-none/release/mocktoken.wasm --source alice --network testnet
5. Deploy Address: CA43QY2RGDPFVYX4V7Y544HTNBN4GTQGTUBD6YX5SEJIG42LBTTPZFQG 

Alice Private Key: SABCJCNM2TQFPU7IBJZFMUMLYAXJ2GJE5RGP7AKAEBWDS7MRJM34DOS4
Alice Public Key/Address: GB3I5T27E4VXU7PTTIWPBFJTKPUT4SIXKCMK3V6FKU6QXL7Q4TWCZTWQ

✅Deploy both

1. ✅Mint some mock token
   stellar contract invoke \
  --id CA43QY2RGDPFVYX4V7Y544HTNBN4GTQGTUBD6YX5SEJIG42LBTTPZFQG \
  --source alice \
  --network testnet \
  -- mint \
  --to GB3I5T27E4VXU7PTTIWPBFJTKPUT4SIXKCMK3V6FKU6QXL7Q4TWCZTWQ \
  --value 1000000000000000000
  
1. ✅Approve wrapped token contract my Mock tokens
    stellar contract invoke --id CA43QY2RGDPFVYX4V7Y544HTNBN4GTQGTUBD6YX5SEJIG42LBTTPZFQG --source alice --network testnet -- approve --amount 1000000000000000000 --to CAHP43PLRNMDOQEPSS66C5MBRWQYM2UV3SOQSUW7VWO73R47V7CO272T --caller GB3I5T27E4VXU7PTTIWPBFJTKPUT4SIXKCMK3V6FKU6QXL7Q4TWCZTWQ

2. ✅Deposit in Wrapped
    stellar contract invoke --id CAHP43PLRNMDOQEPSS66C5MBRWQYM2UV3SOQSUW7VWO73R47V7CO272T --source alice --network testnet -- deposit --token CA43QY2RGDPFVYX4V7Y544HTNBN4GTQGTUBD6YX5SEJIG42LBTTPZFQG --amount 100000000000000000 --caller GB3I5T27E4VXU7PTTIWPBFJTKPUT4SIXKCMK3V6FKU6QXL7Q4TWCZTWQ
   
3. token: Address,
    owner: Address,
    spender: Address,
    amount: u128,
Make a hash, sign using PK and call permit

stellar contract invoke   --id CAHP43PLRNMDOQEPSS66C5MBRWQYM2UV3SOQSUW7VWO73R47V7CO272T   --source alice   --network testnet   -- permit   --token CA43QY2RGDPFVYX4V7Y544HTNBN4GTQGTUBD6YX5SEJIG42LBTTPZFQG   --owner GB3I5T27E4VXU7PTTIWPBFJTKPUT4SIXKCMK3V6FKU6QXL7Q4TWCZTWQ   --spender GB3I5T27E4VXU7PTTIWPBFJTKPUT4SIXKCMK3V6FKU6QXL7Q4TWCZTWQ   --amount 100000000000000000   --public_key 768ecf5f272b7a7df39a2cf0953353e93e49175098add7c5553d0baff0e4ec2c   --signature 75ff234b4e8e0df3662db16866a672fe91d90e779b6fda4908ce823d47428de9ed4282e86832b8407da6b7dd22b13161a982d5e9cc211e941b44d30172938206   --hash d91146455337aed1fae0a5f5730db3e48e0f73a64eab1af4fbb1dc0d99e03781