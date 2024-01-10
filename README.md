# UnlickedLibraryEchidnaV2.2.1

Reproduction of the "Unlinked Libraries" problem in Echidna V2.2.1.
This repo is built with hardhat.

## To reproduce the error:

Current error can be reproduced by running Echidna from either :

- The [pre-built Docker container](https://github.com/crytic/building-secure-contracts/blob/master/program-analysis/echidna/introduction/installation.md) (HEVM version 0.51.3)
- The static binary built from `master` branch Git-repo with [Nix](https://github.com/crytic/echidna#building-using-nix-works-natively-on-apple-m1-systems) (commit:`9d502be` HEVM Version 0.52.0)

### Install Packages

```bash
git clone https://github.com/MLmochi/UnlinkedLibraryEchidnaV2.2.1.git
yarn
npx hardhat compile
```

### Run Echidna with `-all-contracts`

```bash
echidna . --contract BugTest --all-contracts
```

And we will see the error:

```bash
Compiling .... Done! (3.916624396s)
Analyzing contract: ! .../UnlinkedLibraryEchidnaV2.2.1/contracts/BugTest.sol:BugTest
echidna: Error toCode: unlinked libraries detected in bytecode, in .../UnlinkedLibraryEchidnaV2.2.1/contracts/lib_test/ParentLibrary.sol:ParentLibrary
CallStack (from HasCallStack):
  error, called at src/EVM/Solidity.hs:655:18 in hevm-0.52.0-ErVC6GnmnDjLE72MJ8q1kA:EVM.Solidity
```

Note if we change the function inside `ChildLibrary.sol`:

```
function addressToUint256(address a) public pure returns(uint256)  --> function addressToUint256(address a) internal pure returns(uint256)
```

This will 'fix' the error, however, with respect to fuzzing/testing a protocol codebase, I don't think changing the protocol is the way to go here.

## Related issues

This issue seems to be related to a [previous issue (closed) in the dAppTools repo about linking libraries](https://github.com/dapphub/dapptools/issues/802). This should have been fixed and updated in the DappsTools repo a long time ago, so I do not exactly understand why this error still persists in Echidna. A second solution provided in the same thread is _commenting out the library linking disable setting in `.dapprc`_. I have tried to look for this file, or something similar, inside the pre-built docker container, but I have not been successful.

If anyone can guide how to fix this and get Echidna going for these type of contract interaction, I would be thankful.

## Additional notes & questions:

- Why does the `all-contracts` + HEVM raise troubles in te first place, since in the `BugTest` contract does not even import or deploy these libraries? _From my understanding with the `all-contracts` option we should only call all the contracts that have been deployed inside the testing contract?_
- An obvious trivial and 3rd solution is disabling the 'problematic'-libraries. However, the actual protocol I aim to fuzz/test is a complex system with many 'key/critical'-functions written like that. I rather keep the codebase as it is and built my fuzz tests around the system as a whole, if possible.

## Fix/workaround already exists:

https://github.com/crytic/echidna/issues/836
