# Corruption Watch DApp
2018-2019 Consensys Developer Bootcamp Final Project
## Overview
This project contains a proof-of-concept Ethereum DApp and Ruby on Rails server that allows citizens of any country to report bribes that they have had to pay to officials for one reason or another. As background, I grew up in India, and corruption permates day to day life there. It's normal for officials at government departments, such as motor vehicle, water supply, taxation, etc, to get citizens to give a bribe to do their duties. It's one of the major reasons that the country is not able to make as much progress as it can. This problem is of course not unique to India. Corruption plagues developed and developing nations around the world, such as Russia, Brazil, China, North Korea, etc. 

My project was inspired by the website [IPaidABribe](https://www.ipadabribe.com). Ordinary citizens visit this site and report bribes in the hopes that documenting their bribes will bring them to the attention of a country's anti-corruption officers. Countries, such as India, are fairly open and value freedom of speech, which allows for websites like IPaidABribe to operate. Yet, there's a high risk that authoritarian and corrupt governments will choose to subvert, block or threaten sites like IPaidABribe. My hope is that by making it a DApp operating on the Ethereum blockchain, such subversive actions can be prevented.

## User Stories
A user that visits the website can see a list of all reported bribes. 

As someone who wants to report a bribe, the user has a way of entering details of his/her bribe anonymously. Details of the bribe to include date, amount and a description. Upon submission of this information, the details of the bribe are saved. It's important that no identifying information about the person reporting the bribe is collected to ensure privacy. 

## High-level Architecture
The DApp is fairly simple. A user can report a bribe via a web form. Details collected include date of bribe, amount paid (currently designed in INR or indian currency) and details of the bribe, such as location, reason and officer involved. The contents of the bribe are stored on IPFS with the hash of the file saved to an Ethereum smart contract. When a user visits the web3 enabled website, the list of IPFS hashes are retrived from the smart contract. The website then reads the contents of all the IPFS files and displays information about the bribes on a webpage. 

### Technologies Used
- IPFS
- Ethereum Smart Contract
- web3.js
- Metamask for signing transactions to the blockchain
- Ruby on rails and bootstrap for running the webserver

### Some Limitations
The contract and site is a simple proof-of-concept. Some noteworthy limitations:
- The server has no built-in caching and does a round trip to IPFS every time the page is loaded. 
- There's no mechanism as of now to arbitrate contested bribes. 
- Even paying gas fees can be very prohibitive for poor people in developing countries. This will surely dissuade people from using such as service. One possible solution to this is to have the gas cost covered through government grants and/or donations.

## Setup and Execution
### DApp
1. Download this repo to get the truffle folder. 
2. "truffle compile" and "truffle test" should work as expected. 
3. Run "truffle migrate" to deploy the DApp locally against ganache-cli.

### Server
1. You'll need Ruby on Rails to execute the server on your machine. If you don't have Ruby on Rails installed, please follow the instructions on this [website](https://gorails.com/setup/osx/10.14-mojave).
2. The server is in the "rails_server" folder in this repo.
3. Open a terminal and navigate to that folder. 
4. Execute "bundle install" in the terminal window. If that doesn't work, first install the ruby language bundler with the command "gem install bundler" and then try the command again. 
5. Copy the Bribes.json artifact file from the DApp's "build/contracts" folder and place it in the sub-directory "public" inside the web server folder. This is required for web3.js to initialize properly.
6. Start the server with the command "rails s".
7. Navigate to the site in the browser by going to the url "http://127.0.0.1:3000". 

I realize this setup is not the most straighforward because of Ruby on Rails. Please email me at nkrishna@gmail.com with any questions.

## Live Demo On Rinkeby 
Contract address: 0x5E0b7dCad1979cb3747c6D454d2F869F8645B0eC
Server deployed on: https://gentle-scrubland-56547.herokuapp.com/
