const { Keypair, hash } = require('@stellar/stellar-sdk');
const { Buffer } = require('buffer');

// Contract parameters
const token = "CA43QY2RGDPFVYX4V7Y544HTNBN4GTQGTUBD6YX5SEJIG42LBTTPZFQG";
const owner = "GB3I5T27E4VXU7PTTIWPBFJTKPUT4SIXKCMK3V6FKU6QXL7Q4TWCZTWQ";
const spender = "GB3I5T27E4VXU7PTTIWPBFJTKPUT4SIXKCMK3V6FKU6QXL7Q4TWCZTWQ";
const amount = "100000000000000000"; // 0.1 tokens

// Step 1: Create deterministic hash
function createPermitHash(token, owner, spender, amount) {
    const message = `${token}:${owner}:${spender}:${amount}`;
    const messageBuffer = Buffer.from(message, 'utf8');
    return hash(messageBuffer);
}

// Step 2: Sign the hash
function signPermit(ownerSecretKey, permitHash) {
    const ownerKeypair = Keypair.fromSecret(ownerSecretKey);
    const signature = ownerKeypair.sign(permitHash);
    const publicKey = ownerKeypair.publicKey();
    
    return {
        publicKey: publicKey,
        signature: signature,
        publicKeyBytes: ownerKeypair.rawPublicKey(),
        signatureBytes: signature
    };
}

// Example usage
async function generatePermitSignature() {
    // Replace with actual owner's secret key
    const ownerSecretKey = 'SABCJCNM2TQFPU7IBJZFMUMLYAXJ2GJE5RGP7AKAEBWDS7MRJM34DOS4';
    
    console.log('=== Permit Parameters ===');
    console.log(`Token: ${token}`);
    console.log(`Owner: ${owner}`);
    console.log(`Spender: ${spender}`);
    console.log(`Amount: ${amount}`);
    console.log('');
    
    // Step 1: Create hash
    const permitHash = createPermitHash(token, owner, spender, amount);
    console.log('=== Step 1: Hash ===');
    console.log(`Hash (hex): ${permitHash.toString('hex')}`);
    console.log(`Hash (base64): ${permitHash.toString('base64')}`);
    console.log('');
    
    // Step 2: Sign
    const signatureData = signPermit(ownerSecretKey, permitHash);
    console.log('=== Step 2: Signature ===');
    console.log(`Public Key: ${signatureData.publicKey}`);
    console.log(`Public Key (hex): ${signatureData.publicKeyBytes.toString('hex')}`);
    console.log(`Signature (hex): ${signatureData.signatureBytes.toString('hex')}`);
    console.log('');
    
    // Step 3: Generate CLI command
    console.log('=== Step 3: CLI Command ===');
    console.log(`stellar contract invoke \\`);
    console.log(`  --id CAHP43PLRNMDOQEPSS66C5MBRWQYM2UV3SOQSUW7VWO73R47V7CO272T \\`);
    console.log(`  --source alice \\`);
    console.log(`  --network testnet \\`);
    console.log(`  -- permit \\`);
    console.log(`  --token ${token} \\`);
    console.log(`  --owner ${owner} \\`);
    console.log(`  --spender ${spender} \\`);
    console.log(`  --amount ${amount} \\`);
    console.log(`  --public_key ${signatureData.publicKeyBytes.toString('hex')} \\`);
    console.log(`  --signature ${signatureData.signatureBytes.toString('hex')} \\`);
    console.log(`  --hash ${permitHash.toString('hex')} \\`);
    console.log(`  --send=yes`);
}

// For browser/React usage
function browserExample() {
    // This would work in a web app where user connects their wallet
    return {
        createHash: createPermitHash,
        signWithWallet: async (walletSigner, hash) => {
            // Integrate with Freighter, xBull, or other Stellar wallets
            const signature = await walletSigner.sign(hash);
            return signature;
        }
    };
}

// Export for use
module.exports = {
    createPermitHash,
    signPermit,
    generatePermitSignature,
    browserExample
};

// Run example if this file is executed directly
if (require.main === module) {
    generatePermitSignature().catch(console.error);
}