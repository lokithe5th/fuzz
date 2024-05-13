
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Asserts} from "@chimera/Asserts.sol";
import {Setup, YourContract} from "./Setup.sol";

abstract contract Properties is Setup, Asserts {

    function crytic_canary() internal view returns (bool) {
        return false;
    }
}
