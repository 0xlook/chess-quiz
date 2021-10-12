//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import {SystemTypes} from "./SystemTypes.sol";

//import {SafeMath} from "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract QueenMove {
    //using SafeMath for uint8;

    function validMovesFor(SystemTypes.Position memory _position)
        public
        pure
        returns (SystemTypes.Position[] memory)
    {
        uint256 count = 0;
        for (int256 i = -7; i <= 7; i++) {
            if (i == 0) {
                continue;
            }
            int256 newX = int256(_position.X) + i;
            int256 newY = int256(_position.Y) + i;
            if (newX <= 8 && newX >= 1 && newY <= 8 && newY >= 1) {
                count++;
            }
            newX = int256(_position.X) + i;
            newY = int256(_position.Y) - i;
            if (newX <= 8 && newX >= 1 && newY <= 8 && newY >= 1) {
                count++;
            }
            newX = int256(_position.X) + i;
            newY = int256(_position.Y);
            if (newX <= 8 && newX >= 1 && newY <= 8 && newY >= 1) {
                count++;
            }
            newX = int256(_position.X);
            newY = int256(_position.Y) + i;
            if (newX <= 8 && newX >= 1 && newY <= 8 && newY >= 1) {
                count++;
            }
        }
        SystemTypes.Position[] memory results = new SystemTypes.Position[](
            count
        );
        uint256 index = 0;

        for (int256 i = -7; i <= 7; i++) {
            if (i == 0) {
                continue;
            }
            int256 newX = int256(_position.X) + i;
            int256 newY = int256(_position.Y) + i;
            if (newX <= 8 && newX >= 1 && newY <= 8 && newY >= 1) {
                results[index] = SystemTypes.Position(
                    uint256(newX),
                    uint256(newY)
                );
                index++;
            }
            newX = int256(_position.X) + i;
            newY = int256(_position.Y) - i;
            if (newX <= 8 && newX >= 1 && newY <= 8 && newY >= 1) {
                results[index] = SystemTypes.Position(
                    uint256(newX),
                    uint256(newY)
                );
                index++;
            }
            newX = int256(_position.X) + i;
            newY = int256(_position.Y);
            if (newX <= 8 && newX >= 1 && newY <= 8 && newY >= 1) {
                results[index] = SystemTypes.Position(
                    uint256(newX),
                    uint256(newY)
                );
                index++;
            }
            newX = int256(_position.X);
            newY = int256(_position.Y) + i;
            if (newX <= 8 && newX >= 1 && newY <= 8 && newY >= 1) {
                results[index] = SystemTypes.Position(
                    uint256(newX),
                    uint256(newY)
                );
                index++;
            }
        }

        return results;
    }
}
