// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.13;

// import "./operations/Operation.sol";
// import "prb-math/contracts/PRBMathSD59x18.sol";
// import "solmate/contracts/MatrixUtils.sol";
// eventually use openzeppelin safemath?

// trying to write this in a functional way as to reduce storage gas price
library ApeTorch {
    struct Node {
        int256[2] weights; // derivatives
        uint16[2] deps;
    }

    struct Var {
        Tape tape; // make sure this is a pointer/ref, might not be
        uint16 index;
        int256 value; // (eventually change to floats/matrices using abdkmathquad)
    }

    struct Tape {
        Node[] nodes;
        uint16 length;
    }

    function _push_nullary(Tape memory tape) internal pure returns (uint16) {
        uint16 length = tape.length;
        tape.nodes[length] = Node([int256(0), 0], [length, length]);
        tape.length += 1;
        return length;
    }

    function _push_unary(
        Tape memory tape,
        uint16 dep0,
        int256 weight0
    ) internal pure returns (uint16) {
        uint16 length = tape.length;
        tape.nodes[length] = Node([weight0, 0], [dep0, length]);
        tape.length += 1;
        return length;
    }

    function _push_binary(
        Tape memory tape,
        uint16 dep0,
        int256 weight0,
        uint16 dep1,
        int256 weight1
    ) internal pure returns (uint16) {
        uint16 length = tape.length;
        tape.nodes[length] = Node([weight0, weight1], [dep0, dep1]);
        tape.length += 1;
        return length;
    }

    function variable(Tape memory tape, int256 value)
        public
        pure
        returns (Var memory)
    {
        return Var(tape, _push_nullary(tape), value);
    }

    function backwards(Tape memory tape, Var memory self)
        public
        pure
        returns (int256[] memory)
    {
        uint256 length = tape.length;
        int256[] memory grad = new int256[](10); // need a better way to do this (dynamic array allocation here idk what to, maybe just create another storage array for it)
        grad[self.index] = 1;
        for (uint256 i = length - 1; i >= 0; --i) {
            Node memory node = tape.nodes[i];
            int256 deriv = grad[i];
            grad[node.deps[0]] += node.weights[0] * deriv;
            grad[node.deps[1]] += node.weights[1] * deriv;
        }

        return grad;
    }

    function add(
        Tape memory tape,
        Var memory self,
        Var memory other
    ) public pure returns (Var memory) {
        return
            Var(
                tape,
                _push_binary(tape, self.index, 1.0, other.index, 1.0),
                self.value + other.value
            );
    }

    function mul(
        Tape memory tape,
        Var memory self,
        Var memory other
    ) public pure returns (Var memory) {
        return
            Var(
                tape,
                _push_binary(
                    tape,
                    self.index,
                    other.value,
                    other.index,
                    self.value
                ),
                self.value * other.value
            );
    }
}
