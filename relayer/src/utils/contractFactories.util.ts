const ethSrcFactory = {
    chain: 'ethereum',
    direction: 'source',
    contractAddress: '0x1234567890abcdef1234567890abcdef12345678',
};

const xlmSrcFactory = {
    chain: 'stellar',
    direction: 'source',
    contractAddress: '0x1234567890abcdef1234567890abcdef12345678',
};

const ethDestFactory = {
    chain: 'ethereum',
    direction: 'destination',
    contractAddress: '0x1234567890abcdef1234567890abcdef12345678',
};

const xlmDestFactory = {
    chain: 'stellar',
    direction: 'destination',
    contractAddress: '0x1234567890abcdef1234567890abcdef12345678',
};

// Export all factories
export {
  ethSrcFactory,
  xlmSrcFactory,
  ethDestFactory,
  xlmDestFactory,
};
