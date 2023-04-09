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
       uint[] donations;
    uint deadline;
    address[] donators;
  }

  mapping(uint256=>Campaign) public campaigns;
  uint public noOfCampaigns = 0;
// 1. Function for creating campaigns
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

// 2. Donate to particular campaigns
function donateToCampaign(uint256 id) public payable {
uint256 amount = msg.value;
Campaign storage campaign = campaigns[id];
campaign.donators.push(msg.sender);
campaign.donations.push(amount);
campaign.amountCollected+= amount;

}

// 3. Get all donators and donations
function getDonators(uint256 id) public view returns (address[] memory,uint256[] memory){
return (campaigns[id].donators,campaigns[id].donations);
}

// 4. Get all campaigns by making array since memory are not directly accessible
function getCampaign() public view returns(Campaign[] memory){
    Campaign[] memory allCampaigns = new Campaign[](noOfCampaigns);
    for (uint i =0; i<noOfCampaigns;i++){
        Campaign storage item = campaigns[i];
        allCampaigns[i] = item;
    }
    return allCampaigns;
}
}
