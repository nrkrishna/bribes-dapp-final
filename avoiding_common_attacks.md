# Avoiding Common Attacks

Because this contract doesn't accept payments, the design of the dapp and the security requirements are considerably simple. I paid attention to two security issues owing to the data structures used in the app.

**1. Integer overflow/underflow**

The bribes contract keeps an aggregate total of bribes paid. It's set to be an unsigned 256 bit integer, which is the largest possible value that can be stored in a smart contract, at least as far as I know. So the likelihood of it overflowing is pretty small. 

**2. String for storing IPFS hash**

My understanding is that the IPFS hash is not required to be a fixed length on account of it being a multi-hash. Therefore, I've resorted to using strings to store the IPFS hash instead of fixed byte length arrays, even though the use of a string is inefficient.

**3. Ownership consideration**

Because no money is accepted by this contract, there's little risk that central ownership of this contract will result in money transfers being stolen. That said, ownership of this contract by a single individual is still risky given the kind of information this dapp will be collecting. In the future, I can see the ownership model evolving to a distributed consensus driven team to prevent an owner turning rogue.  

**4. Lack of dispute resolution**

Lastly, this dapp is very much a proof of concept. So in it's current state if widely utilized, anyone can lodge a complaint which can result in malicious reports being lodged against honest officers. There's no dispute resolution mechanism built into the dapp as of now. This is not as much of a security issue as much as it's a functional limitation in the dapp that'll need to be addressed if this contract is to be used in a real-world setting.
