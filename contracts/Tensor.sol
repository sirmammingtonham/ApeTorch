// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.13;

import "./operations/Operation.sol";

contract T {
    struct Value {
        int256 data;
        int256 gradient;
        bool requires_grad;
        function(Value memory) internal pure returns (Value memory) backward;
    }

    function addition(Value memory a, Value memory b)
        internal
        pure
        returns (Value memory)
    {
        return
            Value(
                a.data + b.data,
                0,
                a.requires_grad || b.requires_grad,
                _addition_backwards
            );
    }

    function _addition_backwards(Value memory a)
        internal
        pure
        returns (Value memory)
    {
        a.gradient += (a.data > 0 ? int256(1) : int256(0)) * a.gradient;
        return a;
    }

    function multiplication(Value memory a, Value memory b) internal {}

    function relu(Value memory a) internal pure returns (Value memory) {
        return
            Value(
                a.data * (a.data > 0 ? int256(1) : int256(0)),
                0,
                a.requires_grad,
                _relu_backwards
            );
        // a.data = a.data * (a.data > 0 ? int256(1) : int256(0));

        // if (a.requires_grad) {
        //     a.backward = _relu_backwards;
        // }

        // return a;
    }

    function _relu_backwards(Value memory a)
        internal
        pure
        returns (Value memory)
    {
        a.gradient += (a.data > 0 ? int256(1) : int256(0)) * a.gradient;
        return a;
    }
}

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
