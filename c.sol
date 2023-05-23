// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/utils/Strings.sol"; //무조건 외부 view

contract c {
    function UtoS(uint _n) public pure returns(string memory) { //라이브러리는 내부pure
        return Strings.toString(_n);
    }
}       
