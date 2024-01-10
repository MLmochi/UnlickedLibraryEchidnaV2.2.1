// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;
// Minimal repoduction ECHIDNA-HEVM-allContracts problem
// Unlinked Libraries
// Changing functions: public -> internal inside the ChildLibrary
// However, 

import "./ChildLibrary.sol";

library ParentLibrary{
    using ChildLibrary for address;

    function Add(uint256 x, address y ) public pure returns(uint256 z) {
        z = x + y.addressToUint256();  
    }
}