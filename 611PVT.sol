// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract VC {
    
    
   

    struct Poll {

        uint number; // pollNumber = generatePollNumber(); //불러올때나 이걸로 불러올거야 이게 아이디값이 디비같이 스트링은 비교하기 어렵지만 넘버는 비교하기 쉽다.
        string title;
        string context;
        address by;
        uint time;// ------------------이시간 블록스템프 가지고와서   xtime = time + endtime
        uint pros; // -> 디비? +1                                    xtime  ==
        uint cons; // -> 디비? +1 
        bool completed;
        voteType votetype; // 0 : 찬반 ,  1 : 선출
        string[] elective; //출마자 ["황재윤", "김영도" , "안재우" ]  => 0,1,2
        uint[] electiveCount;  // 출마자 각 카운트 // -> 디비? [1,0,0] => 카운트 값 
        uint endTime; // 추가된 종료 시간
        string[] regardingUsers; //이메일 권한 확인 -> 이메일 넣어준 사람들만 투표 가능 

    }

     enum voteType { // 찬반 , 선출
        prosAndcons,
        election
    }



     mapping(uint => mapping (address => uint)) voted; //투표하는 것 
            // 투표 number   // 누른 사람   // 찬반  : 찬성 0 , 반대 , 1
            //generatePollNumber         // 선출  : 인덱스 값 재윤 선택시 0 / ["황재윤", "김영도" , "안재우" ]  => 0,1,2
    



    // 투표 생성
    function makeANewPoll(string calldata _title, string calldata _context, uint _voteType, string[] memory _elective,uint _endTime, string[] memory _regardingUsers) public returns(uint pollNumber) {
        require(bytes(_title).length > 0, "Title should not be empty");
        require(bytes(_context).length > 0, "Context should not be empty");


        pollNumber = generatePollNumber();
        uint[] memory _electiveCount = new uint[](_elective.length);

        if(_voteType == 0){ //찬반 나누어 넣기 voteType.prosAndcons || voteType.election
            polls.push(Poll(pollNumber,_title, _context, msg.sender,block.timestamp, 0, 0, false, voteType.prosAndcons , _elective,_electiveCount, _endTime, _regardingUsers ));
        }else{
            polls.push(Poll(pollNumber,_title, _context, msg.sender,block.timestamp, 0, 0, false, voteType.election , _elective,_electiveCount, _endTime, _regardingUsers ));
        } 

    }


// string[] memory elective = new string[](3);
// elective[0] = "황재윤";
// elective[1] = "김영도";
// elective[2] = "안재우";

// string[] memory regardingUsers = new string[](2);
// regardingUsers[0] = "user1@example.com";
// regardingUsers[1] = "user2@example.com";

// uint endTime = block.timestamp + 86400; // 24 hours from now

// uint pollNumber = makeANewPoll("투표 제목", "투표 내용", 0, elective, endTime, regardingUsers);



    // 1. 맵핑을 최소화 하기 위해서 리스트로 바꿈 (가스비 감소를 위해)
    //   ㄴ사유: 맵핑은 키로만 불려 올수 있어 다른 방식으로 넣어주고 싶으면 다른 맵핑이 필요
    //  => 리스트로 대처 (원하는 조건을 if문으로 대조 하고 새 리스트에 담아 출력하는 형식)

    // 2. 투표는 맵핑으로 구현 생각 중 
    //   mapping(uint => (address => uint)) 
    //           number=> (msg.sender =>  string["황재윤", "김영도"]  elective의 인덱스 => ( 황재윤 0  ||  김영도 1 ) || 0 찬성 or 1 반대 )
    //           0x1123 => 0x253671() => 찬반 1 || 선춣형 1
    //   문자로 넣을까??? 고민중 / 문자 대조가 어려움 





















    

  






     











































}
