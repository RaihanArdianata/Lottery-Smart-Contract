const Lottery = artifacts.require("Lottery");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("Lottery", function (/* accounts */) {
  it("should assert true", async function () {
    await Lottery.deployed();
    return assert.isTrue(true);
  });
});
