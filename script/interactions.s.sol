// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script,console} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant Send_value = 0.01 ether;
    function fundFundMe(address get_most_recent_deployment) public {
        vm.startBroadcast();
        FundMe(payable(get_most_recent_deployment)).fund{value:Send_value}();
        vm.stopBroadcast();
        console.log("Fundme Contract Funded with %s",Send_value);
    }
    
    function run() external{
        address mostReceentlDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        fundFundMe(mostReceentlDeployed);
        vm.stopBroadcast();
    }
}


contract WithdrawFundme is Script {
    uint256 constant Send_value = 0.1 ether;
    function withdrawFundMe(address get_most_recent_deployment) public {
        vm.startBroadcast();
        FundMe(payable(get_most_recent_deployment)).withdraw();
        vm.stopBroadcast();
        console.log("Fundme Contract Funded with %s",Send_value);
    }
    
    function run() external{
        address mostReceentlDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid
        );

         vm.startBroadcast();
        withdrawFundMe(mostReceentlDeployed);
        vm.stopBroadcast();
    }
}