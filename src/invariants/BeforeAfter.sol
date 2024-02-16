
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Setup} from "./Setup.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

abstract contract BeforeAfter is Setup {

    struct Vars {
        uint256 claimableByUser;
        mapping(address => uint256) tokenBalance;
        mapping(address => uint256) streamBalance;
        mapping(address => bool) isBuilder;
        mapping(address => uint256) contractBalance;
    }

    Vars internal _before;
    Vars internal _after;

/**
- A builder SHOULD only be able to claim up and equal to their `cap`
- A builder SHOULD only have one stream allocated at a time  
- A builder SHOULD be able to claim all the funds in a stream immediately after being added
- Claimable funds SHOULD accrue linearly according to time passed up to `FREQUENCY` 
- Additional funds SHOULD NOT accrue once `FREQUENCY` has passed
- When withdrawing from a stream the contract balance after withdrawal SHOULD be equal to the balance before - withdrawn amount
- Non-builders SHOULD NOT be able to claim streams
- Only the owner SHOULD be able to access privileged functions.
 */

    function __before(address user) internal {
        yourContract.BuilderStreamInfo streamInfo = yourContract.streamedBuilders(user);

        if (streamInfo.optionalTokenAddress != address(0)) {
            _before.tokenBalance = IERC20(streamInfo.optionalTokenAddress).balanceOf(user);
        } else {
            _before.tokenBalance = user.balance;
        }

        _before.claimableByUser = yourContract.unlockedBuilderAmount(user);
    }

    function __after(address user) internal {
        yourContract.BuilderStreamInfo streamInfo = yourContract.streamedBuilders(user);

        if (streamInfo.optionalTokenAddress != address(0)) {
            _after.tokenBalance = IERC20(streamInfo.optionalTokenAddress).balanceOf(user);
        } else {
            _after.TokenBalance = user.balance;
        }

        _after.claimableByUser = yourContract.unlockedBuilderAmount(user);
    }
}
