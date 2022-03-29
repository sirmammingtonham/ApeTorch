// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.13;

// import "./operations/Operation.sol";
// import "prb-math/contracts/PRBMathSD59x18.sol";
// import "solmate/contracts/MatrixUtils.sol";
// eventually use openzeppelin safemath

contract ApeTorch {
    struct Node {
        int256[2] weights; // derivatives
        uint16[2] deps;
    }

    struct Var {
        Node[] tape; // make sure this is a pointer/ref, might not be
        uint16 index;
        int256 value; // (eventually change to floats using abdkmathquad)
    }

    Node[] tape;

    function variable(int256 value) public returns (Var memory) {
        return Var(tape, push_nullary(), value);
    }

    function push_nullary() internal returns (uint16) {
        uint16 length = uint16(tape.length);
        tape.push(Node([int256(0), 0], [length, length]));
        return length;
    }

    function push_unary(uint16 dep0, int256 weight0) internal returns (uint16) {
        uint16 length = uint16(tape.length);
        tape.push(Node([weight0, 0], [dep0, length]));
        return length;
    }

    function push_binary(
        uint16 dep0,
        int256 weight0,
        uint16 dep1,
        int256 weight1
    ) internal returns (uint16) {
        uint16 length = uint16(tape.length);
        tape.push(Node([weight0, weight1], [dep0, dep1]));
        return length;
    }

    function backwards(Var memory self) public view returns (int256[] memory) {
        uint256 length = tape.length;
        int256[] memory grad = new int256[](10); // need a better way to do this (dynamic array allocation here idk what to, maybe just create another storage array for it)
        grad[self.index] = 1;
        for (uint256 i = length - 1; i >= 0; --i) {
            Node memory node = tape[i];
            int256 deriv = grad[i];
            grad[node.deps[0]] += node.weights[0] * deriv;
            grad[node.deps[1]] += node.weights[1] * deriv;
        }

        return grad;
    }

    function add(Var memory self, Var memory other)
        public
        returns (Var memory)
    {
        return
            Var(
                tape,
                push_binary(self.index, 1.0, other.index, 1.0),
                self.value + other.value
            );
    }

    function mul(Var memory self, Var memory other)
        public
        returns (Var memory)
    {
        return
            Var(
                tape,
                push_binary(self.index, other.value, other.index, self.value),
                self.value * other.value
            );
    }
}
