// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract DecentralizedRBAC {
    // ---- Events ----
    event RoleGranted(address indexed account, string role);
    event RoleRevoked(address indexed account, string role);

    // ---- Storage ----
    mapping(address => mapping(string => bool)) private roles;

    // ---- Constructor ----
    constructor() {
        // Grant deployer the "ADMIN" role
        roles[msg.sender]["ADMIN"] = true;
        emit RoleGranted(msg.sender, "ADMIN");
    }

    // ---- Modifiers ----
    modifier onlyRole(string memory _role) {
        require(roles[msg.sender][_role], "Access denied: missing role");
        _;
    }

    // ---- Core Functions ----
    function grantRole(address _account, string memory _role) public onlyRole("ADMIN") {
        roles[_account][_role] = true;
        emit RoleGranted(_account, _role);
    }

    function revokeRole(address _account, string memory _role) public onlyRole("ADMIN") {
        roles[_account][_role] = false;
        emit RoleRevoked(_account, _role);
    }

    function hasRole(address _account, string memory _role) public view returns (bool) {
        return roles[_account][_role];
    }
}

