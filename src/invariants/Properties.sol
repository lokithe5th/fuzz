
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Asserts} from "@chimera/Asserts.sol";
import {Setup} from "./Setup.sol";

abstract contract Properties is Setup, Asserts {
// test
    function crytic_canary() public view returns (bool) {
        return false;
    }

    function crytic_canary_ok() public view returns (bool) {
        return true;
    }
}
