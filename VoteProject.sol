// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract VoteProject {

    struct poll  {  // 이제 투표 의견을 제기할려면 
        uint number ; // 안건의 번호
        string title ;  // 안건의 제목
        string context ; // 안건의 내용
        address by ; // 안건을 제안한 주소
        uint time ; // 투표의 시간(기한) 설정할려구
        uint pros ; // 그 투표의 찬성
        uint cons ; // 투표의 반대 
        pollStatus status ; // 안건의 상태 ---1
    }

    // 제목을 검색하면 그 투표를 만든 User 정보를 불러 올 수 있게끔 /public로 볼 수 있게 끔 // 안건을 관리할 자료구조 (mapping)
    mapping( string => poll ) public polls ;
    uint public count ; // 안건 수 
    uint public userCount ; // 사용자 수
 
    mapping( address => user ) users ;

    modifier isItUser() {
        require(user[ msg.sender ].addr == msg.sender , "You are not a registered user.") ;
        _ ;
    }

    struct user {
        string name ;
        address addr ;
        string[] suggested ;  // 사용자가 제안한 안건들의 제목 배열
        mapping( string => votingStatus) voted ; // 사용자가 투표한 안건에 대한 투표 상태 (찬성/반대) ---1
    }

    enum votingStatus {      //이거는 유저안에 들어가는거
        notVoted,          
        pro,
        con
    }

    enum pollStatus {                        //이거는 투표 스트럭안에 들가는는 거
        ongoing,        //투표 진행중인 상태
        passed,         //투표 통과된 상태
        rejected        // 투표 기각된 상태
    }

    //사용자 등록 기능 = 사용자를 등록하는 기능
    function pushUser( string calldata _name) public {
        ( user[ msg.sender ].name , user[ msg.sender ].addr  )=  ( _name, msg.sender ) ;
        userCount ++ ;
    }

























}
