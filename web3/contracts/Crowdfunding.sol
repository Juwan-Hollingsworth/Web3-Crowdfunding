// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Crowdfunding {
    //solidity obj - campaign - structure
    struct Campaign{
        address owner; // campaign owner
        string title; // campaign title
        string description; // campaign descr
        uint256 target; // target amount to achieve
        uint256 deadline; // deadline
        uint256 amountCollected; //amount collected
        string image;
        address[] donators; // array of address for donators
        uint256[] donations; // amount of donations
    }


    //mapping for campaigns - mapping
    mapping (uint256 => Campaign) public campaigns;
    //create global var
    uint256 public numberOfCampaigns= 0; // keep track of # of campaigns created 

    //functionality of the program - functionality

    //return the id from this campaign
    function createCampaign(address _owner, string memory _title, string memory _description, uint256 _target, uint256 _deadline, string memory _image ) public returns (uint256) {
        Campaign storage campaign = campaigns[numberOfCampaigns];

        // check to see if everything is good - Our code will not proceed if this isn't satisfied
        require(campaign.deadline < block.timestamp, "The deadline should be a date in the future");

        campaign.owner = _owner;
        campaign.title = _title;
        campaign.description = _description;
        campaign.target = _target;
        campaign.deadline = _deadline;
        campaign.amountCollected = 0;
        campaign.image = _image;

        numberOfCampaigns++;


        //return the index for current campaign 
        return numberOfCampaigns -1;
        
    }
    //@params _id = id of campaign we are donating to 
    function donateToCampaign(uint256 _id) public payable {
        uint256 amount = msg.value; //get amount from frontend 
        Campaign storage campaign = campaigns[_id]; //find the campaign we want to donate to
        campaign.donators.push(msg.sender); //push the address of the donator
        campaign.donations.push(amount); //amount donated

        //make the transaction
        (bool sent) = payable(campaign.owner).call{value:amount}("");

        if(sent) {
            campaign.amountCollected = campaign.amountCollected + amount;
        }

        
    }
    //view function to return donators and donations of current campaign
    function getDonators(uint256 _id)  view public returns (address[] memory, uint256[] memory ){
      
        return(campaigns[_id].donators, campaigns[_id].donations);
        
    }
    //get list of all campaigns
    function getCampaigns() public view  returns (Campaign[] memory) {
        //create a new var called allcam of type array of all campaign structure
        //creating an empty array, w as many empty elements as there are campaigns (structs)

        Campaign[] memory allCampaigns = new Campaign[](numberOfCampaigns);

        //loop through all campaigns to populate the var
        for(uint i = 0; i< numberOfCampaigns; i++){
            Campaign storage item = campaigns[i];

            allCampaigns[i] = item;

        }
        return allCampaigns;
        
    }
}