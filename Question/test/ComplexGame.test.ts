import { ethers } from "hardhat";
import { assert, expect } from "chai";
import { Contract } from "@ethersproject/contracts";

describe("ComplexGame", function () {
  let randomizerLib: Contract;
  let complexGame: Contract;
  before(async function () {
    const Randomizer = await ethers.getContractFactory("Randomizer");
    randomizerLib = await Randomizer.deploy();

    const ComplexGame = await ethers.getContractFactory("ComplexGame", {
      libraries: {
        Randomizer: randomizerLib.address,
      },
    });
    complexGame = await ComplexGame.deploy();
  });

  describe("Play", () => {
    it("Play 10 moves", async function () {
      await complexGame.setup();
      await complexGame.play(10);
    });
  });
});
