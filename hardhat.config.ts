// import "@nomiclabs/hardhat-vyper";
import "@nomiclabs/hardhat-waffle";

export default {
  // vyper: {
  //   version: "0.3.1",
  // },
  solidity: "0.8.13",
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts",
  },
};
