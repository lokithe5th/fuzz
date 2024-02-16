
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Asserts} from "@chimera/Asserts.sol";
import {Setup} from "./Setup.sol";

abstract contract Properties is Setup, Asserts {

    function invariant_Accrual(address user, uint256 time) internal view returns (bool) {
        yourContract.BuilderStreamInfo builderStream = yourContract.streamedBuilders(user);
        uint256 actualAccrual = yourContract.unlockedBuilderAmount(user);

        if (time > 2592000) {
            return actualAccrual == builderStream.cap;
        }

        // Can abstract this to a helper function
        uint256 expectedAccrual = builderStream.cap * (block.timestamp - builderStream.last) / 2592000;
        return expectedAccrual == actualAccrual;
    }
}
