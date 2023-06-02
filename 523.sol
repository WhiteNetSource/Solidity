// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/*
안건을 올리고 이에 대한 찬성과 반대를 할 수 있는 기능을 구현하세요.
안건은 번호, 제목, 내용,// 제안자(address) 그리고 찬성자 수와 반대자 수로 이루어져 있습니다.(구조체)
안건들을 모아놓은 자료구조도 구현하세요.

사용자는 자신의 이름과 주소, 자신이 만든 안건 그리고 자신이 투표한 안건과 어떻게 투표했는지(찬/반)에 대한 정보[string => bool]로 이루어져 있습니다.(구조체)

- 사용자 등록 기능 - 사용자를 등록하는 기능
- 투표하는 기능 - 특정 안건에 대하여 투표하는 기능, 안건은 제목으로 검색, 이미 투표한 건에 대해서는 재투표 불가능
- 안건 제안 기능 - 자신이 원하는 안건을 제안하는 기능
- 제안한 안건 확인 기능 - 자신이 제안한 안건에 대한 현재 진행 상황 확인기능 - (번호, 제목, 내용, 찬반 반환 // 밑의 심화 문제 풀었다면 상태도 반환)
- 전체 안건 확인 기능 - 제목으로 안건을 검색하면 번호, 제목, 내용, 제안자, 찬반 수 모두를 반환하는 기능

---

- 안건 진행 과정 - 투표 진행중, 통과, 기각 상태를 구별하여 알려주고 전체의 70% 그리고 투표자의 66% 이상이 찬성해야 통과로 변경, 둘 중 하나라도 만족못하면 기각
*/

contract Q6 {
    struct poll {
        uint number;
        string title;
        string context;
        address by;
        uint time;
        uint pros;
        uint cons;
        pollStatus status;
    }

    // poll을 관리할 자료구조 , array or mapping
    mapping(string => poll) public polls;     // * 전체 안건 확인 기능 - 제목으로 안건을 검색하면 번호, 제목, 내용, 제안자, 찬반 수 모두를 반환하는 기능
    uint public count; // 안건 수            1
    uint public userCount; // user 수        1

    enum votingStatus {         //   1
        notVoted,
        pro,
        con
    }

    enum pollStatus {            // 1
        ongoing,
        passed,
        rejected
    }

    struct user {
        string name;
        address addr;
        string[] suggested;
        mapping(string=>votingStatus) voted;
    }

    // user를 관리할 자료구조 mapping
    mapping(address=>user) users;

    modifier isItUser() {
        require(users[msg.sender].addr == msg.sender);
        _;
    }

    // * 사용자 등록 기능 - 사용자를 등록하는 기능
    function pushUser(string calldata _name) public {
        (users[msg.sender].name, users[msg.sender].addr) = (_name, msg.sender);
        userCount++;
    }

    // * 투표하는 기능 - 특정 안건에 대하여 투표하는 기능, 안건은 제목으로 검색, 이미 투표한 건에 대해서는 재투표 불가능
    function vote(string calldata _title, bool _vote) external/*상속받은 애도 못하게*/ isItUser {
        require(users[msg.sender].voted[_title]==votingStatus.notVoted && polls[_title].status == pollStatus.ongoing); //투표자가 해당 안건에 대해서 투표를 안했어야 함
        // 찬성이냐, 반대이냐
        if(_vote==true) {
            polls[_title].pros++;
            users[msg.sender].voted[_title] = votingStatus.pro;
        } else {
            polls[_title].cons++;
            users[msg.sender].voted[_title] = votingStatus.con;
        }
    }

    // * 제안한 안건 확인 기능 - 자신이 제안한 안건에 대한 현재 진행 상황 확인기능 - (번호, 제목, 내용, 찬반 반환 // 밑의 심화 문제 풀었다면 상태도 반환)
    function searchSuggested(string calldata _title) public view returns(poll memory) {
        require(msg.sender==polls[_title].by, "You did not suggested it.");
        return polls[_title];
    }

    // * 안건 제안 기능 - 자신이 원하는 안건을 제안하는 기능
    function suggest(string calldata _title, string calldata _context) public isItUser {
        polls[_title] = poll(++count, _title, _context, msg.sender, block.timestamp, 0,0, pollStatus.ongoing);
    }

    // * 전체 안건 확인 기능 - 제목으로 안건을 검색하면 번호, 제목, 내용, 제안자, 찬반 수 모두를 반환하는 기능
    function getPoll(string memory _title) public view returns(poll memory) {
        return polls[_title];
    }

    // * 안건 진행 과정 - 투표 진행중, 통과, 기각 상태를 구별하여 알려주고 전체의 70% 그리고 투표자의 66% 이상이 찬성해야 통과로 변경, 둘 중 하나라도 만족못하면 기각
    function finishPoll(string memory _title) external isItUser {
        require(block.timestamp > polls[_title].time+100);
        if((polls[_title].pros + polls[_title].cons) > userCount*7/10 && (polls[_title].pros) / (polls[_title].pros + polls[_title].cons) *100 > 66 ) {
            polls[_title].status = pollStatus.passed;
        } else {
            polls[_title].status = pollStatus.rejected;
        }
    }
}*/



// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/*
안건을 올리고 이에 대한 찬성과 반대를 할 수 있는 기능을 구현하세요.
안건은 번호, 제목, 내용,// 제안자(address) 그리고 찬성자 수와 반대자 수로 이루어져 있습니다.(구조체)
안건들을 모아놓은 자료구조도 구현하세요.

사용자는 자신의 이름과 주소, 자신이 만든 안건 그리고 자신이 투표한 안건과 어떻게 투표했는지(찬/반)에 대한 정보[string => bool]로 이루어져 있습니다.(구조체)

- 사용자 등록 기능 - 사용자를 등록하는 기능
- 투표하는 기능 - 특정 안건에 대하여 투표하는 기능, 안건은 제목으로 검색, 이미 투표한 건에 대해서는 재투표 불가능
- 안건 제안 기능 - 자신이 원하는 안건을 제안하는 기능
- 제안한 안건 확인 기능 - 자신이 제안한 안건에 대한 현재 진행 상황 확인기능 - (번호, 제목, 내용, 찬반 반환 // 밑의 심화 문제 풀었다면 상태도 반환)
- 전체 안건 확인 기능 - 제목으로 안건을 검색하면 번호, 제목, 내용, 제안자, 찬반 수 모두를 반환하는 기능

---

- 안건 진행 과정 - 투표 진행중, 통과, 기각 상태를 구별하여 알려주고 전체의 70% 그리고 투표자의 66% 이상이 찬성해야 통과로 변경, 둘 중 하나라도 만족못하면 기각
*/

contract Q6 {
    

    

    
    struct User {
        string name;                              // 사용자 이름
        address addr;                             // 사용자 주소
        string[] suggested;                       // 사용자가 제안한 안건들의 제목 배열
        mapping(string => VotingStatus) voted;     // 사용자가 투표한 안건에 대한 투표 상태 (찬성/반대)
    }

    // 사용자를 관리할 자료구조 (mapping)
    mapping(address => User) users;

    modifier isItUser() {
        require(users[msg.sender].addr == msg.sender, "You are not a registered user.");
        _;
    }

    // 사용자 등록 기능 - 사용자를 등록하는 기능
    function pushUser(string calldata _name) public {
        (users[msg.sender].name, users[msg.sender].addr) = (_name, msg.sender);
        userCount++;
    }

    // 투표하는 기능 - 특정 안건에 대하여 투표하는 기능, 안건은 제목으로 검색, 이미 투표한 건에 대해서는 재투표 불가능
    function vote(string calldata _title, bool _vote) external isItUser {
        require(users[msg.sender].voted[_title] == VotingStatus.NotVoted, "You have already voted for this poll.");
        require(polls[_title].status == PollStatus.Ongoing, "This poll is not ongoing.");

        // 찬성인 경우
        if (_vote) {
            polls[_title].pros++;
            users[msg.sender].voted[_title] = VotingStatus.Pro;
        }
        // 반대인 경우
        else {
            polls[_title].cons++;
            users[msg.sender].voted[_title] = VotingStatus.Con;
        }
    }

    // 제안한 안건 확인 기능 - 자신이 제안한 안건에 대한 현재 진행 상황 확인 기능 - (번호, 제목, 내용, 찬반 반환 // 밑의 심화 문제 풀었다면 상태도 반환)
    function searchSuggested(string calldata _title) public view returns (Poll memory) {
        require(msg.sender == polls[_title].by, "You did not suggest this poll.");
        return polls[_title];
    }

    // 안건 제안 기능 - 자신이 원하는 안건을 제안하는 기능
    function suggest(string calldata _title, string calldata _context) public isItUser {
        polls[_title] = Poll(++count, _title, _context, msg.sender, block.timestamp, 0, 0, PollStatus.Ongoing);
    }

    // 전체 안건 확인 기능 - 제목으로 안건을 검색하면 번호, 제목, 내용, 제안자, 찬반 수 모두를 반환하는 기능
    function getPoll(string memory _title) public view returns (Poll memory) {
        return polls[_title];
    }

    // 안건 진행 과정 - 투표 진행중, 통과, 기각 상태를 구별하여 알려주고 전체의 70% 그리고 투표자의 66% 이상이 찬성해야 통과로 변경, 둘 중 하나라도 만족못하면 기각
    function updateStatus(string calldata _title) public {
        Poll storage poll = polls[_title];
        require(poll.status == PollStatus.Ongoing, "This poll is not ongoing.");

        uint totalVotes = poll.pros + poll.cons;
        uint passPercentage = (totalVotes * 70) / 100;
        uint proPercentage = (poll.pros * 66) / 100;

        // 투표자 수가 0명인 경우
        if (totalVotes == 0) {
            poll.status = PollStatus.Ongoing;
        }
        // 찬성 표가 70% 이상이고 찬성자의 비율이 66% 이상인 경우
        else if (poll.pros >= passPercentage && proPercentage >= poll.pros) {
            poll.status = PollStatus.Passed;
        }
        // 투표자 수가 0이 아니면서 찬성 표가 70% 미만이거나 찬성자의 비율이 66% 미만인 경우
        else {
            poll.status = PollStatus.Rejected ;
        }
    }
}
