//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//import '@openzeppelin/contracts/access/AccessControl.sol';


/**
 * @title Building a Oracle Service
 * @author Alexandre Rapchan B. Barros
 */

contract Oracle { // is AccessControl { //Ownable, 
    

    /// quote structure
    struct stock {
    	uint price;
    	uint volume;
    }
    
    /// quotes by symbol
    mapping( bytes4 => stock) stockQuote;
    
    /// Contract owner
    address oracleOwner;
    
    /// Set the value of a stock
    function setStock(bytes4 symbol, uint price, uint volume) public {}
    
    /// Get the value of a stock
    function getStockPrice(bytes4 symbol) public view returns (uint) {}
    
    /// Get the value of volume traded for a stock
    function getStockVolume(bytes4 symbol) public view returns (uint) {}

}