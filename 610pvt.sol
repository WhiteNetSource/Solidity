// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;
contract VC {

    struct Poll {
        uint number;
        string title;
        string context;
        address by;
        uint time;
        uint pros;
        uint cons;
        bool completed;
        voteType votetype;
        string[] elective;
        uint[] electiveCount;
        uint endTime;
        string[] regardingUsers;
    }

    enum voteType {
        prosAndCons,
        election
    }


    
    
    //3.   투표 결과 보기
    //3.1  내가 만든 투표 리스트 (결과 또는 상태) => getMadeVote
    //3.2  내가 한 투표 보기 (결과 또는 상태)
    //4    투표 완료 하기 (시간이 지나면 자동 완료 //   bool completed; -> true)


    // 1. 맵핑을 최소화 하기 위해서 리스트로 바꿈 (가스비 감소를 위해)
    //   ㄴ사유: 맵핑은 키로만 불려 올수 있어 다른 방식으로 넣어주고 싶으면 다른 맵핑이 필요
    //  => 리스트로 대처 (원하는 조건을 if문으로 대조 하고 새 리스트에 담아 출력하는 형식)

    // 2. 투표는 맵핑으로 구현 생각 중 
    //   mapping(uint => (address => uint)) 
    //           number=> (msg.sender =>  string["황재윤", "김영도"]  elective의 인덱스 => ( 황재윤 0  ||  김영도 1 ) || 0 찬성 or 1 반대 )
    //           0x1123 => 0x253671() => 찬반 1 || 선춣형 1
    //   문자로 넣을까??? 고민중 / 문자 대조가 어려움 


    // mapping(uint => mapping (address => uint)) voted; //투표하는 것 
    //         // 투표 number   // 누른 사람   // 찬반  : 찬성 0 , 반대 , 1
    //         //generatePollNumber         // 선출  : 인덱스 값 재윤 선택시 0 / ["황재윤", "김영도" , "안재우" ]  => 0,1,2


  

    struct User {
        string email ;
        address addr ;
        
    }

    //3중 맵핑쓰고 싶지만 뽑아 올 수 있는 데이터 선택을 위해 이렇게 작성 함
    mapping( address => User) users ;
    mapping( string => address) emailToUserBytes ;

    mapping( address => Poll ) UserHasPoll ;

    modifier setVoting( address _addr, string memory _email, string memory _title, string memory _context, uint _endTime) {
        require(keccak256(bytes(users[_addr].email)) == keccak256(bytes(_email)), "Permission denied"); // <-이메일이 있는지 체크 후 존재하는 이메일로 투표를 생성했는지 여부
        require(bytes(_title).length > 0, "Title is empty.");
        require(bytes(_context).length > 0, "Context is empty.");
        require(_endTime > 0, "Time is empty.");
        _;
    }
     

    //1.   투표만들기 
    function createPoll(  voteType _type ) public setVoting( msg.sender ,  users[ msg.sender ].email , UserHasPoll[ msg.sender ].title , UserHasPoll[ msg.sender ].context, block.timestamp) {

        uint[] electiveCount;

        if ( _type == voteType.prosAndCons ) {
            get_electionVoting() ;
        } 

        else ( _type == voteType.election ) {
            get_AgendaVoting() ;
            electiveCount++ ;
        }
        
    }


    function set_electionVoting( string memory _title, string memory _context, uint _endTime, address _by, address _addr , uint _number , string memory _email ) public {

    }


    function set_AgendaVoting( string memory _title, string memory _context, uint _endTime, address _by, address _addr , uint _number , string memory _email )public {

    }

    //2.   투표하기
    //2.1  투표 출력 (내가 권한 가진 것만 나오기 email) => getRegardingUserPolls
    //2.2  권한이 없으면 리젝트 


















































}
