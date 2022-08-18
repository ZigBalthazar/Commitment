// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract commitmentReveal {
    uint256 constant ONE_DAY = 24 * 60 * 60;
    bytes32 commitment;
    uint256 timeOut;

    function setCommit(bytes32 _conmmit) external {
        if (commitment != bytes32(0)) {
            require(block.timestamp > timeOut, "wait");
        }
        commitment = _conmmit;
        timeOut = block.timestamp + ONE_DAY;
    }

    function Check(string memory _secret) external view returns(bool) {
        require(commitment == keccak256(abi.encodePacked(_secret,msg.sender)),"misMatch");
        return true;
    }

    function encrypt(string memory _secret) external view returns(bytes32) {
        return keccak256(abi.encodePacked(_secret,msg.sender));
    }
}
