// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// internal & private view & pure functions
// external & public view & pure functions

//SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

import {DecentralizedStableCoin} from "./DecentralizedStableCoin.sol";
import {ReentrancyGuard} from "../lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";
import {IERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
/*
 * @title DSCEngine
 * @author Faraz 
 *
 * The system is designed to be as minimal as possible, and have the tokens maintain a 1 token == $1 peg at all times.
 * This is a stablecoin with the properties:
 * - Exogenously Collateralized
 * - Dollar Pegged
 * - Algorithmically Stable
 *
 * It is similar to DAI if DAI had no governance, no fees, and was backed by only WETH and WBTC.
 *
 * Our DSC system should always be "overcollateralized". At no point, should the value of
 * all collateral < the $ backed value of all the DSC.
 * Our DSC system should always be overcollateralized. At no point should the value shouold the 
   value of all collateral  <= the $ backed value of the DSC.
 * @notice This contract is the core of the Decentralized Stablecoin system. It handles all the logic
 * for minting and redeeming DSC, as well as depositing and withdrawing collateral.
 * @notice This contract is based on the MakerDAO DSS system
 */

contract DSCEngine is ReentrancyGuard {
    //------------Errors-------------------------
    error DSCEngine__NeedsMoreThanZero();
    error DSCEngine__TokenAddressAndPriceFeedAddressMustBeSame();
    error DSCEngine__NotAllowedToken();
    error DSCEngine__TransferFailed();

    //------------state variables----------------

    mapping(address token => address priceFeed) private s_priceFeeds;
    mapping(address user => mapping(address token => uint256 amount)) private s_collateralDeposited;
    mapping(address user=> uint256 amountDscMinted) private s_DSCMinted;

    DecentralizedStableCoin private immutable i_dsc;


    //----------------Events--------------------

    event CollateralDeposited(address indexed user, address indexed token, uint256 indexed amount);



    //---------------modifiers----------------------

    modifier moreThanZero(uint256 amount) {
        if (amount == 0) {
            revert DSCEngine__NeedsMoreThanZero();
        }
        _;
    }

    modifier isAllowedToken(address token) {
        if (s_priceFeeds[token] == address(0)) {
            revert DSCEngine__NotAllowedToken();
        }
        _;
    }

    //------------funtions--------------------

    constructor(address[] memory tokenAddresses, address[] memory priceFeedAddresses, address dscAddress) {
        //USD Price Feeds
        if (tokenAddresses.length != priceFeedAddresses.length) {
            revert DSCEngine__TokenAddressAndPriceFeedAddressMustBeSame();
        }

        //e.g. ETH/USD,  BTC/USD,  MKR/USD, etc

        for (uint256 i = 0; i < tokenAddresses.length; i++) {
            s_priceFeeds[tokenAddresses[i]] = priceFeedAddresses[i];
        }
        i_dsc = DecentralizedStableCoin(dscAddress);
    }


    //--------------External functions-----------


    function depositCollateralAndMintDSC() external {}


    // @param tokenCollateralAddress the address of the token to deposit as collateral
    //@param amountCollateral the amount of collateral to be deposit


    function depositCollateral(address tokenCollateralAddress, uint256 amountCollateral)
        external
        moreThanZero(amountCollateral)
        isAllowedToken(tokenCollateralAddress)
        nonReentrant
    {
        s_collateralDeposited[msg.sender][tokenCollateralAddress] += amountCollateral;
        emit CollateralDeposited(msg.sender, tokenCollateralAddress, amountCollateral);
        bool success = IERC20(tokenCollateralAddress).transferFrom(msg.sender,  address(this), amountCollateral);
        if(!success){
            revert DSCEngine__TransferFailed();
        }
    }

    function redeemCollateralForDSC() external {}

    function redeemCollateral() external {}


    //@param amountDscToMint The amount of decentralized stable coin to mint
    //@note They must have more collateral value than the threshold
    function mintDSC(uint256 amountDscToMint) external moreThanZero(amountDscToMint) {
        s_DSCMinted[msg.sender] += amountDscToMint;
        //if they minted too much ($150DSC, $100ETH)
        _revertIfHealthFactorisBroken(msg.sender);
    }

    function burnDSC() external {}


    function burnDC() external {}
    function  burnD()  external  {}

    
    function liquidate() external {}
    function getHealthFactor() external view {}


    //----------Private and Internal Functions---------------

    //returns how close to liquiditation a user is
    //if a user go below 1, then they can get  liquidated
    
    function  _healthFactor(address user)   private view returns (uint256) {
        
    }

    function _revertIfHealthFactorisBroken(address user) internal view{
        //1. check health factor (do they have enough collateral?)
        //2. Revert if they don't have enough collateral
    }

//this is a new commit and i will be implemented tomorrow
//or day after tomorrow
}
