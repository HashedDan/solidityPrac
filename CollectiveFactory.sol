pragma solidity ^0.4.11;

import "./Collective.sol";

contract  CollectiveFactory {

	address public lastDeployed;

	function createCollective(bool _isSponsor, address[] _sponsors, address[] _individuals, bytes32[] _milestoneNames, uint[] _milestonePayoutDays, uint[] _milestonePayoutPercentages, uint[] _milestoneSteps) returns (Collective) {

		Collective newContract = new Collective(_isSponsor,_sponsors,_individuals,_milestoneNames,_milestonePayoutDays,_milestonePayoutPercentages,_milestoneSteps);

		lastDeployed = newContract;

		return newContract;
	}

}