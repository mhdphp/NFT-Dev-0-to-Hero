
// import assert lib from chaijs
const assert = require('assert');

// Kryptobird the name from 2_deploy_contracts.js
const Kbird = artifacts.require('KryptoBird');

// check for chai
require('chai')
.use(require('chai-as-promised'))
.should();

// accounts is an array of all the accounts in ganache app
// accounts[0] is the first account - msg.sender
contract('Kbird', (accounts) =>{
    let contract;
    // before tells our tests to run this first before anything eles
    before( async() =>{
        contract = await Kbird.deployed();
    });
    

    // testing container - describe
    describe('deployment', async()=>{
        
        // test samples with writing it
        it('deploys successfully', async()=>{
            const address = await contract.address;
            assert.notEqual(address, '');
            assert.notEqual(address, null);
            assert.notEqual(address, undefined);
            assert.notEqual(address, 0x0);
        });

        it('has a name', async()=>{
            const name = await contract.name();
            assert.equal(name, 'KryptoBird');
        });

        it('has a symbol', async()=>{
            const symbol = await contract.symbol();
            assert.equal(symbol, 'KBIRDZ');
        });
    });

    describe('minting', async()=>{

        it('creates a new token', async() =>{
            const result = await contract.mint('http...1');
            const totalSupply = await contract.totalSupply();
            // get the event from function mint
            const event = result.logs[0].args;

            console.log('Total Supply = ', totalSupply.toString())
            console.log('Total Supply (words[0]) = ', totalSupply.words[0])
            console.log('Total Supply (.length) = ', totalSupply.length)
            
            //success
            assert.equal(totalSupply, 1);
            assert.equal(event._from, 
                '0x0000000000000000000000000000000000000000', 'from address the contract');
            assert.equal(event._to, accounts[0], 'to is msg.sender');

            console.log('_to=', event._to);
            
            //failure
            // don't work
            //await contract.mint('http...1').should.be.rejected;
        });

        describe('indexing', async()=>{
            it('lists KryptoBirdz', async()=>{
                // mint more krytpbirdz
                await contract.mint('http...2');
                await contract.mint('http...3');
                await contract.mint('http...4');
                const totalSupply = await contract.totalSupply();

                // loop through the kryptoBirdz[] from KryptoBirdz.sol
                // add the results in a new javascript array
                let result = [];
                let kbird;
                for (i=1; i<=4; i++){
                    // here are round brackets
                    kbird = await contract.kryptoBirdz(i-1); // index starts at 0
                    result.push(kbird);
                }

                let expected = ['http...1','http...2','http...3','http...4'];
                assert.equal(result.join(','), expected.join(','));
                console.log('expected', expected.join(','));
                console.log('result', result.join(','));
            });
        });
    });
});