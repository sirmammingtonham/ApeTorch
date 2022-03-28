// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.13;

import "./operations/Operation.sol";
import "prb-math/contracts/PRBMathSD59x18.sol";
import "solmate/contracts/MatrixUtils.sol";

struct Tensor {
    int256[][] data;
    int256[][] gradient;
}

contract TT {
    using PRBMathSD59x18 for int256;
    using MatrixUtils for int256[][];

    // struct Tensor {
    // 	int256[][] data;
    // 	int256[][] gradient;
    // }

    function add(Tensor memory a, Tensor memory b)
        internal
        pure
        returns (Tensor memory)
    {
        return Tensor(a.data.add(b.data), a.gradient.add(b.gradient));
    }

    function sub(Tensor memory a, Tensor memory b)
        internal
        pure
        returns (Tensor memory)
    {
        return Tensor(a.data.add(b.data.mul(-1)), a.gradient.add(b.gradient.mul(-1)));
    }

	function dot(Tensor memory a, Tensor memory b)
        internal
        pure
        returns (Tensor memory) {
		return Tensor(a.data.dot(b.data), )
	}
}

interface Function {
    function forward() external;

    function backward() external;
    // function getParams() external;
}

// contract Linear is Function {
//     Tensor weights;
//     Tensor bias;

//     function forward(Tensor memory x) public view returns (Tensor memory) {}

//     function backward(Tensor memory dY) public returns (Tensor memory) {}

//     function getParams() public view returns (Tensor[] memory) {}
// }

// struct Dependency {
// 	Tensor tensor;
// 	function () grad_fn;
// }

// struct Tensor {
//     int256[][] data;
//     int256[][] gradient;
//     bool requires_grad;
// 	Dependency[] depends_on;
//     // function () grad_fn;
// }

// function add(Tensor memory a, Tensor memory b) internal {
// 	int256[][] memory data = a.data.add(b.data);
// 	bool requires_grad = a.requires_grad || b.requires_grad;
// 	// Dependency[] memory depends_on;
// 	Dependency[2] memory depends_on;
// 	if (a.requires_grad) {
// 		depends_on[0] = Dependency(a, )
// 	}
// }

// contract Tensor {
//     int256[][] item;
//     bool requires_grad;
//     int256[][] grad;
//     Operation grad_fn;

//     constructor(int256[][] memory _item, bool _requires_grad) {
//         item = _item;
//         requires_grad = _requires_grad;
//     }

//     function requiresGrad() public view returns (bool) {
//         return requires_grad;
//     }

//     function setGradFn(Operation _grad_fn) public {
//         grad_fn = _grad_fn;
//     }

//     function addition() public {}

//     function multiplication() public {}

//     function relu() public {}
// }
