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

    mapping( address => User) users ;
    mapping( string => address) emailToUserBytes ;

     

    //1.   투표만들기 
    function createPoll(string memory _title, string memory _context, uint _endTime, address _by, address _addr , uint _number , string memory _email , voteType _type ) public  {
    require(keccak256(bytes(users[_addr].email)) == keccak256(bytes(_email)), "Permission denied"); // <- 주소와 이메일이 있는지 체크 후 존재하는 이메일로 투표를 생성했는지 여부
    require( bytes(_title ) > 0 , "Title is empty.") ;
    require( bytes( _context ) > 0 , "Context is empty.") ;
    require( _endTime > 0 , "Time is empty.") ;
        // 투표 생성 로직 추가
        //title
        //context
        //endtime
        //by 누구에게서 만들어졌는지

        //여기 if문 넣어서 0,1번으로 압축 시킬거임( 펑션 끌고 와서 코드 잘 보이게 할거)
        if ( _type == voteType.prosAndCons ) {

        } 

        else ( _type == voteType.election ) {

        }
        
    }

    function get_electionVoting( ) public {

    }

    function get_AgendaVoting()public {

    }

    //2.   투표하기
    //2.1  투표 출력 (내가 권한 가진 것만 나오기 email) => getRegardingUserPolls
    //2.2  권한이 없으면 리젝트 


















































}
