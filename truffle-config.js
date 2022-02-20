module.exports = {
 
    networks: {
      
      development: {
       host: "127.0.0.1",     // Localhost (default: none)
       port: 7545,            // Standard Ethereum port (default: none)
       network_id: "*",       // Any network (default: none)
      },
    },

     // since we have change the place of contracts from the root into src/contracts
     contracts_directory: "./scr/contracts",

     // The json interface is a json object describing the Application Binary Interface (ABI) for an Ethereum smart contract.
     // the folder does't exist but will be created
     contracts_build_directory: "./src/abis",
  
    // Configure your compilers
    compilers: {
      solc: {
        version: "^0.8.11",    
         optimizer: {
           enabled: true,
           runs: 200
         },
         evmVersion: "byzantium"
        }
      },
};
  