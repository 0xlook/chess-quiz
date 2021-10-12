import { ethers, upgrades } from "hardhat";
import { Contract, ContractFactory } from "ethers";

async function main() {
  const Randomizer: ContractFactory = await ethers.getContractFactory(
    "Randomizer"
  );
  const randomizerLib: Contract = await Randomizer.deploy();

  const SimpleGame: ContractFactory = await ethers.getContractFactory(
    "SimpleGame",
    {
      libraries: {
        Randomizer: randomizerLib.address,
      },
    }
  );
  const simpleGame: Contract = await upgrades.deployProxy(SimpleGame, [], {
    unsafeAllowLinkedLibraries: true,
  });
  await simpleGame.deployed();

  console.log("SimpleGame deployed to:", simpleGame.address);

  const ComplexGame: ContractFactory = await ethers.getContractFactory(
    "ComplexGame",
    {
      libraries: {
        Randomizer: randomizerLib.address,
      },
    }
  );
  const complexGame: Contract = await upgrades.deployProxy(ComplexGame, [], {
    unsafeAllowLinkedLibraries: true,
  });
  await complexGame.deployed();

  console.log("ComplexGame deployed to:", complexGame.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
