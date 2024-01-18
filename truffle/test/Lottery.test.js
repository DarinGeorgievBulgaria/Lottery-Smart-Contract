const Lottery = artifacts.require("Lottery")
var chai = require("chai");
const BN = web3.utils.BN; //BN = Big Number
const chaiBN = require("chai-bn")(BN);
chai.use(chaiBN);

var chaiAsPromised = require("chai-as-promised");
chai.use(chaiAsPromised);

const expect = chai.expect;
describe("Lottery Test", ()=>{
    it("Deploys a contract successfully", async ()=>{
        let instance = await Lottery.deployed();
        
        //assert.ok(instance);
        expect(instance);
        
    });
    it('allows one account to enter', async ()=>{
        await lottery.methods.enter().send({
            from: accounts[0],
            value: web3.utils.toWei('0.02', 'ether')
        });
    });
});

