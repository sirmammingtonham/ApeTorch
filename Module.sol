// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.13;

contract Module {
	constructor() {}

    function _forward_hook() internal virtual {}

    function forward() internal {}

	function backward() internal {}
}
