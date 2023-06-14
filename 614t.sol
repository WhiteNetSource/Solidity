// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.18;

contract Ballot {
    struct Voter {
        uint weight; // 투표권 개수      
        bool voted; // 투표했는지 여부             
        uint vote; // 투표한 Proposal의 인덱스 (몇 번에 투표했는지)     
    }

    struct Proposal {
        string name;            
        uint voteCount;      
    }

    // 관리자
    address public chairperson;

    // 투표자 관리
    mapping(address => Voter) public voters;

    // Proposal 관리
    Proposal[] public proposals;  

    // 초기 설정
    constructor(string[] memory proposalNames) {
        // 배포한 사람이 관리자
        chairperson = msg.sender;

        // proposals 0번은 무효표
        proposals.push(Proposal({
                name: "abstention",
                voteCount: 0
            }));

        // proposals 초기화, 설정 -> 1번 부터
        for (uint i=0; i<proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    // 사람에게 투표 권한 부여하는 함수
    function giveRightToVote(address voter) public {
        // 함수 호출하는 사람이 관리자인지 그리고 투표자가 투표를 안 했는지
        require((msg.sender == chairperson) && !voters[voter].voted);

        // 투표 권한 부여
        voters[voter].weight = 1;
    }

    // 투표하는 함수
    function vote(uint proposal) public {
        require(voters[msg.sender].weight > 0 && !voters[msg.sender].voted);

        // 투표 했음을 표시하기
        voters[msg.sender].voted = true;

        // 몇번을 투표했는지 표시
        voters[msg.sender].vote = proposal;

        // 해당 Proposal 카운트 증가 (투표권 수 만큼)
        proposals[proposal].voteCount += voters[msg.sender].weight;

        // 투표권 사용했음을 표시
        voters[msg.sender].weight = 0;
    }

    // 최다 득표 확인하는 함수
    function winningProposal() public view returns (string memory, uint) {
        // 최다 득표 인덱스
        uint winningP;
        // 최다 득표 수
        uint winningVoteCount = 0;

        // 배열 전체 돌면서 최다 득표 찾기
        for(uint p=0; p<proposals.length; p++) {
            if(proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningP = p;
            }
        }

        return (proposals[winningP].name, winningVoteCount);
    }
}