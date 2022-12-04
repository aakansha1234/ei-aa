pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

contract YourContract {
  struct Tx {
    address a;
    bytes32 a1;
    address b;
    bytes32 b1;
  }
  uint counter;
  mapping(uint => Tx) public txs;

  function registerTx(address a, bytes memory a1, address b, bytes memory b1) external {
    Tx memory tx1 = Tx({
      a:a, a1:keccak256(a1), b:b, b1: keccak256(b1)
    });
    txs[counter]  = tx1;
    counter++;
  }

  function exec(uint countr, bytes memory a1, bytes memory b1) external {
    Tx memory tx1 = txs[countr];
    require(tx1.a1 == keccak256(a1));
    require(tx1.b1 == keccak256(b1));
    (bool success, bytes memory r) = tx1.a.staticcall(a1);
    require(success);
    success = abi.decode(r, (bool));
    require(success);

    (success, bytes memory r1) = tx1.a.call(b1);
    require(success);
  }
}
