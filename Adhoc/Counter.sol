pragma solidity 0.8.21;

contract Counter {
    int public counter;

    constructor() {
        counter = 0;
    }

    event Increment(int num);
    event Decrement(int num);

    function getCounter() view public returns(int) {
        return counter;
    }

    function increment() public {
        counter += 1;
        emit Increment(counter);
    }

    function decrement() public {
        counter -= 1;
        emit Decrement(counter);
    } 
    
}