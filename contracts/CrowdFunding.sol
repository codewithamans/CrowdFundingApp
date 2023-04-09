// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract CrowdFunding {
  struct Campaign{
    string name;
    string description;
    uint256 target;
    address Owner;
    uint256 amountCollected;
    uint deadline;
    address[] donators;
  }

  mapping(uint256=>Campaign) public campaigns;
  uint public noOfCampaigns = 0;

 function createCampaign(address owner, string memory _title, string memory _desc,uint256 _target,uint _deadline) public returns(uint256){
Campaign storage campaign = campaigns[noOfCampaigns];
require(_deadline>block.timestamp,"Deadline time should be of future");
campaign.Owner  = owner;
campaign.name = _title;
campaign.description= _desc;
campaign.target= _target;
campaign.deadline= _deadline;
noOfCampaigns+=1;
return noOfCampaigns -1;
 }

function donateToCampaign(uint256 id) public payable {
uint256 amount = msg.value;
Campaign storage campaign = campaigns[id];
campaign.donators.push(msg.sender);
campaign.amountCollected+= amount;

}
}
