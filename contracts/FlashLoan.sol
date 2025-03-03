// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@aave/protocol-v2/contracts/flashloan/interfaces/IFlashLoanReceiver.sol";
import "@aave/protocol-v2/contracts/interfaces/ILendingPoolAddressesProvider.sol";
import "@aave/protocol-v2/contracts/interfaces/ILendingPool.sol";

contract FlashLoan is IFlashLoanReceiver, Ownable {
    ILendingPoolAddressesProvider public provider;
    address public token;

    constructor(address _provider, address _token) {
        provider = ILendingPoolAddressesProvider(_provider);
        token = _token;
    }

    /// @notice Initiates a flash loan
    /// @param amount The amount of tokens to borrow
    function flashLoan(uint256 amount) public onlyOwner {
        address receiverAddress = address(this);
        address[] memory assets = new address[](1);
        assets[0] = token;
        uint256[] memory amounts = new uint256[](1);
        amounts[0] = amount;
        uint256[] memory modes = new uint256[](1);
        modes[0] = 0; // 0 means no debt (flash loan mode)

        address onBehalfOf = address(this);
        bytes memory params = "";
        uint16 referralCode = 0;

        ILendingPool lendingPool = ILendingPool(provider.getLendingPool());
        lendingPool.flashLoan(receiverAddress, assets, amounts, modes, onBehalfOf, params, referralCode);
    }

    /// @notice This function is called after your contract has received the flash loaned amount
    /// @param assets The addresses of the assets being flash borrowed
    /// @param amounts The amounts of the assets being flash borrowed
    /// @param premiums The fees to be paid for the flash loans
    /// @param initiator The address that initiated the flash loan
    /// @param params Arbitrary data passed from the flash loan initiator
    function executeOperation(
        address[] calldata assets,
        uint256[] calldata amounts,
        uint256[] calldata premiums,
        address initiator,
        bytes calldata params
    ) external override returns (bool) {
        // Your custom logic here
        // Example: Arbitrage, liquidation, etc.

        // Repay the flash loan
        for (uint256 i = 0; i < assets.length; i++) {
            uint256 amountOwing = amounts[i] + premiums[i];
            IERC20(assets[i]).approve(address(provider.getLendingPool()), amountOwing);
        }

        return true;
    }

    /// @notice Withdraws tokens from the contract
    /// @param amount The amount of tokens to withdraw
    function withdraw(uint256 amount) public onlyOwner {
        IERC20(token).transfer(msg.sender, amount);
    }

    /// @notice Returns the balance of the contract
    /// @return The balance of the contract
    function balance() public view returns (uint256) {
        return IERC20(token).balanceOf(address(this));
    }

    /// @notice Returns the balance of the owner
    /// @return The balance of the owner
    function ownerBalance() public view returns (uint256) {
        return IERC20(token).balanceOf(owner());
    }

    /// @notice Transfers ownership of the contract
    /// @param newOwner The address of the new owner
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /// @notice Renounces ownership of the contract
    function renounceOwnership() public onlyOwner {
        _renounceOwnership();
    }
}
