// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract DecentralizedStableCoin is ERC20Burnable, Ownable {


    error DecentralizedStableCoin__MustBeMoreThanZero();
    error DecentralizedStableCoin__BurnAmountExceedsBalance();
    error DecentralizedStableCoin__AddressMustNotBeZero();


    constructor() ERC20("DecentralizedStableCoin", "DSC") Ownable(msg.sender) {}


    function burn (uint256 _amount) public override onlyOwner{
         uint256 balance = balanceOf(msg.sender);
            if(_amount <= 0){
                revert DecentralizedStableCoin__MustBeMoreThanZero();
            }
            if(balance<=_amount){
                revert DecentralizedStableCoin__BurnAmountExceedsBalance();
            }
            super.burn(_amount);
        }


    function mint (address _to, uint256 _amount) external onlyOwner returns(bool) {
        if(_amount<=0)
            {
            revert DecentralizedStableCoin__MustBeMoreThanZero();
            }
        if(_to == address(0)){
            revert DecentralizedStableCoin__AddressMustNotBeZero();
        }
        
        _mint(_to, _amount);
        return true;
    } 
        
}
