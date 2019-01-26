pragma solidity ^0.5.0;

/** @title Ownable. */
contract Ownable {
    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    /** @dev Transfer ownership to a different owner.
      * @param newOwner address of the new owner.
      */
    function transferOwnership(address newOwner) public onlyOwner {
        if (newOwner != address(0)) {
            owner = newOwner;
        }
    }
}

/** @title Pausable. */
contract Pausable is Ownable {
    event Pause();
    event Unpause();

    bool public paused = false;

    modifier whenNotPaused() {
        require(!paused);
        _;
    }

    modifier whenPaused {
        require(paused);
        _;
    }

    /** @dev Pauses the contract should that ever be needed.
      * @return result true or false
      */
    function pause() public onlyOwner whenNotPaused returns (bool result) {
        paused = true;
        emit Pause();
        return true;
    }

    /** @dev Unpauses a previously paused contract.
      * @return result true or false
      */
    function unpause() public onlyOwner whenPaused returns (bool result) {
        paused = false;
        emit Unpause();
        return true;
    }
}

/** @title Bribes. */
contract Bribes is Pausable {

    /** @dev Event fired when a bribe reported to this contract is successfully stored
     */
    event LogBribeReported(uint256 bribeIndex, string ipfsHash);

    /*
     * Public store of bribes reported to this contract. Using string as data structure
     * because ipfs hashes don't have a fixed length and are subject to change.
     */
    string[] public bribes;

    // A running count of the total amount of bribes paid.
    uint256 public bribesTotalPaid;

    /** @dev Stores the reported bribe to the contract.
      * @param ipfsHash Hash of the Ipfs file where details of the bribe are stored.
      * @param amount Amount given as a bribe.
      */
    function reportBribe(string memory ipfsHash, uint256 amount) public {
        // Ensure that the reward amount is greater than 0
        require(amount > 0);
        require(bytes(ipfsHash).length > 0);

        bribes.push(ipfsHash);
        bribesTotalPaid = bribesTotalPaid + amount;
        emit LogBribeReported(bribes.length - 1, ipfsHash);
    }

    /** @dev Gets the ipfsHash for a given bribe
      * @param bribeId Id of the bribe for which the ipfs hash is being requested
      * @return ipfsHash ipfsHash for the requested bribe
      */
    function bribeDetails(uint32 bribeId) public view returns (string memory ipfsHash) {
        // Ensure that it's a valid bribe
        require(bribeId < bribes.length);

        return bribes[bribeId];
    }

    /** @dev Returns the number of bribes reported to this contract
      * @return number number of bribes known to this contract
      */
    function numberOfBribes() public view returns (uint256 number) {
        return bribes.length;
    }

    /** @dev Fallback function - Called if other functions don't match call or
      *      sent ether without data. Typically, called when invalid data is sent
      *      Added so ether sent to this contract is reverted if the contract fails
      *      otherwise, the sender's money is transferred to contract
      */
    function() external {
        revert();
    }
}
