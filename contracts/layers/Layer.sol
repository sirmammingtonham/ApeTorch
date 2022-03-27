// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.13;

contract Layer {

	function _forward_hook() internal virtual {}

	function forward() public virtual {}

	function bacward() public virtual {}

}