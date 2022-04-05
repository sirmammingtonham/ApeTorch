// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.13;

import "../util/ABDKMath64x64.sol";

library TensorOps {
    using ABDKMath64x64 for int128;

	// create 2d [dim1]x[dim2] matrix
    function _createMatrix(uint256 dim1, uint256 dim2)
        internal
        pure
        returns (int128[][] memory)
    {
        int128[][] memory result = new int128[][](dim1);
        for (uint256 i = 0; i < dim1; ++i) {
            result[i] = new int128[](dim2);
        }
        return result;
    }

    // create 3d [dim1]x[dim2]x[dim3] matrix
    function _createMatrix(
        uint256 dim1,
        uint256 dim2,
        uint256 dim3
    ) internal pure returns (int128[][][] memory) {
        int128[][][] memory result = new int128[][][](dim1);
        for (uint256 i = 0; i < dim1; ++i) {
            result[i] = new int128[][](dim2);
            for (uint256 j = 0; j < dim2; ++j) {
                result[i][j] = new int128[](dim3);
            }
        }
        return result;
    }

    // create 2d matrix in the same shape as [like]
    function _createMatrix(int128[][] memory like)
        internal
        pure
        returns (int128[][] memory)
    {
        uint256 dim1 = like.length;
        uint256 dim2 = like[0].length;
        int128[][] memory result = new int128[][](dim1);
        for (uint256 i = 0; i < dim1; ++i) {
            result[i] = new int128[](dim2);
        }
        return result;
    }

    // create 3d matrix in the same shape as [like]
    function _createMatrix(int128[][][] memory like)
        internal
        pure
        returns (int128[][][] memory)
    {
        uint256 dim1 = like.length;
        uint256 dim2 = like[0].length;
        uint256 dim3 = like[0][0].length;
        int128[][][] memory result = new int128[][][](dim1);
        for (uint256 i = 0; i < dim1; ++i) {
            result[i] = new int128[][](dim2);
            for (uint256 j = 0; j < dim2; ++j) {
                result[i][j] = new int128[](dim3);
            }
        }
        return result;
    }

	// convert to floating point
    function convertTo59x18(int128[][] memory a)
        internal
        pure
        returns (int128[][] memory)
    {
        int128[][] memory result = new int128[][](a.length);
        for (uint256 i = 0; i < a.length; ++i) {
            // result[i] = a[i].convertTo59x18();
        }
        return result;
    }

    function dot(int128[][] memory a, int128[][] memory b)
        internal
        pure
        returns (int128[][] memory)
    {
        uint256 l1 = a.length;
        uint256 l2 = b[0].length;
        uint256 zipsize = b.length;
        int128[][] memory c = new int128[][](l1);
        for (uint256 fi = 0; fi < l1; ++fi) {
            c[fi] = new int128[](l2);
            for (uint256 fj = 0; fj < l2; ++fj) {
                int128 entry = 0;
                for (uint256 i = 0; i < zipsize; ++i) {
                    entry += a[fi][i].mul(b[i][fj]);
                }
                c[fi][fj] = entry;
            }
        }
        return c;
    }

    function add(int128[][] memory a, int128[] memory b)
        internal
        pure
        returns (int128[][] memory)
    {
        int128[][] memory result = _createMatrix(a.length, a[0].length);
        for (uint256 i = 0; i < a.length; ++i) {
            for (uint256 j = 0; j < a[0].length; ++j) {
                result[i][j] = a[i][j].add(b[j]);
            }
        }
        return result;
    }
}
