const VoteManager = artifacts.require("VoteManager");
const map = require('lodash/map');

contract("VoteManager", accounts => {
    it("owner should be creator", () =>
    VoteManager.deployed()
        .then(instance => instance.owner.call())
        .then(owner => {
            assert.equal(owner.valueOf(), accounts[0], "Owner is not account used for contract deployment.");
        }));

    it("returns one ballot", async () =>
    VoteManager.deployed()
        .then(async instance => {
                const response = await instance.getBallots.call();
                const { states, candidatesSizes } = response;
                const allBallots = map(states, (state, idx) => ({
                    state,
                    candidatesSize: candidatesSizes[idx],
                    id: idx,
                }));
                console.log(allBallots);
                assert.equal(allBallots.length, 1, "Should be one ballot at the beginning.");
                assert.equal(allBallots[0], {state: true, candidatesSize: 2}, "Should be one ballot at the beginning.");
            }));
    }

    // it("Throws when other user tries to create ballot", () =>
    // VoteManager.deployed()
    //     .then(instance => {
    //            return instance.createBallot([ 0x04, 0x02 ], [ 1, 2 ]).send({from: accounts[1]})
    //         }));
    // }
)

// contract('VoteManager', function ([owner, other]) {
//     let voteManager;

//     //TODO: check how to use automaticalkly deployed contract instead
//     beforeEach('create contract for test purpose', async function () {
//         voteManager = await VoteManager.new();
//     })

//     it('Has owner', async function () {
//         assert.equal(await voteManager.owner(), owner);
//     })

//     it('Throws when other user tries to create ballot', async function () {
//         try {
//             await voteManager.methods.createBallot([ 0x04, 0x02 ], [ 1, 2 ]).send({from: other});
//             assert.fail();
//         } catch (error) {
//             assert(error.toString().includes('invalid opcode'), error.toString());
//         }
//     })

//     // it('accepts funds', async function () {
//     //     await fundRaise.sendTransaction({ value: 1e+18, from: donor })

//     //     const fundRaiseAddress = await fundRaise.address
//     //     assert.equal(web3.eth.getBalance(fundRaiseAddress).toNumber(), 1e+18)
//     // })

//     // it('is able to pause and unpause fund activity', async function () {
//     //     await fundRaise.pause()

//     //     try {
//     //         await fundRaise.sendTransaction({ value: 1e+18, from: donor })
//     //         assert.fail()
//     //     } catch (error) {
//     //         assert(error.toString().includes('invalid opcode'), error.toString())
//     //     }
//     //     const fundRaiseAddress = await fundRaise.address
//     //     assert.equal(web3.eth.getBalance(fundRaiseAddress).toNumber(), 0)

//     //     await fundRaise.unpause()
//     //     await fundRaise.sendTransaction({ value: 1e+18, from: donor })
//     //     assert.equal(web3.eth.getBalance(fundRaiseAddress).toNumber(), 1e+18)
//     // })

//     // it('permits owner to receive funds', async function () {
//     //     await fundRaise.sendTransaction({ value: 1e+18, from: donor })
//     //     const ownerBalanceBeforeRemovingFunds = web3.eth.getBalance(owner).toNumber()

//     //     const fundRaiseAddress = await fundRaise.address
//     //     assert.equal(web3.eth.getBalance(fundRaiseAddress).toNumber(), 1e+18)

//     //     await fundRaise.removeFunds()

//     //     assert.equal(web3.eth.getBalance(fundRaiseAddress).toNumber(), 0)
//     //     assert.isAbove(web3.eth.getBalance(owner).toNumber(), ownerBalanceBeforeRemovingFunds)
//     // })
// })
