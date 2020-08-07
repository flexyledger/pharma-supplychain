pragma solidity ^0.4.24;
contract Logistics{
    
    /////////////// DECALARATION ////////////////////
    
    struct package{
        bool isuidgenerated;
        uint itemid;
        string itemname;
        string transistatus;
        uint orderstatus; // 1 = ordered; 2 = in-transit; 3 = delivered; 4 = canceled
        
        address customer;
        uint ordertime;
        
        address carrier1;
        uint carrier1_time;
        
        address carrier2;
        uint carrier2_time;
        
        address carrier3;
        uint carrier3_time;
    }

    mapping (address => package) public packagemapping;
    mapping (address => bool) public carriers;

    ////////////// DECALARATION END ///////////////

    ////////////// MODIFIERS ////////////////

    constructor(){
        Owner = msg.sendr;
    }
    
    modifier onlyOwner(){
        require(Owner ==msg.sender);
        _;
    }    
    
    ///////////// MODIFIERS END  //////////////////
    
    ////////////////MANAGE CARRIERS /////////////
    
    function ManageCarriers(address _carrierAddress) public returns (string) {
    
        if(!carriers[_carrierAddress]){
            carriers[_carrierAddress] = true;
        } else {
            carriers[_carrier] = false;
        }
        
        return "Carriers is updated";
        
    }


    //////////////////////ORDERITEM FUNCTION//////////////

    function OrderItem(uint_itemid, string_itemname) public returns (address){
        address uniqueID = address(sha256(msg.sender, now));
        
        packagemapping[uniqueID].isuidgenerated = true;
        packagemapping[uniqueID].itemid = _itemid;
        packagemapping[uniqueID].itemname = _itemid;
        packagemapping[uniqueID].transistatus = "Your package is ordered and is under processing";
        packagemapping[uniqueID].orderstatus = 1;
        
        packagemapping[uniqueID].customer = msg.sender;
        packagemapping[uniqueID].ordertime = now;
        
        return uniqueID;
    }
    
    ////////////////ORDERITEM  FUNCTION END ///////////////
    
    ////////////// CANCEL ORDER //////////////////////////
    
    function CancelOrder(address _uniqueID) public returns (string){
        require(packagemapping[_uniqueID].isuidgenerated);
        require(packagemapping[_uniqueID].customer == msg.sender);
        
        packagemapping[_uniqueID].orderstatus = 4;
        packagemapping[_uniqueID].transistatus = "Your order has been canceled";
        
        return "Your order has been canceled successfully!";
        
    }
    
    ///////////// CANCEL ORDER END ///////////////////////////
    
    
    /////////////////// CARRIERS ///////////////////////
    
    function Carrier1Report(address _uniqueID, string _transitStatus){
        require(packagemapping[_uniqueID].isuidgenerated);
        require(carriers[msg.sender]);
        require(packagemapping[_uniqueID].orderstatus == 1);
        
        packagemapping[_uniqueID].transistatus = _transitStatus;
        packagemapping[_uniqueID].carrier1 = msg.sender;
        packagemapping[_uniqueID].carrier1_time = now;
        packagemapping[_uniqueID].orderstatus = 1;
    }
    
    /////////////// CARRIERS END ///////////////////
