//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "../interfaces/IGame.sol";
import "../interfaces/IMove.sol";
import "../libraries/KnightMove.sol";
import "../libraries/QueenMove.sol";
import "../libraries/BishopMove.sol";
import "../libraries/SystemTypes.sol";
import "../libraries/Randomizer.sol";

import "hardhat/console.sol";

contract ComplexGame is IGame {
    struct Piece {
        string name;
        SystemTypes.Position position;
    }

    Piece[] private pieces;

    IMove[] private pieceMoves;
    KnightMove private knight;
    QueenMove private queen;
    BishopMove private bishop;

    function movePiece(Piece storage piece, IMove pieceMove) private {
        string memory name = piece.name;
        SystemTypes.Position memory currentPosition = piece.position;
        console.log(
            "%s Position is (%d,%d)",
            name,
            currentPosition.X,
            currentPosition.Y
        );

        SystemTypes.Position[] memory possibles = pieceMove.validMovesFor(
            currentPosition
        );
        uint256 r = Randomizer.random(possibles.length) % possibles.length;
        currentPosition = possibles[r];
        for (uint256 i = 0; i < pieces.length; i++) {
            if (
                currentPosition.X == pieces[i].position.X &&
                currentPosition.Y == pieces[i].position.Y
            ) {
                currentPosition = r == 0 ? possibles[r + 1] : possibles[r - 1];
                break;
            }
        }
        console.log(
            "%s Position is (%d,%d)",
            name,
            currentPosition.X,
            currentPosition.Y
        );
        piece.position = currentPosition;
    }

    function play(uint256 _moves) external override {
        for (uint256 i = 0; i < _moves; i++) {
            console.log("============== Move #(%d) ==============", i);
            uint256 index = i % 3;
            movePiece(pieces[index], pieceMoves[index]);
        }
    }

    function setup() external override {
        pieces.push(Piece("Knight", SystemTypes.Position(2, 2)));
        pieces.push(Piece("Bishop", SystemTypes.Position(3, 3)));
        pieces.push(Piece("Queen", SystemTypes.Position(4, 4)));

        knight = new KnightMove();
        bishop = new BishopMove();
        queen = new QueenMove();
        pieceMoves.push(IMove(address(knight)));
        pieceMoves.push(IMove(address(bishop)));
        pieceMoves.push(IMove(address(queen)));
    }
}
