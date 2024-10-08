# DecentralizedStableCoin (DSC) Smart Contract

## Overview

The **DecentralizedStableCoin** is an ERC-20 compliant token that represents a decentralized stablecoin on the Ethereum blockchain. It allows the contract owner to mint and burn tokens, maintaining stability and security within the decentralized finance (DeFi) ecosystem. This token can be used as a reliable medium of exchange or store of value, with all token issuance and burning processes restricted to the owner of the contract to ensure controlled supply.

## Features

- **ERC-20 Compliant**: Follows the standard ERC-20 functionality, allowing easy integration with wallets, exchanges, and DeFi platforms.
- **Minting**: The contract owner has the ability to mint new tokens to a specific address, increasing the total supply.
- **Burning**: The contract owner can burn tokens from their own balance, reducing the total supply.
- **Ownership**: Utilizes OpenZeppelin's `Ownable` pattern to manage ownership of the contract, ensuring that only the owner can mint or burn tokens.
- **Custom Errors**: Includes custom error messages to enhance debugging and code clarity when certain conditions are not met.

## Smart Contract Details

- **Token Name**: DecentralizedStableCoin
- **Token Symbol**: DSC
- **Decimals**: 18 (inherits from ERC-20 standard)

### Error Messages
- `DecentralizedStableCoin__MustBeMoreThanZero`: Raised when the mint or burn amount is less than or equal to zero.
- `DecentralizedStableCoin__BurnAmountExceedsBalance`: Raised when attempting to burn more tokens than the owner has in their balance.
- `DecentralizedStableCoin__AddressMustNotBeZero`: Raised when trying to mint to the zero address.

## Functions

### Constructor
```solidity
constructor() ERC20("DecentralizedStableCoin", "DSC") Ownable(msg.sender) {}
```
Initializes the token with the name `DecentralizedStableCoin` and the symbol `DSC`. The deployer of the contract becomes the owner.

### `mint` Function
```solidity
function mint(address _to, uint256 _amount) external onlyOwner returns (bool)
```
- **Description**: Allows the owner to mint `_amount` of DSC tokens and assign them to address `_to`.
- **Requirements**:
  - `_amount` must be greater than zero.
  - `_to` must not be the zero address (`0x0`).
- **Returns**: `true` if minting is successful.

### `burn` Function
```solidity
function burn(uint256 _amount) public override onlyOwner
```
- **Description**: Allows the owner to burn a specified `_amount` of DSC tokens from their balance.
- **Requirements**:
  - `_amount` must be greater than zero.
  - The owner's balance must be greater than or equal to `_amount`.
  
## How to Use

### Deployment

1. Install the dependencies:
   ```bash
   npm install @openzeppelin/contracts
   ```

2. Compile and deploy the contract using a development framework like [Hardhat](https://hardhat.org/) or [Truffle](https://www.trufflesuite.com/).

3. Once deployed, the contract owner can mint or burn tokens using the appropriate functions.

### Minting Tokens

To mint new tokens, the contract owner should call the `mint` function:

```solidity
mint(address _to, uint256 _amount)
```

- `_to`: The recipient address of the minted tokens.
- `_amount`: The number of tokens to mint (in smallest unit, 18 decimals).

### Burning Tokens

The owner can burn tokens from their own balance by calling the `burn` function:

```solidity
burn(uint256 _amount)
```

- `_amount`: The number of tokens to burn (in smallest unit, 18 decimals).

### Transfer Tokens

As the DSC token follows the ERC-20 standard, tokens can be transferred like any other ERC-20 token using the `transfer` function:

```solidity
transfer(address recipient, uint256 amount)
```

## Security Considerations

- Only the contract owner can mint and burn tokens, ensuring controlled supply.
- Reverts with custom error messages if certain conditions are not met, ensuring the contract operates correctly and prevents invalid actions.

## Dependencies

- [OpenZeppelin Contracts](https://github.com/OpenZeppelin/openzeppelin-contracts):
  - `ERC20`: Standard ERC-20 implementation.
  - `ERC20Burnable`: Adds burn functionality to the ERC-20 token.
  - `Ownable`: Adds an ownership mechanism to the contract for secure management.

## License

This project is under Development.

