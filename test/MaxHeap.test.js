const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-toolbox/network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

//const {ethers } = require("ethers")

describe("max-heap", function () {
  let maxHeap;
  before(async () => {
    [account] = await ethers.getSigners();
    const contract = await hre.ethers.getContractFactory("MaxHeap");
    maxHeap = await contract.deploy();
    await maxHeap.waitForDeployment();
    console.log("Contract Address : ", await maxHeap.getAddress());
  });

  describe("test", function () {
    let heap;
    it("Should insert", async function () {
      await maxHeap.connect(account).insert(10, 1);
      await maxHeap.connect(account).insert(100, 1);
      await maxHeap.connect(account).insert(1000, 1);
      heap = await maxHeap.getHeap();
      console.log("heap--------", heap);
      expect(heap.length == 3);
    });

    it("Should find max", async function () {
      const max = await maxHeap.findMax();

      console.log("Max element------", max);
    });

    it("Should find min", async function () {
      const min = await maxHeap.findMin();

      console.log("Min element------", min);
    });

    it("Should sort", async function () {
      await maxHeap.connect(account).sortPrice();
    });

    it("Should pop max", async function () {
      heap = await maxHeap.getHeap();
      const beforPop = heap.length;
      const tx = await maxHeap.connect(account).popMax();
      await tx.wait();
      heap = await maxHeap.getHeap();
      const afterPop = heap.length
      console.log("heap--------", heap);
      expect(beforPop - afterPop === 1);
    });
  });
});
