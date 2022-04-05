// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.13;

import "../util/ABDKMath64x64.sol";
import "../util/TensorOps.sol";

library ApeTorch {
    using ABDKMath64x64 for int128;
    using TensorOps for int128[];
    using TensorOps for int128[][];
    using TensorOps for int128[][][];

    function linear(
        int128[][] memory input,
        int128[][] storage weights,
        int128[] storage bias
    ) public pure returns (int128[][] memory) {
        return input.dot(weights).add(bias);
    }

    function tanh(int128[][][] memory input)
        public
        pure
        returns (int128[][][] memory)
    {}

    function relu(int128[][][] memory input)
        public
        pure
        returns (int128[][][] memory)
    {
        // int128[][][] memory result = _createMatrix(input);
    }

    function dropout(int128[][][] memory input)
        public
        pure
        returns (int128[][][] memory)
    {}

    function conv2d(int128[][][] memory input, int128[][][] storage filter)
        public
        pure
        returns (int128[][][] memory)
    {}

    function batchnorm2d(int128[][][] memory input, int128[][][] storage filter)
        public
        pure
        returns (int128[][][] memory)
    {}

    function maxpool2d(int128[][][] memory input)
        public
        pure
        returns (int128[][][] memory)
    {}
}
