// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;



contract EnumContract {
    enum LoanState {
        NONE,
        INITIATED,
        BORROWER,
        LENDER,
        FINISHED
    }

    address public borrower;
    address public lender;
    LoanState private currentState;

    address public winner;


    modifier atState(LoanState loanState) {
        require(currentState == loanState, "Wrong state, wait for an update!");
        _;
    }

    function stateInitialized() public atState(LoanState.NONE) {
        currentState = LoanState.INITIATED;
    }

    function restarState() public atState(LoanState.FINISHED) {
        currentState = LoanState.NONE;
    }

    function setBorrower(address _borrower) public atState(LoanState.BORROWER) {
        borrower = _borrower;
    }

    function setLender(address _lender) public atState(LoanState.LENDER) {
        lender = _lender;
    }

    function setWinner(address _winner) public atState(LoanState.FINISHED) {
        winner = _winner;
    }

    function changeState(uint8 state) public {
        require(state < 5, "Wrong state!");
        currentState = LoanState(state);
    }

    function getState() public view returns (uint8) {
        return uint8(currentState);
    }

    
}