// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Time{
 
// 숫자를 시분초로 변환하세요.
// 예) 100 -> 1분 40초, 600 
// -> 10분, 1000 -> 16분 40초,
//  5250 -> 1시간 27분 30초

    struct T {
        uint hour;  
        uint minute;
        uint second;
    }

    
   T times[3] = {{0, 0, 0}, {0, 0, 0}, {0, 0, 0}};// <- 어케 넣지

  function getTime(uint time) public pure returns(uint) {
        
        uint hour = time / 3600;
        uint minute = time % 3600 / 60;
        uint second = time % 60 % 60;

        if (time < 60) {
            return second;
        } else if (time < 3600) {
            return minute;
        } else {
            return hour;
        }
    }

}