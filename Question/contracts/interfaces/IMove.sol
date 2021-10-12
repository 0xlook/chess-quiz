//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import {SystemTypes} from "../libraries/SystemTypes.sol";

interface IMove {
    function validMovesFor(SystemTypes.Position memory _position)
        external
        view
        returns (SystemTypes.Position[] memory);
}
