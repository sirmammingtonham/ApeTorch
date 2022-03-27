// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.13;

import "./Operation.sol";
import "../Tensor.sol";
import "prb-math/contracts/PRBMathSD59x18.sol";
import "solmate/contracts/MatrixUtils.sol";

contract Addition is Operation {
	using PRBMathSD59x18 for int256;
    using MatrixUtils for int256[][];

    T.Tensor x;
    T.Tensor y;

    function forward(T.Tensor memory _x, T.Tensor memory _y) public returns (T.Tensor memory) {
        x = _x;
        y = _y;

        bool requires_grad = false;
        if (x.requires_grad || y.requires_grad) {
            requires_grad = true;
        }

        return T.Tensor(x.item.add(y.item), , requires_grad, this);
    }
}
