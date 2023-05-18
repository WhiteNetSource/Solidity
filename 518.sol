




* 사용자 등록 기능 - 사용자를 등록하는 기능 ->set 함수
* 투표하는 기능 - 특정 안건에 대하여 투표하는 기능, 안건은 제목으로 검색, 이미 투표한 건에 대해서는 재투표 불가능->투표안에 넣은 배열
* 안건 제안 기능 - 자신이 원하는 안건을 제안하는 기능 -> 새로운 배열에 제안
* 제안한 안건 확인 기능 - 자신이 제안한 안건에 대한 현재 진행 상황 확인기능 -> 배열에 대한 진행상황 불의 형태 배열(보류중 채열에서 논의중배열로 옮기기)
* 전체 안건 확인 기능 - 제목으로 안건을 검색하면 번호, 제목, 내용, 제안자, 찬반 수 모두를 반환하는 기능
-------------------------------------------------------------------------------------------------
* 안건 진행 과정 - 투표 진행중, 통과, 기각 상태를 구별하여 알려주고
 전체의 70% 그리고 투표자의 66% 이상이 찬성해야 통과로 변경, 
둘 중 하나라도 만족못하면 기각


contract Quiz{
    //안건은 번호, 제목, 내용, 제안자(address) 그리고 찬성자 수와 반대자 수로 이루어져 있습니다.
    struct agenda{
        uint number;
        string title;
        address proposer;
        bool vote;
    }
    //안건들을 모아놓은 자료구조도 구현하세요. ->스트럭트 구조체 만들고
    agenda[] data;

    //안건을 올리고 이에 대한 찬성과 반대를 할 수 있는 기능을 구현하세요. -> 안건은 스트링 -> 찬반 bool형태로
    function pushDate() public {
        data.push(agenda(number,title,proposer));
    }

    function setAgenda(uint _number,bool _ox) public view returns(bool) {
        if(data[_number-1].vote == 0) {
            return false;
        }
        
        data[_number-1].vote.push(_ox)
        return true;

    }
}

 //사용자는 자신의 이름과 주소, 자신이 만든 안건 그리고 자신이 투표한 안건과 -> 사용자의 구조체의 상태만들기
    //어떻게 투표했는지(찬/반)에 대한 정보로 이루어져 있습니다.(구조체)
contract VotingStatus {
    struct User {
        string name;
        string addressInfo;
        string agenda;
        bool vote;  // 찬성(true) 또는 반대(false)로 투표한 정보
    }

    mapping(address => User) public users;

    function addUser(string memory _name, string memory _addressInfo, string memory _agenda, bool _vote) public {
        User memory newUser = User(_name, _addressInfo, _agenda, _vote);
        users[msg.sender] = newUser;
    }
}