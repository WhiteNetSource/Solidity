// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
안건을 올리고 이에 대한 찬성과 반대를 할 수 있는 기능을 구현하세요. 안건은 번호, 제목, 내용, 제안자(address) 그리고 찬성자 수와 반대자 수로 이루어져 있습니다.(구조체)
안건들을 모아놓은 자료구조도 구현하세요. 

사용자는 자신의 이름과 주소, 자신이 만든 안건 그리고 자신이 투표한 안건과 어떻게 투표했는지(찬/반)에 대한 정보[string => bool]로 이루어져 있습니다.(구조체)
-------------------------------------------------------------------------------------------------
* 안건 진행 과정 - 투표 진행중, 통과, 기각 상태를 구별하여 알려주고 전체의 70% 그리고 투표자의 66% 이상이 찬성해야 통과로 변경, 둘 중 하나라도 만족못하면 기각
*/

contract Voting {

    // 투표상태
    enum P_Status { Voting , Approved , Rejected }
    
    struct Proposal {

        uint id ;
        string title ;
        string description ;
        address proposer ; // 제안자
        uint agree ; // 찬성 수
        uint opp ; // 반대 수
        P_Status status ; // 투표 상태

    }
    //
    struct Voter {

        string name ;
        address add ;
        //mapping( uint => uint ) voted_P ; // n 번 안건에 투표했는지 안했는지 ( 0 : 투표 안함 , 1 : 찬성 , 2 : 반대 ) 
        mapping( uint => bool ) voted_P ; // n 번안건에 찬성했는지 안했는지 ( 문제의 조건에 맞게 str > bool )
        mapping( uint => bool ) vote_P ; // n 번 안건에 이미 투표했는가?
        uint[] proposed_P ; // 제안한 안건 번호

    }
    
    mapping( string => Proposal ) public proposals ; // 제목으로 검색 , 번호로 검색할꺼면 uint > 
    mapping( uint => string ) public p_idx ; // 번호로 안건 검색용
    mapping( address => Voter ) public voters ;
    mapping( uint => address ) public v_idx ; // 번호로 투표자 검색용

    // 안건과 사용자는 1번부터 등록
    uint public p_Count = 0 ; // 안건 수
    uint public v_Count = 0 ; // 사용자 수

    // * 사용자 등록 기능 - 사용자를 등록하는 기능
    function register_V( string memory name ) public {

        Voter storage voter = voters[ msg.sender ] ;
        require( bytes( voter.name ).length == 0 , "Already registered" ) ;
        
        voter.name = name ;
        voter.add = msg.sender ;
        v_idx[ ++ v_Count ] = msg.sender ;
        // 1번 사용자 > voters[ v_idx[ 1 ] ]

    }
    
    // * 안건 제안 기능 - 자신이 원하는 안건을 제안하는 기능
    function propose( string memory title , string memory description ) public {

        Proposal storage proposal = proposals[ title ] ;
        require( bytes( proposal.title ).length == 0, "Title already exists" ) ;
        
        proposal.id = ++ p_Count ;
        p_idx[ p_Count ] = title ;
        // 1번 안건 > 

        proposal.title = title ;
        proposal.description = description ;
        proposal.proposer = msg.sender ;
        proposal.status = P_Status.Voting ;
        
        voters[ msg.sender ].proposed_P.push( proposal.id ) ;
        // 제안자의 제안 안건에 추가

    }
    
    // * 투표하는 기능 - 특정 안건에 대하여 투표하는 기능, 안건은 제목으로 검색, 이미 투표한 건에 대해서는 재투표 불가능
    // true = 찬성 , false = 반대
    function vote( string memory title , bool voteFor ) public {

        Proposal storage proposal = proposals[ title ] ;
        Voter storage voter = voters[ msg.sender ] ;
        
        require( bytes( proposal.title ).length > 0, "Not exist" ) ;
        require( !voter.vote_P[ proposal.id ] , "Already voted" ) ;
        
        if( voteFor ) proposal.agree ++ ;
        else proposal.opp ++ ;
        voter.voted_P[ proposal.id ] = voteFor ;

        // updateStatus( proposal ) ;
        // 갱신을 어디서 할지는 생각좀 해보자.

    }
    
    // 안건 상태 갱신
    function update_Status( Proposal storage proposal ) internal {

        uint totalVotes = proposal.agree + proposal.opp;

        if( totalVotes > ( v_Count * 7 / 10 ) ) {
        if ( proposal.agree > totalVotes * 2 / 3 ) proposal.status = P_Status.Approved ;
        else if ( proposal.opp > totalVotes / 3 ) proposal.status = P_Status.Rejected ;
        }

    }
    
    // * 제안한 안건 확인 기능 - 자신이 제안한 안건에 대한 현재 진행 상황 확인기능 - (번호, 제목, 내용, 찬반 반환 // 밑의 심화 문제 풀었다면 상태도 반환)
    // 자신이 제안한 n 번째 안건에 대해서
    // 막상 구현하고 보니 제목이 더 나은거같은데

    function get_My_P_N( uint _idx ) public returns ( Proposal memory ) {

        require( voters[ msg.sender ].proposed_P.length >= _idx , "Not exist" ) ;

        // 5번째 안건 내놓으라했는데 4번까지만 등록했을때 처리

        update_Status( proposals[ p_idx[ voters[ msg.sender ].proposed_P[ _idx ] ] ] ) ;
        return proposals[ p_idx[ voters[ msg.sender ].proposed_P[ _idx ] ] ] ;

        // voters[ msg.sender ].proposed_P[ _idx ] : 현재 센더가 제안한 _idx 번째 제안의 번호
        // p_idx[ voters[ msg.sender ].proposed_P[ _idx ] ] : 그 번호에 매칭된 안건의 제목

    }

    // * 전체 안건 확인 기능 - 제목으로 안건을 검색하면 번호, 제목, 내용, 제안자, 찬반 수 모두를 반환하는 기능
    function get_P_Name( string memory _title ) public  returns ( Proposal memory ) {

        Proposal memory proposal = proposals[ _title ] ;
        
        require( bytes( proposal.title ).length != 0, "Non proposal" ) ;

        update_Status( proposals[ _title ] ) ;
        
        return proposal ;

    }
    
}