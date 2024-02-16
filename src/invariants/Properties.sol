
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Asserts} from "@chimera/Asserts.sol";
import {Setup, YourContract} from "./Setup.sol";

abstract contract Properties is Setup, Asserts {

    function invariant_Accrual(address user, uint256 time) internal view returns (bool) {
        (uint256 cap, uint256 last, address token) = yourContract.streamedBuilders(user);
        uint256 actualAccrual = yourContract.unlockedBuilderAmount(user);

        if (time > last + 2592000) {
            return actualAccrual == cap;
        }

        // Can abstract this to a helper function
        uint256 expectedAccrual = cap * (block.timestamp - last) / 2592000;
        return expectedAccrual == actualAccrual;
    }
}
