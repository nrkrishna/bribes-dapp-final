# Implemented Design Patterns
This contract doesn't accept payments as of now. So the design patterns utilized in the Bribes contract are quite simple.

I've used the following two patterns:
**Circuit breaker pattern.** 

This is to pause the contract should the need arise, such as a bug being identified in the contract or an upgrade needing to be made that results in state upgrades that become more difficult if state is allowed to be overwritten while it's being upgraded. 

I've implemented this pattern with the help of the Pausable contract. Note that this contract was inspired by the CryptoKitties codebase. 
 
**Restricting Access/Ownership pattern.**

Restricting access is required for the circuit breaker pattern, otherwise anyone can stop the main contract. 

I've implemented this pattern with the Ownable contract.

Note that the code for this pattern was inpsired by the CryptoKitties codebase.
