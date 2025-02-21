// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe,WithdrawFundme} from "../../script/interactions.s.sol";




contract FundMeTestIntegration is Test {
    FundMe fundMe;

    address  USER = makeAddr("USER");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTing_BALANCE = 10 ether;


    function setUp() external {
        DeployFundMe deploy = new DeployFundMe();
        fundMe = deploy.run();
        vm.deal (USER,STARTing_BALANCE);
    }
    function testUserCanfundInteractions()public{
      FundFundMe fundFundMe = new FundFundMe();
      fundFundMe.fundFundMe(address(fundMe));
       vm.deal(USER,1e18);
       
       WithdrawFundme withdrawFundMe = new WithdrawFundme();
       withdrawFundMe.withdrawFundMe(address(fundMe));

       assert(address(fundMe).balance == 0);
    }
}