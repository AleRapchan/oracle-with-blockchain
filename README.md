# Oracle with Blockchain

Smart contracts can only work with data on the blockchain but in reality you will have cases where you need to make your contract use off-chain data. This application will put the data into a smart contract that can access the oracle smart contract to access the off-chain data.

![Logo](https://ipfs.io/ipfs/QmXjNaqAtTcaSCNgqnTRDjiQqewtXPDEdaRH97Nbuuruy1?filename=oracle-with-blockchain.png)

Important: You can never fully trust off-chain data!

# Goals for Oracle

- Create an Express server app
- Call a REST interface to get data
- Create a simple React app
- Call Express app from React to get data
- Write the data to the smart contract
- Read back from the smart contract

# Oracle Smart Contract

- Use Remix and Metamask
- Create state data

```js
/// quote structure
struct stock {
  uint price;
  uint volume;
}
/// quotes by symbol
mapping( bytes4 => stock) stockQuote;
/// Contract owner
address oracleOwner;
```

- Create functions

```js
/// Set the value of a stock
function setStock(bytes4 symbol, uint price, uint volume) public {...}
/// Get the value of a stock
function getStockPrice(bytes4 symbol) public view returns (uint) {...}
/// Get the value of volume traded for a stock
function getStockVolume(bytes4 symbol) public view returns (uint) {...}
```

- Test in Remix

## Oracle Express.js server app

- Use the Express app generator

```bash
npx express-generator
cd myapp
npm install axios
npm start
```

- Make call to your REST API to gather data

## REST call

- Register for your free access to REST call: https://www.alphavantage.co/

```js
fetch(
  "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=MSFT&apikey=KEY"
)
  .then((res) => res.json())
  .then((data) => {
    this.setState({ quote: data["Global Quote"] });
  })
  .catch(console.log);
```

## Oracle React App

- Install and run Ganache locally
- Create new app with create-react-app

```bash
npm install -g create-react-app
npx create-react-app new-oracle
cd new-oracle
npm start
npm install web3
```

## Connect React to Smart Contract using Web3

- Get a copy of your ABI and contract address from remix
- Put them in a file that we can use lie src/quotecontract.js

```js
export const STOCK_ORACLE_ADDRESS = '0x0YOURADDRESS'
export const STOCK_ORACLE_ABI = [ ... YOUR ABI ... ]
```

## Import in the stuff we need to connect

```js
import Web3 from "web3";
import { STOCK_ORACLE_ABI, STOCK_ORACLE_ADDRESS } from "./quotecontract";

const web3 = new Web3("http://localhost:7545");
const accounts = await web3.eth.getAccounts();
console.log("Account 0 = ", accounts[0]);
const stockQuote = new web3.eth.Contract(
  STOCK_ORACLE_ABI,
  STOCK_ORACLE_ADDRESS
);
var retval = await stockQuote.methods
  .getStockPrice(web3.utils.fromAscii("AAAA"))
  .call();
console.log(retval);
```

## React interface

- Create an interface in React
  - Ask for stock symbol
  - Lookup symbol using REST call
  - Write it to smart contract using setStock call
  - Read back and display results from smart contract using getStockPrice, getStockVolume
- Verify that it works by using getStockPrice, getStockVolume on remix with the
  symbol

## Author

- [@AleRapchan](https://www.github.com/AleRapchan)

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/alerapchan)

## Documentation

[Full Documentation](https://rapchan.gitbook.io/green-energy-tracker/)

## Support

For support, email blockchain@alexandrebarros.com or join our Slack channel.

## Appendix

- Web3.js: https://web3js.readthedocs.io/en/v1.2.11/web3-eth-contract.html#contract-events
- Bootstrap 5: https://getbootstrap.com/docs/5.0/getting-started/introduction/
- Metamask: https://docs.metamask.io/guide/
- Remix: https://remix-ide.readthedocs.io/en/latest/
- React: https://reactjs.org/docs/getting-started.html
- Solidity: https://docs.soliditylang.org/en/v0.4.24/
- Ganache: https://www.trufflesuite.com/docs/ganache/overview

# License

The MIT License (MIT)

Copyright (c) 2021 Alexandre Barros

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
