pragma solidity ^0.4.11;

contract Collective {

	struct Milestone {
		bytes32 name;
		uint start;
		uint daysToPayout;
		uint percentPayout;
		uint steps;
		bool paidOut;
	}

	address[] public sponsors;
	address[] public individuals;
	address public initializer;
	Milestone[] public milestones;
	uint public numMilestones;
	uint public startDate;
	uint public endDate;

	function Collective(bool _isSponsor, address[] _sponsors, address[] _individuals, bytes32[] _milestoneNames, uint[] _milestonePayoutDays, uint[] _milestonePayoutPercentages, uint[] _milestoneSteps) {
		
		startDate = now;

		if (_isSponsor) {
			sponsors.push(msg.sender);
		}
		else {
			individuals.push(msg.sender);
		}

		for (uint i = 0; i < _sponsors.length; ++i) {
			sponsors.push(_sponsors[i]);
		}

		for (uint j = 0; j < _individuals.length; ++j) {
			individuals.push(_individuals[j]);
		}

		for (uint k = 0; k < _milestoneNames.length; ++k) {
			createMilestone(_milestoneNames[k], _milestonePayoutDays[k], _milestonePayoutPercentages[k], _milestoneSteps[k]);
		}

		initializer = msg.sender;
	}

	function daysSinceInception() constant returns (uint) {
		uint numDays = (now - startDate)/60/60/24;
		return numDays;
	}

	function createMilestone(bytes32 _name, uint _daysToPayout, uint _percentPayout, uint _steps) {
		milestones.push(Milestone(_name, startDate, _daysToPayout, _percentPayout, _steps, false));
	}

	function payoutMilestone(uint _steps) {
		uint numDays = daysSinceInception();
		uint milestoneNum = getNextMilestoneNum();

		if (_steps >= milestones[milestoneNum].steps && (milestones[milestoneNum].daysToPayout - numDays) > 0) {
			for (uint i = 0; i < individuals.length; ++i) {
				individuals[i].transfer(((milestones[i].percentPayout / 100) * this.balance) / individuals.length);
			}
		}
	}

	function getNextMilestoneNum() constant returns (uint) {
		uint numDays = daysSinceInception();

		for (uint i = 0; i < milestones.length; ++i) {
			if (milestones[i].daysToPayout < numDays && milestones[i].paidOut == false) {
				return i;
			}
			else if (i == milestones.length - 1) {
				return i;
			}
		}
	}

	function fund() payable returns (bool) {
		return true;
	}

}