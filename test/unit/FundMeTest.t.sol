// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    address  USER = makeAddr("USER");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTing_BALANCE = 10 ether;
   
    function setUp() external {
        //fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal (USER,STARTing_BALANCE);
        
    }
   
    
    function testPiceFeedVersionIsAccuratre() public view {
       uint256 version = fundMe.getVersion();
         assertEq(version, 4);
    }
    function testFundFailsWithoutEnoughEther() public {
        vm.expectRevert();
            fundMe.fund();
       
    }
    function testFundUpdatesContributorsBalance() public {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();


        uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
        assertEq(amountFunded, SEND_VALUE);
    }
    modifier funded () {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        _;
    }
    function testAddsFunderToArrayOfFunders() public{
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        address  funder = fundMe.getFunder(0);
        assertEq(funder, USER);
        
    }
    function testOnlyOwnerCanWithdraw() public funded {
       

       
        vm.prank(USER);
        vm.expectRevert();
        fundMe.withdraw();
    }
    function testwihdrawwithOwner() public funded{
    uint256 startingOwnerBalance = fundMe.getOwner().balance;
    uint256 startingFundMeBalance = address(fundMe).balance;
  
    vm.prank(fundMe.getOwner());
    fundMe.withdraw();

    uint256 endingOwnerBalance = fundMe.getOwner().balance;
    uint256 endingFundMeBalance = address(fundMe).balance;
    
    assertEq(endingFundMeBalance,0);
    assertEq(startingFundMeBalance + startingOwnerBalance, endingOwnerBalance);


    }

function testwWithdrawWithMultipleFunders() public funded {
    uint160 numberOfFunders = 10;
    uint160 startingfunderindex = 1;
    for (uint160 i=startingfunderindex; i<numberOfFunders; i++){
        hoax(address(i),SEND_VALUE);
        fundMe.fund{value: SEND_VALUE}();

    }
    uint256 startingOwnerBalance = fundMe.getOwner().balance;
    uint256 startingFundMeBalance = address(fundMe).balance;
    vm.startPrank(fundMe.getOwner());
    fundMe.withdraw();
    vm.stopPrank();
    assert(address(fundMe).balance == 0);
    assert(startingFundMeBalance+startingOwnerBalance == fundMe.getOwner().balance);
}

function testwWithdrawWithMultipleFundersCheaper() public funded {
    uint160 numberOfFunders = 10;
    uint160 startingfunderindex = 1;
    for (uint160 i=startingfunderindex; i<numberOfFunders; i++){
        hoax(address(i),SEND_VALUE);
        fundMe.fund{value: SEND_VALUE}();

    }
    uint256 startingOwnerBalance = fundMe.getOwner().balance;
    uint256 startingFundMeBalance = address(fundMe).balance;
    vm.startPrank(fundMe.getOwner());
    fundMe.cheaperWithdraw();
    vm.stopPrank();
    assert(address(fundMe).balance == 0);
    assert(startingFundMeBalance+startingOwnerBalance == fundMe.getOwner().balance);
}
}