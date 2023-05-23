

// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import './b.sol'; //import '.(윗단계)/위치/파일명';
import './d/dd.sol';

contract A {
    B_SmartContract b = new B_SmartContract();
    D_Contract d_con = new D_Contract();

    function add(uint _a, uint _b) public view returns(uint) {
        return b.add(_a, _b);//8번줄 에 들어있는 add함수 들고옴
    }

    function multi(uint _a, uint _b) public view returns(uint) {
        return d_con.multiply(_a, _b);
    }
}