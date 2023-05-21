// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

 




contract arr {

    // 숫자만 들어가는 배열을 선언하고 숫자를 넣는 함수를 구현하세요.
    uint[] arrays;

    function array() public {
       for(uint i=0; i<15; i++){
           arrays.push(i+1);
       }
       for(uint i = 3; i <= 15; i+=3){    //3
            delete arrays[i-1];
        } 
    }

    // 15개의 숫자가 들어가면 3의 배수 위치에 있는 숫자들을 초기화 시키는(3번째, 6번째, 9번째 등등) 함수를 구현하세요.
    //  (for 문 응용 → 약간 까다로움)
    function getArr() public view returns(uint[] memory) {
        return arrays;
    }

}

