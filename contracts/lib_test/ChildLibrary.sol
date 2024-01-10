// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;
// Minimal repoduction ECHIDNA-HEVM-allContracts problem
// Library with a single pubic function that creates an HEVM CallStack error
// Unlinked Libraries
// Changing public -> internal inside this ChildLibrary fixes this bug

library ChildLibrary{
    function addressToUint256(address a) public pure returns(uint256) {
        return uint256(uint160(a));
    }
}


