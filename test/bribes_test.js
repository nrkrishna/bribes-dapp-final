var Bribes = artifacts.require('Bribes')

contract('Bribes', function(accounts) {

    const owner = accounts[0]
    const another_address = accounts[1]

    // This test confirms that a bribe reported to the dapp correctly stores the IPFS hash of the reported bribe
    it("Bribe 1 is published correctly", async() => {
        const bribe = await Bribes.deployed()

        var expectedIpfsHash1 = "Qmaksjdfuasdfasdfasdfasfaau"
        await bribe.reportBribe(expectedIpfsHash1, 1000, {from: another_address})

        const result = await bribe.bribeDetails.call(0)

        assert.equal(result, expectedIpfsHash1, 'ipfs hash does not match what was published')
        //assert.equal(eventEmitted, true, 'publishing an ipfs hash should emit a bribe reported event')
    })

    // This test confirms that a second bribe reported to the dapp correctly stores the IPFS hash of the reported bribe
    // and the bribe total as tracked by the dapp matches the expected value.
    it("Bribe 2 is published correctly", async() => {
        const bribe = await Bribes.deployed()

        var expectedIpfsHash2 = "Qmaksjdfuasdfaasdf248290422424234kljaslkfdhlijhawer"
        await bribe.reportBribe(expectedIpfsHash2, 1001, {from: another_address})

        const result = await bribe.bribeDetails.call(1)
        const totalPaid = await bribe.bribesTotalPaid.call()

        assert.equal(result, expectedIpfsHash2, 'ipfs hash does not match what was published')
        assert.equal(totalPaid, 2001, 'total bribes paid not matching with expected value')
    })

    // This test confirms that the contract can be paused by the owner of the contract
    it("Contract can be paused", async() => {
        const bribe = await Bribes.deployed()

        await bribe.pause({from: owner})
        const result = await bribe.paused.call()
        assert.equal(result, true, 'contract was not paused as expected')
    })

    // This test confirms that the contract can be unpaused by the owner of the contract
    it("Contract can be unpaused", async() => {
        const bribe = await Bribes.deployed()

        await bribe.unpause({from: owner})
        const result = await bribe.paused.call()
        assert.equal(result, false, 'contract was not unpaused as expected')
    })

    // This test confirms that the contract ownership can be traferred and that the new owner
    // has the ability to pause the contract if needed.
    it("Contract ownership can be transferred", async() => {
        const bribe = await Bribes.deployed()

        await bribe.transferOwnership(another_address, {from: owner})
        await bribe.pause({from: another_address})
        const result = await bribe.paused.call()
        assert.equal(result, true, 'contract was not paused after ownership transfer as expected')
    })
});
