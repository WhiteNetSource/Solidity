
// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.18;

contract AuctionHouse {

		struct Auction {
		        uint auctionId;
		        address seller;
		        address highestBidder;
		        uint highestBid;
		        uint endTime;
		    }
		
		mapping(uint => Auction) auctions;
      constructor() {
        auctionIdCount = 0;
    }

    function createAuction(uint _endTime) public {
        auctionIdCount++;

        Auction memory newAuction;

        newAuction.auctionId = auctionIdCount;
        newAuction.seller = msg.sender;
        newAuction.endTime = _endTime;

        auctions[auctionIdCount] = newAuction;
    }

    function getNow() public view returns (uint) {
        return block.timestamp;
    }
    function getTime(uint _n) public view returns (uint) {
        return block.timestamp + (_n * 1 minutes);
    }
    function getAuction(uint _id) public view returns (Auction memory) {
        return auctions[_id];
    }
    uint auctionIdCount;

  
    function bidAuction(uint _id) public payable {
        Auction storage auction = auctions[_id];

        // 입찰 가능 시간인지 확인
        require(block.timestamp < auction.endTime, "Auction has ended.");
        // 경매 최고 입찰액보다 큰지
        require(msg.value > auction.highestBid, "Your bid must be greater than your highest bid.");

        if(auction.highestBid > 0) {
            // 이전 입찰자에게 반환
            payable(auction.highestBidder).transfer(auction.highestBid);
        }

        // 최고 입찰 업데이트
        auction.highestBid = msg.value;
        auction.highestBidder = msg.sender;

    }
    function closeAuction(uint _id) public {
        Auction storage auction = auctions[_id];

        // 종료 시간이 지났는지 확인
        require(block.timestamp >= auction.endTime, "It's not the end of the auction yet.");
        // 판매자만
        require(msg.sender == auction.seller, "Only the seller can close the auction.");

        payable(auction.seller).transfer(auction.highestBid);

        // 초기화
        auction.highestBid = 0;
        auction.highestBidder = address(0);
    }
}