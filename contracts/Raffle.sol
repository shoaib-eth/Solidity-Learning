// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Raffle is Ownable, ReentrancyGuard {
    using Counters for Counters.Counter;
    using SafeMath for uint256;

    Counters.Counter private _ticketIds;
    Counters.Counter private _raffleIds;

    struct RaffleInfo {
        uint256 raffleId;
        uint256 ticketPrice;
        uint256 ticketAmount;
        uint256 ticketSold;
        uint256 ticketRefund;
        uint256 ticketRefundAmount;
        uint256 raffleStart;
        uint256 raffleEnd;
        uint256 raffleWinner;
        uint256 raffleWinnerId;
        bool raffleEnded;
        bool raffleCancelled;
    }

    struct TicketInfo {
        uint256 ticketId;
        uint256 raffleId;
        address ticketOwner;
    }

    mapping(uint256 => RaffleInfo) public raffles;
    mapping(uint256 => TicketInfo) public tickets;

    event RaffleCreated(
        uint256 raffleId,
        uint256 ticketPrice,
        uint256 ticketAmount,
        uint256 raffleStart,
        uint256 raffleEnd
    );

    event RaffleEnded(
        uint256 raffleId,
        uint256 raffleWinnerId,
        address raffleWinner
    );

    event RaffleCancelled(uint256 raffleId);

    event TicketPurchased(
        uint256 ticketId,
        uint256 raffleId,
        address ticketOwner
    );

    event TicketRefunded(
        uint256 ticketId,
        uint256 raffleId,
        address ticketOwner
    );

    function createRaffle(
        uint256 _ticketPrice,
        uint256 _ticketAmount,
        uint256 _raffleStart,
        uint256 _raffleEnd
    ) external onlyOwner {
        require(
            _ticketPrice > 0,
            "Raffle: ticket price must be greater than 0"
        );
        require(
            _ticketAmount > 0,
            "Raffle: ticket amount must be greater than 0"
        );
        require(
            _raffleStart > block.timestamp,
            "Raffle: raffle start must be in the future"
        );
        require(
            _raffleEnd > _raffleStart,
            "Raffle: raffle end must be after raffle start"
        );

        _raffleIds.increment();
        uint256 raffleId = _raffleIds.current();

        raffles[raffleId] = RaffleInfo({
            raffleId: raffleId,
            ticketPrice: _ticketPrice,
            ticketAmount: _ticketAmount,
            ticketSold: 0,
            ticketRefund: 0,
            ticketRefundAmount: 0,
            raffleStart: _raffleStart,
            raffleEnd: _raffleEnd,
            raffleWinner: 0,
            raffleWinnerId: 0,
            raffleEnded: false,
            raffleCancelled: false
        });

        emit RaffleCreated(
            raffleId,
            _ticketPrice,
            _ticketAmount,
            _raffleStart,
            _raffleEnd
        );
    }

    function endRaffle(uint256 _raffleId) external onlyOwner {
        require(
            raffles[_raffleId].raffleId == _raffleId,
            "Raffle: raffle does not exist"
        );
        require(
            raffles[_raffleId].raffleEnded == false,
            "Raffle: raffle already ended"
        );
        require(
            raffles[_raffleId].raffleCancelled == false,
            "Raffle: raffle already cancelled"
        );
        require(
            block.timestamp >= raffles[_raffleId].raffleEnd,
            "Raffle: raffle has not ended yet"
        );

        raffles[_raffleId].raffleEnded = true;

        uint256 raffleWinnerId = (uint256(
            keccak256(abi.encodePacked(block.timestamp, block.difficulty))
        ) % raffles[_raffleId].ticketSold) + 1;
        address raffleWinner = tickets[raffleWinnerId].ticketOwner;

        raffles[_raffleId].raffleWinner = raffleWinner;
        raffles[_raffleId].raffleWinnerId = raffleWinnerId;

        emit RaffleEnded(_raffleId, raffleWinnerId, raffleWinner);
    }

    function cancelRaffle(uint256 _raffleId) external onlyOwner {
        require(
            raffles[_raffleId].raffleId == _raffleId,
            "Raffle: raffle does not exist"
        );
        require(
            raffles[_raffleId].raffleEnded == false,
            "Raffle: raffle already ended"
        );
        require(
            raffles[_raffleId].raffleCancelled == false,
            "Raffle: raffle already cancelled"
        );

        raffles[_raffleId].raffleCancelled = true;

        emit RaffleCancelled(_raffleId);
    }

    function purchaseTicket(uint256 _raffleId) external payable nonReentrant {
        require(
            raffles[_raffleId].raffleId == _raffleId,
            "Raffle: raffle does not exist"
        );
        require(
            raffles[_raffleId].raffleEnded == false,
            "Raffle: raffle already ended"
        );
        require(
            raffles[_raffleId].raffleCancelled == false,
            "Raffle: raffle already cancelled"
        );
        require(
            block.timestamp >= raffles[_raffleId].raffleStart,
            "Raffle: raffle has not started yet"
        );
        require(
            block.timestamp < raffles[_raffleId].raffleEnd,
            "Raffle: raffle has ended"
        );
        require(
            msg.value == raffles[_raffleId].ticketPrice,
            "Raffle: incorrect ticket price"
        );

        _ticketIds.increment();
        uint256 ticketId = _ticketIds.current();

        raffles[_raffleId].ticketSold = raffles[_raffleId].ticketSold.add(1);

        tickets[ticketId] = TicketInfo({
            ticketId: ticketId,
            raffleId: _raffleId,
            ticketOwner: msg.sender
        });

        emit TicketPurchased(ticketId, _raffleId, msg.sender);
    }

    function refundTicket(uint256 _ticketId) external nonReentrant {
        require(
            tickets[_ticketId].ticketId == _ticketId,
            "Raffle: ticket does not exist"
        );
        require(
            raffles[tickets[_ticketId].raffleId].raffleEnded == true,
            "Raffle: raffle has not ended yet"
        );
        require(
            raffles[tickets[_ticketId].raffleId].raffleCancelled == false,
            "Raffle: raffle has been cancelled"
        );
        require(
            tickets[_ticketId].ticketOwner == msg.sender,
            "Raffle: ticket does not belong to sender"
        );

        raffles[tickets[_ticketId].raffleId].ticketRefund = raffles[
            tickets[_ticketId].raffleId
        ].ticketRefund.add(1);

        tickets[_ticketId].ticketOwner = address(0);

        emit TicketRefunded(_ticketId, tickets[_ticketId].raffleId, msg.sender);
    }

    function withdrawRefund(uint256 _raffleId) external onlyOwner {
        require(
            raffles[_raffleId].raffleId == _raffleId,
            "Raffle: raffle does not exist"
        );
        require(
            raffles[_raffleId].raffleEnded == true,
            "Raffle: raffle has not ended yet"
        );
        require(
            raffles[_raffleId].raffleCancelled == false,
            "Raffle: raffle has been cancelled"
        );

        raffles[_raffleId].ticketRefundAmount = raffles[_raffleId]
            .ticketRefund
            .mul(raffles[_raffleId].ticketPrice);

        payable(owner()).transfer(raffles[_raffleId].ticketRefundAmount);
    }

    function withdrawFunds(uint256 _raffleId) external onlyOwner {
        require(
            raffles[_raffleId].raffleId == _raffleId,
            "Raffle: raffle does not exist"
        );
        require(
            raffles[_raffleId].raffleEnded == true,
            "Raffle: raffle has not ended yet"
        );
        require(
            raffles[_raffleId].raffleCancelled == false,
            "Raffle: raffle has been cancelled"
        );

        uint256 raffleFunds = raffles[_raffleId].ticketSold.mul(
            raffles[_raffleId].ticketPrice
        );

        payable(owner()).transfer(raffleFunds);
    }

    function getRaffleInfo(
        uint256 _raffleId
    ) external view returns (RaffleInfo memory) {
        return raffles[_raffleId];
    }

    function getTicketInfo(
        uint256 _ticketId
    ) external view returns (TicketInfo memory) {
        return tickets[_ticketId];
    }

    function getRaffleCount() external view returns (uint256) {
        return _raffleIds.current();
    }

    function getTicketCount() external view returns (uint256) {
        return _ticketIds.current();
    }

    function getRaffleWinner(
        uint256 _raffleId
    ) external view returns (address) {
        return raffles[_raffleId].raffleWinner;
    }

    function getRaffleWinnerId(
        uint256 _raffleId
    ) external view returns (uint256) {
        return raffles[_raffleId].raffleWinnerId;
    }

    function getTicketOwner(uint256 _ticketId) external view returns (address) {
        return tickets[_ticketId].ticketOwner;
    }

    function getTicketRaffle(
        uint256 _ticketId
    ) external view returns (uint256) {
        return tickets[_ticketId].raffleId;
    }

    function getTicketPrice(uint256 _raffleId) external view returns (uint256) {
        return raffles[_raffleId].ticketPrice;
    }

    function getTicketAmount(
        uint256 _raffleId
    ) external view returns (uint256) {
        return raffles[_raffleId].ticketAmount;
    }

    function getTicketSold(uint256 _raffleId) external view returns (uint256) {
        return raffles[_raffleId].ticketSold;
    }

    function getTicketRefund(
        uint256 _raffleId
    ) external view returns (uint256) {
        return raffles[_raffleId].ticketRefund;
    }

    function getTicketRefundAmount(
        uint256 _raffleId
    ) external view returns (uint256) {
        return raffles[_raffleId].ticketRefundAmount;
    }

    function getRaffleStart(uint256 _raffleId) external view returns (uint256) {
        return raffles[_raffleId].raffleStart;
    }

    function getRaffleEnd(uint256 _raffleId) external view returns (uint256) {
        return raffles[_raffleId].raffleEnd;
    }

    function getRaffleEnded(uint256 _raffleId) external view returns (bool) {
        return raffles[_raffleId].raffleEnded;
    }

    function getRaffleCancelled(
        uint256 _raffleId
    ) external view returns (bool) {
        return raffles[_raffleId].raffleCancelled;
    }

    function getTicketId() external view returns (uint256) {
        return _ticketIds.current();
    }

    function getRaffleId() external view returns (uint256) {
        return _raffleIds.current();
    }

    function getTicketPrice() external view returns (uint256) {
        return raffles[_raffleIds.current()].ticketPrice;
    }

    function getTicketAmount() external view returns (uint256) {
        return raffles[_raffleIds.current()].ticketAmount;
    }

    function getTicketSold() external view returns (uint256) {
        return raffles[_raffleIds.current()].ticketSold;
    }
}
