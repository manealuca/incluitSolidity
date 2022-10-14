pragma solidity >=0.7.0 <0.9.0;
pragma experimental ABIEncoderV2; 

contract Gym{
    event ShowAccount(Account ac,address ad);
    constructor(){
        ADMIN = msg.sender;
    }

    struct Class{
        string name;
        uint credit;
    }

   struct Account {
        uint credits;
        bool validate;
    }

    mapping(address=>Account)accounts;

    Class[] public GymClases;

    address immutable public ADMIN;
    
    function takeClass(uint classId)public {        
        require(accounts[msg.sender].credits >GymClases[classId].credit,"You dont have enought credits");
        accounts[msg.sender].credits -= GymClases[classId].credit;    
    } 

    //Add class to GymClass list
    function addClass(Class memory newClass) public{
        require(msg.sender == ADMIN,"Only Admin account can add a class");
        GymClases.push(newClass);
    }

    //Add an Account to mapping
    function addAccount(uint credit)public{
        require(accounts[msg.sender].validate==false,"Already axist an account to this wallet");
        accounts[msg.sender].validate=true;
        accounts[msg.sender].credits=credit;
    }

    //Return Balance
    function GetCredits()public view returns(uint){
        return accounts[msg.sender].credits;
    }
    //Emit Account, balance and retur Account
    function GetAccount()public returns(Account memory){
        emit ShowAccount(accounts[msg.sender],msg.sender);
        return accounts[msg.sender];
    }

    //DummyParametters
    function addDummyParams()public {
            GymClases.push(Class("Standard Gym",5));
            GymClases.push(Class("Pilates",8));
            GymClases.push(Class("Calisthenics",7));
            GymClases.push(Class("CrossFit",1));
    }

    function getGymClasesById(uint id)public view returns(Class memory){
        return GymClases[id];
    }
}