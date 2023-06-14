// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

// contract voteChain {
//     struct poll {
//         uint number;
//         string title;
//         string context;
//         address by;
//         uint time;
//         uint pros;
//         uint cons;
//         pollStatus status;
//     }

//    struct elective {
//        uint number;
//        string title;
//        string context;
//        address by;
//        string[] candidate;
//    }

//     // poll을 관리할 자료구조 , array or mapping
//     mapping(uint => poll) public polls;     // * 전체 안건 확인 기능 - 제목으로 안건을 검색하면 번호, 제목, 내용, 제안자, 찬반 수 모두를 반환하는 기능
//     uint public count; // 안건 수
//     uint public userCount; // user 수

//     enum votingStatus {
//         notVoted,
//         pro,
//         con
//     }

//     enum pollStatus {
//         ongoing,
//         passed,
//         rejected
//     }

//     struct user {
//         string name;
//         address addr;
//         string[] suggested;
//         mapping(string=>votingStatus) voted;
//     }

//     // user를 관리할 자료구조 mapping
//     mapping(address=>user) users;

//     modifier isItUser() {
//         require(users[msg.sender].addr == msg.sender);
//         _;
//     }

//     // * 사용자 등록 기능 - 사용자를 등록하는 기능
//     function pushUser(string calldata _name) public {
//         (users[msg.sender].name, users[msg.sender].addr) = (_name, msg.sender);
//         userCount++;
//     }

//     // * 투표하는 기능 - 특정 안건에 대하여 투표하는 기능, 안건은 제목으로 검색, 이미 투표한 건에 대해서는 재투표 불가능
//     function vote(string calldata _title, bool _vote) external/*상속받은 애도 못하게*/ isItUser {
//         require(users[msg.sender].voted[_title]==votingStatus.notVoted && polls[_title].status == pollStatus.ongoing); //투표자가 해당 안건에 대해서 투표를 안했어야 함
//         // 찬성이냐, 반대이냐
//         if(_vote==true) {
//             polls[_title].pros++;
//             users[msg.sender].voted[_title] = votingStatus.pro;
//         } else {
//             polls[_title].cons++;
//             users[msg.sender].voted[_title] = votingStatus.con;
//         }
//     }

//     // * 제안한 안건 확인 기능 - 자신이 제안한 안건에 대한 현재 진행 상황 확인기능 - (번호, 제목, 내용, 찬반 반환 // 밑의 심화 문제 풀었다면 상태도 반환)
//     function searchSuggested(string calldata _title) public view returns(poll memory) {
//         require(msg.sender==polls[_title].by, "You did not suggested it.");
//         return polls[_title];
//     }

//     // * 안건 제안 기능 - 자신이 원하는 안건을 제안하는 기능
//     function suggest(string calldata _title, string calldata _context) public isItUser {
//         polls[_title] = poll(++count, _title, _context, msg.sender, block.timestamp, 0,0, pollStatus.ongoing);
//     }

//     // * 전체 안건 확인 기능 - 제목으로 안건을 검색하면 번호, 제목, 내용, 제안자, 찬반 수 모두를 반환하는 기능
//     function getPoll(string memory _title) public view returns(poll memory) {
//         return polls[_title];
//     }

//     // * 안건 진행 과정 - 투표 진행중, 통과, 기각 상태를 구별하여 알려주고 전체의 70% 그리고 투표자의 66% 이상이 찬성해야 통과로 변경, 둘 중 하나라도 만족못하면 기각
//     function finishPoll(string memory _title) external isItUser {
//         require(block.timestamp > polls[_title].time+100); /*100이 아닌 다른 숫자로도 가능(input 값), 자신이 제안한 안건만 마무리할 수 있게*/
//         if((polls[_title].pros + polls[_title].cons) > userCount*7/10 && (polls[_title].pros) *100 / (polls[_title].pros + polls[_title].cons)  > 66 ) {
//             polls[_title].status = pollStatus.passed;
//         } else {
//             polls[_title].status = pollStatus.rejected;
//         }
//     }
// }

contract VC {

    //1.   투표만들기  => makeANewPoll
    //2.   투표하기 => voting
    //2.1  투표 출력 (내가 권한 가진 것만 나오기 email) => getRegardingUserPolls
    //2.2  투표하기 <- 권한이 없으면 리젝트 => voting, checkVoter
    //3.   투표 결과 보기
    //3.1  내가 만든 투표 리스트 (결과 또는 상태) => getMadeVote
    //3.2  내가 한 투표 보기 (결과 또는 상태)
    //4    투표 완료 하기 (시간이 지나면 자동 완료 //   bool completed; -> true) => checkVoter


    // 1. 맵핑을 최소화 하기 위해서 리스트로 바꿈 (가스비 감소를 위해)
    //   ㄴ사유: 맵핑은 키로만 불려 올수 있어 다른 방식으로 넣어주고 싶으면 다른 맵핑이 필요
    //  => 리스트로 대처 (원하는 조건을 if문으로 대조 하고 새 리스트에 담아 출력하는 형식)

    // 2. 투표는 맵핑으로 구현 생각 중 
    //   mapping(uint => (address => uint)) 
    //           number=> (msg.sender =>  string["황재윤", "김영도"]  elective의 인덱스 => ( 황재윤 0  ||  김영도 1 ) || 0 찬성 or 1 반대 )
    //           0x1123 => 0x253671() => 찬반 1 || 선춣형 1
    //   문자로 넣을까??? 고민중 / 문자 대조가 어려움 

 
   mapping(uint => mapping (address => uint)) voted; //투표하는 것 
            // 투표 number   // 누른 사람   // 찬반  : 찬성 0 , 반대 , 1
            //generatePollNumber         // 선출  : 인덱스 값 재윤 선택시 0 / ["황재윤", "김영도" , "안재우" ]  => 0,1,2

    struct Poll {
        uint number; // pollNumber = generatePollNumber();
        string title;
        string context;
        address by;
        uint time;
        uint pros; // -> 디비? +1 1 => 찬성
        uint cons; // -> 디비? +1 2 => 반대 
        bool completed;
        voteType votetype; //0: 투표전 ,  1: 찬반 ,  2 : 선출
        string[] elective; //출마자 ["황재윤", "김영도" , "안재우" ]  => 0,1,2
        uint[] electiveCount;  // 출마자 각 카운트 // -> 디비? [1,0,0] => 카운트 값 
        uint endTime; // 추가된 종료 시간
        string[] regardingUsers; //이메일 권한 확인 -> 이메일 넣어준 사람들만 투표 가능 
    }

     
        // uint number;  //0x23798// pollNumber = generatePollNumber();
        // string title; //반장선거
        // string context; //2반 2023 06-08 선거
        // address by; // 만든 사람 지갑주소 0x12342
        // uint time; // 블럭타임 스템프
        // uint pros; // -> 디비? +1 찬성
        // uint cons; // -> 디비? +1 반대
        // bool completed; // false -> true 완료 // 시간 완되면 false -> true 돌려주면됨 
        // voteType votetype; // 0 : 찬반 ,  1 : 선출
        // string[] elective; //출마자 ["황재윤", "김영도" , "안재우" ]  => 0,1,2
        // uint[] electiveCount;  // 출마자 각 카운트 // -> 디비? [2,1,0] => 카운트 값 
        // uint endTime; // 추가된 종료 시간
        // string[] regardingUsers; //이메일 권한 확인 -> 이메일 넣어준 사람들만 투표 가능 

    enum voteType { // 찬반 , 선출
        prosAndcons,
        election
    }

    Poll[] private polls; //권한 있는 이메일만 나옴 , 내가 만든 투표, 모든 투표
    
    // 권한 있는 이메일을 가진 투표 리스트만 출력
    function getRegardingUserPolls(string memory _email) external view returns (Poll[] memory) {
        Poll[] memory matchingPolls = new Poll[](polls.length);
        uint matchingPollsCount = 0;

        for (uint i = 0; i < polls.length; i++) {
            for (uint j = 0; j < polls[i].regardingUsers.length; j++) {
                if (keccak256(abi.encodePacked(_email)) == keccak256(abi.encodePacked(polls[i].regardingUsers[j]))) {
                    matchingPolls[matchingPollsCount] = polls[i];
                    matchingPollsCount++;
                    break;
                }
            }
        }
        // 필요한 길이로 자름
        Poll[] memory result = new Poll[](matchingPollsCount);
        for (uint i = 0; i < matchingPollsCount; i++) {
            result[i] = matchingPolls[i];
        }
        return result;
    }

    // 그 투표 가지고 오기 
    function getTheVote(uint _voteNumber) private view returns (Poll memory) {
         Poll memory getPoll;
         for (uint i = 0; i < polls.length; i++) {
            if (polls[i].number == _voteNumber){ //투표 번호로 찾기
                getPoll = polls[i];
            }
         }   

         return  getPoll;
    }

    //내가 만든 투표 리스트
    function getMadeVote(address _by) external  view returns (Poll[] memory) {
        Poll[] memory madePolls = new Poll[](polls.length);
        uint pollsCount = 0;

        for (uint i = 0; i < polls.length; i++) {
            if (keccak256(abi.encodePacked(_by)) == keccak256(abi.encodePacked(polls[i].by))) {
                madePolls[pollsCount] = polls[i];
                pollsCount++;
            }
        }

        // 필요한 길이로 자름
        Poll[] memory result = new Poll[](pollsCount);
        for (uint i = 0; i < pollsCount; i++) {
            result[i] = madePolls[i];
        }

        return result;
    }

    // 투표 생성
    function makeANewPoll(string calldata _title, string calldata _context, uint _voteType, string[] memory _elective,uint _endTime, string[] memory _regardingUsers) public returns(uint pollNumber) {
        require(bytes(_title).length > 0, "Title should not be empty");
        require(bytes(_context).length > 0, "Context should not be empty");


        pollNumber = generatePollNumber();
        // uint[] memory _electiveCountZoro = new uint[](1); -> 프론트
        // string[] memory _electiveZoro = new string[](1); -> 프론트 

        uint[] memory _electiveCount = new uint[](_elective.length);

        if(_voteType == 0){ //찬반 나누어 넣기 voteType.prosAndcons || voteType.election
            polls.push(Poll(pollNumber,_title, _context, msg.sender,block.timestamp, 0, 0, false, voteType.prosAndcons , _elective, _electiveCount, _endTime, _regardingUsers ));
        }else{
            polls.push(Poll(pollNumber,_title, _context, msg.sender,block.timestamp, 0, 0, false, voteType.election , _elective, _electiveCount, _endTime, _regardingUsers ));
        } 

    }

    // 투표 번호 생성
    function generatePollNumber() private view returns (uint) {
        // 원하는 방식으로 투표 번호를 생성하는 로직 작성
        // 예: 블록 넘버와 타임스탬프를 조합하여 유일한 번호 생성
        
        uint blockNumber = block.number;
        uint timestamp = block.timestamp;
        uint pollNumber = blockNumber * 100000 + timestamp % 100000;
        
        return pollNumber;
    }

    //투표 권한 확인 하기 
    modifier checkVoter(uint _voteNumber , address _user , string calldata _email) {
        require(voted[_voteNumber][_user] ==  0, "already voted");
        bool checkEmail;
        bool checkCompleted;
        bool checkVoteNumberExists; 
        uint _endTime;
        for (uint i = 0; i < polls.length; i++) {
            if (polls[i].number == _voteNumber){ //투표 번호로 찾기
                checkVoteNumberExists = true; // 없는 투표 number
                if (polls[i].completed == false) { // 그 투표 상태 확인 (진행중|| 끝)
                    _endTime = block.timestamp + polls[i].endTime;
                    if (block.timestamp >=  _endTime) { // 투표 시간이 넘은 투표는 completed = true
                        polls[i].completed = true;
                        checkCompleted = false; 
                    }else{
                        checkCompleted = true;
                    }   
                }

                for (uint j = 0; j < polls[i].regardingUsers.length; j++) {
                    //이메일 권한 확인 하기 
                    if ( keccak256(abi.encodePacked(_email)) == keccak256(abi.encodePacked(polls[i].regardingUsers[j]))) {
                        checkEmail = true; 
                    }
                }
            } 
        }
        require(checkVoteNumberExists == true, "vote number does not exist"); 
        require(checkCompleted ==  true, "not voting period");
        require(checkEmail ==  true, "you don't have a authority");
        _; // 함수가 실행되는 시점
    }

    //투표하기 
    function voting(uint _voteNumber, uint _votedNumber, string calldata _email) external checkVoter( _voteNumber , msg.sender, _email){
        for (uint i = 0; i < polls.length; i++) {
            if (polls[i].number == _voteNumber){ //투표 번호로 찾기
               if(polls[i].votetype == voteType.prosAndcons){

                   if(_votedNumber == 1){ //1은 찬성 / 2은 반대 
                       polls[i].pros += 1; 
                   } else {
                       polls[i].cons += 1; 
                   }

                }else{
                   addVotedElectiveCount( _voteNumber , _votedNumber); //electiveCount 추가 함수
                }
            }
         }   
        
        voted[_voteNumber][msg.sender] = _votedNumber; 
    }


    //electiveCount 추가 / 투표 번호 _number / _electiveIndex == electiveCount의 인덱스 값 => elective의 인덱스 값과 같음 
    function addVotedElectiveCount(uint _number , uint _electiveIndex) private {
        for (uint i = 0; i < polls.length; i++) {
            if(_number == polls[i].number){
                for (uint j = 0; j < polls[i].electiveCount.length; j++) {
                    if ( _electiveIndex == polls[i].electiveCount[j]) {
                        polls[i].electiveCount[j] += 1;  
                    }
                }
            }
             
        }
    }

    //내가 한 투표 전부
//     function getMyVotedAll() external view returns(Poll[] memory , string memory){
//         uint[] memory votNumbers  = new uint[](polls.length);
//         uint[] memory votNumbers  = new uint[](polls.length);
//         Poll[] memory mypolls  = new Poll[](polls.length);
//         for (uint i = 0; i < polls.length; i++) {
//             votNumbers[i] = polls[i].number;
//              for (uint j = 0; j < polls.length; j++) {
//                 mypolls[i] = voted[votNumbers[j]][msg.sender];
//              }
//         }
//   mapping(uint => mapping (address => uint)) voted; 

//     }



    // 투표 하는 걸 만들 때 
    // 1. 투표 번호 _number 가지고 와  -> 투표 할거 찾아오는 것 
    //  for (uint i = 0; i < polls.length; i++) {
    //   if(_number == polls[i].number){
    //   polls[i] => 투표 해야하는것 
    //  2.어떤 투표 인지 확인  votetype
    //  if (votetype == voteType.prosAndcons) { 찬반 
    //      mapping(uint => mapping (address => uint)) voted
    //              투표번호  = > 투표하는 사람 주소 => 0||1 (찬 || 반 )
    //      uint pros; ||  uint cons;  +1
    //   }else{ 선출 
    //    
    //   }
        
    // mapping(uint => mapping (address => uint)) voted






  // 투표 생성
    // function createPoll(string memory _title, string memory _context, uint _time) public returns(uint pollNumber) {
    //     require(bytes(_title).length > 0, "Title should not be empty");
    //     require(bytes(_context).length > 0, "Context should not be empty");
        
    //     uint pollNumber = generatePollNumber(); // 새로운 투표 번호 생성
        
    //     Poll storage newPoll = polls[pollNumber]; //숫자로 만들기
    //     newPoll.number = pollNumber;
    //     newPoll.title = _title;
    //     newPoll.context = _context;
    //     newPoll.by = msg.sender;
    //     newPoll.time = _time;
    //     newPoll.pros = 0;
    //     newPoll.cons = 0;
    //     newPoll.completed = false;
    //     newPoll.endTime = block.timestamp + _time; // 종료 시간 설정
        
    //     userPolls[msg.sender].push(pollNumber);
    // }



    // // 투표 찬성
    // function votePros(string memory _title) public {
    //     require(bytes(_title).length > 0, "Title should not be empty");
    //     require(!voted[msg.sender][_title], "Already voted for this poll");
        
    //     Poll storage poll = polls[_title];
    //     require(poll.number > 0, "Poll does not exist");
    //     require(!poll.completed, "Poll is already completed");
    //     require(block.timestamp < poll.endTime, "Poll has ended"); // 투표 종료 여부 확인
        
    //     poll.pros += 1;
    //     voted[msg.sender][_title] = true;
    // }

    // // 투표 반대
    // function voteCons(string memory _title) public {
    //     require(bytes(_title).length > 0, "Title should not be empty");
    //     require(!voted[msg.sender][_title], "Already voted for this poll");
        
    //     Poll storage poll = polls[_title];
    //     require(poll.number > 0, "Poll does not exist");
    //     require(!poll.completed, "Poll is already completed");
    //     require(block.timestamp < poll.endTime, "Poll has ended"); // 투표 종료 여부 확인
        
    //     poll.cons += 1;
    //     voted[msg.sender][_title] = true;
    // }

    // // 투표 완료
    // function completePoll(string memory _title) public {
    //     require(bytes(_title).length > 0, "Title should not be empty");
        
    //     Poll storage poll = polls[_title];
    //     require(poll.number > 0, "Poll does not exist");
    //     require(poll.by == msg.sender, "Only the creator can complete the poll");
    //     require(block.timestamp >= poll.endTime, "Poll has not yet ended"); // 투표 종료 여부 확인
        
    //     poll.completed = true;
    // }

    // // 최신 투표 리스트 반환
    // function getLatestPolls() public view returns (string[] memory) {
    //     uint pollCount = getPollCount();
    //     uint count = pollCount > 5 ? 5 : pollCount;
    //     string[] memory latestPolls = new string[](count);
        
    //     for (uint i = 0; i < count; i++) {
    //         latestPolls[i] = userPolls[msg.sender][pollCount - 1 - i];
    //     }
        
    //     return latestPolls;
    // }

    // // 투표 상세 정보 반환
    // function getPollDetails(string memory _title) public view returns (uint, string memory, string memory, address, uint, uint, uint, bool, uint) {
    //     Poll storage poll = polls[_title];
    //     require(poll.number > 0, "Poll does not exist");
        
    //     return (poll.number, poll.title, poll.context, poll.by, poll.time, poll.pros, poll.cons, poll.completed, poll.endTime);
    // }

    // // 내가 투표한 투표의 진행 상태 반환
    // function getVotedPollStatus(string memory _title) public view returns (bool) {
    //     require(bytes(_title).length > 0, "Title should not be empty");
    //     require(polls[_title].number > 0, "Poll does not exist");
        
    //     return polls[_title].completed;
    // }

    // // 내가 만든 투표의 진행 상태 반환
    // function getCreatedPollStatus(string memory _title) public view returns (bool) {
    //     require(bytes(_title).length > 0, "Title should not be empty");
    //     require(polls[_title].number > 0, "Poll does not exist");
    //     require(polls[_title].by == msg.sender, "Only the creator can access the poll status");
        
    //     return polls[_title].completed;
    // }

    // // 내가 만든 투표의 참여자 수 반환
    // function getCreatedPollParticipants(string memory _title) public view returns (uint) {
    //     require(bytes(_title).length > 0, "Title should not be empty");
    //     require(polls[_title].number > 0, "Poll does not exist");
    //     require(polls[_title].by == msg.sender, "Only the creator can access the poll participants");
        
    //     uint participants = 0;
    //     address[] storage addresses = getParticipantAddresses(_title);
        
    //     for (uint i = 0; i < addresses.length; i++) {
    //         if (voted[addresses[i]][_title]) {
    //             participants += 1;
    //         }
    //     }
        
    //     return participants;
    // }

    // // 투표 개수 반환
    // function getPollCount() public view returns (uint) {
    //     return userPolls[msg.sender].length;
    // }

  

    // // 투표 참여자 주소 목록 반환
    // function getParticipantAddresses(string memory _title) private view returns (address[] storage) {
    //     Poll storage poll = polls[_title];
    //     require(poll.number > 0, "Poll does not exist");
        
    //     address[] storage addresses;
        
    //     // addresses에 투표 참여자 주소들을 추가하는 로직 작성
        
    //     return addresses;
    // }
}