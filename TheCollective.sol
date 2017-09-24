pragma solidity ^0.4.11;

contract TheCollective {

	struct Milestone {
		bytes32 name;
		uint start;
		uint daysToPayout;
		uint payoutVal;
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

	function TheCollective() {
		
		startDate = now;
		// endDate = now + (duration * 1 days);

		// if (_isSponsor) {
		// 	sponsors.push(msg.sender);
		// }
		// else {
		// 	individuals.push(msg.sender);
		// }

		// for (uint i = 0; i < _sponsors.length; ++i) {
		// 	sponsors.push(_sponsors[i]);
		// }

		// for (uint j = 0; j < _individuals.length; ++j) {
		// 	individuals.push(_individuals[j]);
		// }

		initializer = msg.sender;
	}

	function generate(bool _isSponsor, uint duration) {

		endDate = now + (duration * 1 days);

		if (_isSponsor) {
			sponsors.push(msg.sender);
		}
		else {
			individuals.push(msg.sender);
		}

		// for (uint i = 0; i < _sponsors.length; ++i) {
		// 	sponsors.push(_sponsors[i]);
		// }

		// for (uint j = 0; j < _individuals.length; ++j) {
		// 	individuals.push(_individuals[j]);
		// }
	}

	function getInitializer() constant returns (address) {
		return initializer;
	}

	function getSponsors() constant returns (address[]) {
		return sponsors;
	}

	function getIndividuals() constant returns (address[]) {
		return individuals;
	}

	function getTotalMilestoneNum() constant returns (uint) {
		return milestones.length;
	}

	function daysSinceInception() constant returns (uint) {
		uint numDays = (now - startDate)/60/60/24;
		return numDays;
	}

	function isComplete() constant returns (bool) {
		uint curDate = (daysSinceInception() * 1 days) + now;

		if (endDate < curDate) {
			return true;
		}
		else {
			return false;
		}
	}

	function joinCollective(bool _isSponsor) {
		if (_isSponsor) {
			sponsors.push(msg.sender);
		}
		else {
			individuals.push(msg.sender);
		}
	}

	function createMilestone(bytes32 _name, uint _daysToPayout, uint _payoutVal, uint _steps) {
		milestones.push(Milestone(_name, startDate, _daysToPayout, _payoutVal, _steps, false));
	}

	function payoutMilestone(uint _steps) {
		uint numDays = daysSinceInception();
		uint milestoneNum = getNextMilestoneNum();

		if (_steps >= milestones[milestoneNum].steps && (milestones[milestoneNum].daysToPayout - numDays) > 0 && milestones[milestoneNum].paidOut == false) {

			milestones[milestoneNum].paidOut = true;

			for (uint i = 0; i < individuals.length; ++i) {
				// individuals[i].transfer(((milestones[i].percentPayout / 100) * this.balance) / individuals.length);
				individuals[i].transfer(milestones[milestoneNum].payoutVal / individuals.length);
			}
		}
	}

	function getMilestones() constant returns (bytes32[]) {
		bytes32[] memory _milestoneNames = new bytes32[](milestones.length);

		for (uint i = 0; i < milestones.length; ++i) {
			_milestoneNames[i] = milestones[i].name;
		}

		return _milestoneNames;
	}

	function getNextMilestoneNum() constant returns (uint) {
		uint numDays = daysSinceInception();

		for (uint i = 0; i < milestones.length; ++i) {
			if (milestones[i].daysToPayout > numDays && milestones[i].paidOut == false) {
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