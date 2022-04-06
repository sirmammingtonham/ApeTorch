// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.13;

import {ABDKMath64x64 as Math64} from "../util/ABDKMath64x64.sol";

library TensorOps {
    using Math64 for int128;

    ////////////////////////////////// MATRIX CREATION FUNCTIONS //////////////////////////////////////

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
    function _emptyLike(int128[][] memory like)
        internal
        pure
        returns (int128[][] memory)
    {
        return _createMatrix(like.length, like[0].length);
    }

    // create 3d matrix in the same shape as [like]
    function _emptyLike(int128[][][] memory like)
        internal
        pure
        returns (int128[][][] memory)
    {
        return _createMatrix(like.length, like[0].length, like[0][0].length);
    }

    ////////////////////////////////// ADDITION //////////////////////////////////////

    // this might not be efficient because we are calling a separate function each iteration, need to run some tests //
    function add(int128[] memory self, int128[] memory other)
        internal
        pure
        returns (int128[] memory)
    {
        int128[] memory result = new int128[](self.length);
        for (uint256 i = 0; i < self.length; ++i) {
            result[i] = self[i].add(other[i]); // use abdk library to add
        }
        return result;
    }

    function add(int128[][] memory self, int128[][] memory other)
        internal
        pure
        returns (int128[][] memory)
    {
        int128[][] memory result = _emptyLike(self);
        for (uint256 i = 0; i < self.length; ++i) {
            result[i] = add(self[i], other[i]);
        }
        return result;
    }

    function add(int128[][][] memory self, int128[][][] memory other)
        internal
        pure
        returns (int128[][][] memory)
    {
        int128[][][] memory result = _emptyLike(self);
        for (uint256 i = 0; i < self.length; ++i) {
            result[i] = add(self[i], other[i]);
        }
        return result;
    }

    function add(int128[][] memory self, int128[] memory other)
        internal
        pure
        returns (int128[][] memory)
    {
        int128[][] memory result = _emptyLike(self);
        for (uint256 i = 0; i < self.length; ++i) {
            result[i] = add(self[i], other);
        }
        return result;
    }

    ////////////////////////////////// SUBTRACTION //////////////////////////////////////

    function sub(int128[] memory self, int128[] memory other)
        internal
        pure
        returns (int128[] memory)
    {
        int128[] memory result = new int128[](self.length);
        for (uint256 i = 0; i < self.length; ++i) {
            result[i] = self[i].sub(other[i]); // use abdk library to subtract
        }
        return result;
    }

    function sub(int128[][] memory self, int128[][] memory other)
        internal
        pure
        returns (int128[][] memory)
    {
        int128[][] memory result = _emptyLike(self);
        for (uint256 i = 0; i < self.length; ++i) {
            result[i] = sub(self[i], other[i]);
        }
        return result;
    }

    function sub(int128[][][] memory self, int128[][][] memory other)
        internal
        pure
        returns (int128[][][] memory)
    {
        int128[][][] memory result = _emptyLike(self);
        for (uint256 i = 0; i < self.length; ++i) {
            result[i] = sub(self[i], other[i]);
        }
        return result;
    }

    function sub(int128[][][] memory self, int128 other)
        internal
        pure
        returns (int128[][][] memory)
    {
        int128[][][] memory result = _emptyLike(self);
        for (uint256 i = 0; i < result.length; ++i) {
            for (uint256 j = 0; j < result[0].length; ++j) {
                for (uint256 k = 0; k < result[0][0].length; ++k) {
                    result[i][j][k] = result[i][j][k].sub(other);
                }
            }
        }
        return result;
    }

    function rsub(int128[][][] memory self, int128 other)
        internal
        pure
        returns (int128[][][] memory)
    {
        int128[][][] memory result = _emptyLike(self);
        for (uint256 i = 0; i < result.length; ++i) {
            for (uint256 j = 0; j < result[0].length; ++j) {
                for (uint256 k = 0; k < result[0][0].length; ++k) {
                    result[i][j][k] = other.sub(result[i][j][k]);
                }
            }
        }
        return result;
    }

    ////////////////////////////////// DIVISION //////////////////////////////////////

    function div(int128[] memory self, int128[] memory other)
        internal
        pure
        returns (int128[] memory)
    {
        int128[] memory result = new int128[](self.length);
        for (uint256 i = 0; i < self.length; ++i) {
            result[i] = self[i].div(other[i]); // use abdk library to div
        }
        return result;
    }

    function div(int128[][] memory self, int128[][] memory other)
        internal
        pure
        returns (int128[][] memory)
    {
        int128[][] memory result = _emptyLike(self);
        for (uint256 i = 0; i < self.length; ++i) {
            result[i] = div(self[i], other[i]);
        }
        return result;
    }

    function div(int128[][][] memory self, int128[][][] memory other)
        internal
        pure
        returns (int128[][][] memory)
    {
        int128[][][] memory result = _emptyLike(self);
        for (uint256 i = 0; i < self.length; ++i) {
            result[i] = div(self[i], other[i]);
        }
        return result;
    }

    ////////////////////////////////// MULTIPLY //////////////////////////////////////

    function mul(int128[] memory self, int128[] memory other)
        internal
        pure
        returns (int128[] memory)
    {
        int128[] memory result = new int128[](self.length);
        for (uint256 i = 0; i < self.length; ++i) {
            result[i] = self[i].mul(other[i]); // use abdk library to mul
        }
        return result;
    }

    function mul(int128[][] memory self, int128[][] memory other)
        internal
        pure
        returns (int128[][] memory)
    {
        int128[][] memory result = _emptyLike(self);
        for (uint256 i = 0; i < self.length; ++i) {
            result[i] = mul(self[i], other[i]);
        }
        return result;
    }

    function mul(int128[][][] memory self, int128[][][] memory other)
        internal
        pure
        returns (int128[][][] memory)
    {
        int128[][][] memory result = _emptyLike(self);
        for (uint256 i = 0; i < self.length; ++i) {
            result[i] = mul(self[i], other[i]);
        }
        return result;
    }

    ////////////////////////////////// LINALG //////////////////////////////////////

    function dot(int128[][] memory self, int128[][] memory other)
        internal
        pure
        returns (int128[][] memory)
    {
        uint256 l1 = self.length;
        uint256 l2 = other[0].length;
        uint256 zipsize = other.length;
        int128[][] memory c = new int128[][](l1);
        for (uint256 fi = 0; fi < l1; ++fi) {
            c[fi] = new int128[](l2);
            for (uint256 fj = 0; fj < l2; ++fj) {
                int128 entry = 0;
                for (uint256 i = 0; i < zipsize; ++i) {
                    entry += self[fi][i].mul(other[i][fj]);
                }
                c[fi][fj] = entry;
            }
        }
        return c;
    }

    ////////////////////////////////// OTHER //////////////////////////////////////

    /**
	@notice returns a copy of the array with an elementwise max(value)
	*/
    function max(int128[][][] memory self, int128 value)
        internal
        pure
        returns (int128[][][] memory)
    {
        int128[][][] memory result = _emptyLike(self);
        for (uint256 i = 0; i < result.length; ++i) {
            for (uint256 j = 0; j < result[0].length; ++j) {
                for (uint256 k = 0; k < result[0][0].length; ++k) {
                    result[i][j][k] = result[i][j][k] > value
                        ? result[i][j][k]
                        : value;
                }
            }
        }
        return result;
    }

    function exp(int128[][][] memory self)
        internal
        pure
        returns (int128[][][] memory)
    {
        int128[][][] memory result = _emptyLike(self);
        for (uint256 i = 0; i < result.length; ++i) {
            for (uint256 j = 0; j < result[0].length; ++j) {
                for (uint256 k = 0; k < result[0][0].length; ++k) {
                    result[i][j][k] = Math64.exp(result[i][j][k]);
                }
            }
        }
        return result;
    }
}
