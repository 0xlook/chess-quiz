import { ethers } from "hardhat";
import { assert, expect } from "chai";
import { Contract } from "@ethersproject/contracts";

describe("QueenMove", function () {
  let queenMove: Contract;
  before(async function () {
    const QueenMove = await ethers.getContractFactory("QueenMove");
    queenMove = await QueenMove.deploy();
  });

  describe("MoveFromInsideBoard", () => {
    it("Move from the insider of board should work", async function () {
      var pos = { X: 3, Y: 3 };
      var moves = await queenMove.validMovesFor(pos);
      assert.equal(moves.length, 25);
      assert.equal(moves.filter((move) => move.X == pos.X).length, 7);
      assert.equal(moves.filter((move) => move.Y == pos.Y).length, 7);
      assert.equal(moves.filter((move) => move.X.eq(move.Y)).length, 7);
      assert.equal(
        moves.filter(
          (move) => Math.abs(move.X - pos.X) == Math.abs(move.Y - pos.Y)
        ).length,
        11
      );
    });
  });

  describe("MoveFromCorner", () => {
    it("Move from the boarder of board should work", async function () {
      var pos = { X: 1, Y: 1 };
      var moves = await queenMove.validMovesFor(pos);
      assert.equal(moves.length, 21);
      assert.equal(moves.filter((move) => move.X == pos.X).length, 7);
      assert.equal(moves.filter((move) => move.Y == pos.Y).length, 7);
      assert.equal(moves.filter((move) => move.X.eq(move.Y)).length, 7);
    });
  });
});
