// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity 0.8.21;

import {IStEth} from "./interfaces/IStEth.sol";
import {MinimalAggregatorV3Interface} from "./interfaces/MinimalAggregatorV3Interface.sol";

/// @title WstEthStEthExchangeRateChainlinkAdapter
/// @author Morpho Labs
/// @custom:contact security@morpho.org
/// @notice Provides the exchange rate between wstETH and stETH using Chainlink price feed.
/// @dev This contract is intended to be deployed on Ethereum as a price feed for Morpho oracles.
contract WstEthStEthExchangeRateChainlinkAdapter is MinimalAggregatorV3Interface {
    /// @inheritdoc MinimalAggregatorV3Interface
    // @dev The price is returned with 18 decimals precision, regardless of the decimals value.
    uint8 public constant decimals = 18;

    /// @notice Description of the price feed.
    string public constant description = "wstETH/stETH exchange rate";

    /// @notice Address of stETH on Ethereum.
    IStEth public constant ST_ETH = IStEth(0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84);

    /// @inheritdoc MinimalAggregatorV3Interface
    /// @dev Returns zero for roundId, startedAt, updatedAt, and answeredInRound.
    /// @dev Assumes that `getPooledEthByShares` returns a value with 18 decimals precision.
    function latestRoundData() external view override returns (
        uint80 roundId,
        int256 answer,
        uint256 startedAt,
        uint256 updatedAt,
        uint80 answeredInRound
    ) {
        roundId = 0;
        answer = int256(ST_ETH.getPooledEthByShares(1 ether)); // 1 ether is used to get the price for 1 wstETH
        startedAt = 0;
        updatedAt = 0;
        answeredInRound = 0;
    }
}
