# Avoiding Common Attacks
1. Integer overflow/underflow
The bribes contract keeps an aggregate total of bribes paid. It's set to be an unsigned 256 bit integer, which is the largest possible value that can be stored in a smart contract, at least as far as I know. So the likelihood of it overflowing is pretty small. 

2. String for storing IPFS hash
My understanding is that the IPFS hash is not required to be a fixed length on account of it being a multi-hash. Therefore, I've resorted to using strings to store the IPFS hash instead of fixed byte length arrays, even though the use of a string is inefficient.
