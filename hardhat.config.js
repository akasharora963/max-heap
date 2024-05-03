require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
  gasReporter : {
    enabled: true,
    coinmarketcap : "a476b08c-0296-41a0-88ee-327a22c0aea2",
    currency : "USD"
  }
};
