// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract VoteProject {

    struct poll  {  // 이제 투표 의견을 제기할려면 
        uint number ; // 제기내용의 숫자
        string title ;  // 제기할 제목
        string context ; // 내용
        address user ; // 누가 제기했는지
        uint time ; // 투표의 시간(기한) 설정할려구
        uint pros ; // 그 투표의 찬성
        uint cons ; // 투표의 반대 

    }

    // 제목을 검색하면 그 투표를 만든 User 정보를 불러 올 수 있게끔 /public로 볼 수 있게 끔
    mapping( string => poll ) public polls ;
    
}
