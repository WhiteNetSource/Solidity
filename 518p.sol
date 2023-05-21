// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Q20 {
	uint[] numbers;
	function pushNumbers() public {
		for(uint i=0; i<15; i++) {
			numbers.push(i+1);
		}
		
		for(uint i=3;i<=15;i+=3) {
			delete numbers[i-1];
		}
	}

      function getArr() public view returns(uint[] memory) {
        return numbers;
    }
}