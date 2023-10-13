pragma solidity 0.8.21;

// SPDX-License-Identifier: MIT
// ***********************************************************
// **** List available trading pairs for a given currency ****
// ***********************************************************


function strCompare(string memory str1, string memory str2) returns(bool) {
    return keccak256(abi.encodePacked(str1)) == keccak256(abi.encodePacked(str2));
}

function arrContains(string[] memory strList, string memory str) returns(bool) {
    for (uint i = 0; i < strList.length; i++) {
        if (strCompare(strList[i], str)) return true;
    }

    return false;
}

contract CurrencyPairs {
    string[] public currencies = ['BTC', 'ETH', 'BNB', 'XMR', 'ADA', 'AGIX'];

    event listPair(string);
    event emitErr(string);
    
    function listAllPairs() public {
        for (uint i = 0; i < currencies.length; i++) {
            for (uint j = 0; j < currencies.length; j++) {
                if (j == i) continue;
                // emit listPair(abi.encodePacked(currencies[i], currencies[j]));
                string memory sellCurrency = currencies[i];
                string memory buyCurrency = currencies[j];
                emit listPair(string.concat(sellCurrency, '/', buyCurrency));
            }
        }
    }

    function listCurrencyPair(string memory sellCurrency) public  {
        if (!arrContains(currencies, sellCurrency)) {
            emit emitErr(string.concat("Currency ", sellCurrency, " not available for trading"));
        }
        else {
            for (uint i = 0; i < currencies.length; i++) {
                string memory buyCurrency = currencies[i];
                bool isSameCurrency =  keccak256(abi.encodePacked(buyCurrency)) == keccak256(abi.encodePacked(sellCurrency));
                if (!isSameCurrency) {
                    emit listPair(string.concat(sellCurrency, '/', buyCurrency));
                }
            }
        }
    }
}
