// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;
// Minimal repoduction ECHIDNA-HEVM-allContracts problem

import "./lib_test/ParentLibrary.sol";

contract BugTest {

    bool testValue_ = false;
    constructor() { }

    function callToFailtest(uint256 x) public {
        if (x == 3 ) {
            testValue_ = true;
        }
    }

    function echidna_testValueNeverTrue() public view returns(bool){
        return testValue_ == false;
    }


}
