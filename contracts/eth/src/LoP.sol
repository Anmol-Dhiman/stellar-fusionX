// File: @openzeppelin/contracts/utils/Panic.sol

// OpenZeppelin Contracts (last updated v5.1.0) (utils/Panic.sol)

pragma solidity ^0.8.20;

/**
 * @dev Helper library for emitting standardized panic codes.
 *
 * ```solidity
 * contract Example {
 *      using Panic for uint256;
 *
 *      // Use any of the declared internal constants
 *      function foo() { Panic.GENERIC.panic(); }
 *
 *      // Alternatively
 *      function foo() { Panic.panic(Panic.GENERIC); }
 * }
 * ```
 *
 * Follows the list from https://github.com/ethereum/solidity/blob/v0.8.24/libsolutil/ErrorCodes.h[libsolutil].
 *
 * _Available since v5.1._
 */
// slither-disable-next-line unused-state
library Panic {
    /// @dev generic / unspecified error
    uint256 internal constant GENERIC = 0x00;
    /// @dev used by the assert() builtin
    uint256 internal constant ASSERT = 0x01;
    /// @dev arithmetic underflow or overflow
    uint256 internal constant UNDER_OVERFLOW = 0x11;
    /// @dev division or modulo by zero
    uint256 internal constant DIVISION_BY_ZERO = 0x12;
    /// @dev enum conversion error
    uint256 internal constant ENUM_CONVERSION_ERROR = 0x21;
    /// @dev invalid encoding in storage
    uint256 internal constant STORAGE_ENCODING_ERROR = 0x22;
    /// @dev empty array pop
    uint256 internal constant EMPTY_ARRAY_POP = 0x31;
    /// @dev array out of bounds access
    uint256 internal constant ARRAY_OUT_OF_BOUNDS = 0x32;
    /// @dev resource error (too large allocation or too large array)
    uint256 internal constant RESOURCE_ERROR = 0x41;
    /// @dev calling invalid internal function
    uint256 internal constant INVALID_INTERNAL_FUNCTION = 0x51;

    /// @dev Reverts with a panic code. Recommended to use with
    /// the internal constants with predefined codes.
    function panic(uint256 code) internal pure {
        assembly ("memory-safe") {
            mstore(0x00, 0x4e487b71)
            mstore(0x20, code)
            revert(0x1c, 0x24)
        }
    }
}

// File: @openzeppelin/contracts/utils/math/SafeCast.sol

// OpenZeppelin Contracts (last updated v5.1.0) (utils/math/SafeCast.sol)
// This file was procedurally generated from scripts/generate/templates/SafeCast.js.

pragma solidity ^0.8.20;

/**
 * @dev Wrappers over Solidity's uintXX/intXX/bool casting operators with added overflow
 * checks.
 *
 * Downcasting from uint256/int256 in Solidity does not revert on overflow. This can
 * easily result in undesired exploitation or bugs, since developers usually
 * assume that overflows raise errors. `SafeCast` restores this intuition by
 * reverting the transaction when such an operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeCast {
    /**
     * @dev Value doesn't fit in an uint of `bits` size.
     */
    error SafeCastOverflowedUintDowncast(uint8 bits, uint256 value);

    /**
     * @dev An int value doesn't fit in an uint of `bits` size.
     */
    error SafeCastOverflowedIntToUint(int256 value);

    /**
     * @dev Value doesn't fit in an int of `bits` size.
     */
    error SafeCastOverflowedIntDowncast(uint8 bits, int256 value);

    /**
     * @dev An uint value doesn't fit in an int of `bits` size.
     */
    error SafeCastOverflowedUintToInt(uint256 value);

    /**
     * @dev Returns the downcasted uint248 from uint256, reverting on
     * overflow (when the input is greater than largest uint248).
     *
     * Counterpart to Solidity's `uint248` operator.
     *
     * Requirements:
     *
     * - input must fit into 248 bits
     */
    function toUint248(uint256 value) internal pure returns (uint248) {
        if (value > type(uint248).max) {
            revert SafeCastOverflowedUintDowncast(248, value);
        }
        return uint248(value);
    }

    /**
     * @dev Returns the downcasted uint240 from uint256, reverting on
     * overflow (when the input is greater than largest uint240).
     *
     * Counterpart to Solidity's `uint240` operator.
     *
     * Requirements:
     *
     * - input must fit into 240 bits
     */
    function toUint240(uint256 value) internal pure returns (uint240) {
        if (value > type(uint240).max) {
            revert SafeCastOverflowedUintDowncast(240, value);
        }
        return uint240(value);
    }

    /**
     * @dev Returns the downcasted uint232 from uint256, reverting on
     * overflow (when the input is greater than largest uint232).
     *
     * Counterpart to Solidity's `uint232` operator.
     *
     * Requirements:
     *
     * - input must fit into 232 bits
     */
    function toUint232(uint256 value) internal pure returns (uint232) {
        if (value > type(uint232).max) {
            revert SafeCastOverflowedUintDowncast(232, value);
        }
        return uint232(value);
    }

    /**
     * @dev Returns the downcasted uint224 from uint256, reverting on
     * overflow (when the input is greater than largest uint224).
     *
     * Counterpart to Solidity's `uint224` operator.
     *
     * Requirements:
     *
     * - input must fit into 224 bits
     */
    function toUint224(uint256 value) internal pure returns (uint224) {
        if (value > type(uint224).max) {
            revert SafeCastOverflowedUintDowncast(224, value);
        }
        return uint224(value);
    }

    /**
     * @dev Returns the downcasted uint216 from uint256, reverting on
     * overflow (when the input is greater than largest uint216).
     *
     * Counterpart to Solidity's `uint216` operator.
     *
     * Requirements:
     *
     * - input must fit into 216 bits
     */
    function toUint216(uint256 value) internal pure returns (uint216) {
        if (value > type(uint216).max) {
            revert SafeCastOverflowedUintDowncast(216, value);
        }
        return uint216(value);
    }

    /**
     * @dev Returns the downcasted uint208 from uint256, reverting on
     * overflow (when the input is greater than largest uint208).
     *
     * Counterpart to Solidity's `uint208` operator.
     *
     * Requirements:
     *
     * - input must fit into 208 bits
     */
    function toUint208(uint256 value) internal pure returns (uint208) {
        if (value > type(uint208).max) {
            revert SafeCastOverflowedUintDowncast(208, value);
        }
        return uint208(value);
    }

    /**
     * @dev Returns the downcasted uint200 from uint256, reverting on
     * overflow (when the input is greater than largest uint200).
     *
     * Counterpart to Solidity's `uint200` operator.
     *
     * Requirements:
     *
     * - input must fit into 200 bits
     */
    function toUint200(uint256 value) internal pure returns (uint200) {
        if (value > type(uint200).max) {
            revert SafeCastOverflowedUintDowncast(200, value);
        }
        return uint200(value);
    }

    /**
     * @dev Returns the downcasted uint192 from uint256, reverting on
     * overflow (when the input is greater than largest uint192).
     *
     * Counterpart to Solidity's `uint192` operator.
     *
     * Requirements:
     *
     * - input must fit into 192 bits
     */
    function toUint192(uint256 value) internal pure returns (uint192) {
        if (value > type(uint192).max) {
            revert SafeCastOverflowedUintDowncast(192, value);
        }
        return uint192(value);
    }

    /**
     * @dev Returns the downcasted uint184 from uint256, reverting on
     * overflow (when the input is greater than largest uint184).
     *
     * Counterpart to Solidity's `uint184` operator.
     *
     * Requirements:
     *
     * - input must fit into 184 bits
     */
    function toUint184(uint256 value) internal pure returns (uint184) {
        if (value > type(uint184).max) {
            revert SafeCastOverflowedUintDowncast(184, value);
        }
        return uint184(value);
    }

    /**
     * @dev Returns the downcasted uint176 from uint256, reverting on
     * overflow (when the input is greater than largest uint176).
     *
     * Counterpart to Solidity's `uint176` operator.
     *
     * Requirements:
     *
     * - input must fit into 176 bits
     */
    function toUint176(uint256 value) internal pure returns (uint176) {
        if (value > type(uint176).max) {
            revert SafeCastOverflowedUintDowncast(176, value);
        }
        return uint176(value);
    }

    /**
     * @dev Returns the downcasted uint168 from uint256, reverting on
     * overflow (when the input is greater than largest uint168).
     *
     * Counterpart to Solidity's `uint168` operator.
     *
     * Requirements:
     *
     * - input must fit into 168 bits
     */
    function toUint168(uint256 value) internal pure returns (uint168) {
        if (value > type(uint168).max) {
            revert SafeCastOverflowedUintDowncast(168, value);
        }
        return uint168(value);
    }

    /**
     * @dev Returns the downcasted uint160 from uint256, reverting on
     * overflow (when the input is greater than largest uint160).
     *
     * Counterpart to Solidity's `uint160` operator.
     *
     * Requirements:
     *
     * - input must fit into 160 bits
     */
    function toUint160(uint256 value) internal pure returns (uint160) {
        if (value > type(uint160).max) {
            revert SafeCastOverflowedUintDowncast(160, value);
        }
        return uint160(value);
    }

    /**
     * @dev Returns the downcasted uint152 from uint256, reverting on
     * overflow (when the input is greater than largest uint152).
     *
     * Counterpart to Solidity's `uint152` operator.
     *
     * Requirements:
     *
     * - input must fit into 152 bits
     */
    function toUint152(uint256 value) internal pure returns (uint152) {
        if (value > type(uint152).max) {
            revert SafeCastOverflowedUintDowncast(152, value);
        }
        return uint152(value);
    }

    /**
     * @dev Returns the downcasted uint144 from uint256, reverting on
     * overflow (when the input is greater than largest uint144).
     *
     * Counterpart to Solidity's `uint144` operator.
     *
     * Requirements:
     *
     * - input must fit into 144 bits
     */
    function toUint144(uint256 value) internal pure returns (uint144) {
        if (value > type(uint144).max) {
            revert SafeCastOverflowedUintDowncast(144, value);
        }
        return uint144(value);
    }

    /**
     * @dev Returns the downcasted uint136 from uint256, reverting on
     * overflow (when the input is greater than largest uint136).
     *
     * Counterpart to Solidity's `uint136` operator.
     *
     * Requirements:
     *
     * - input must fit into 136 bits
     */
    function toUint136(uint256 value) internal pure returns (uint136) {
        if (value > type(uint136).max) {
            revert SafeCastOverflowedUintDowncast(136, value);
        }
        return uint136(value);
    }

    /**
     * @dev Returns the downcasted uint128 from uint256, reverting on
     * overflow (when the input is greater than largest uint128).
     *
     * Counterpart to Solidity's `uint128` operator.
     *
     * Requirements:
     *
     * - input must fit into 128 bits
     */
    function toUint128(uint256 value) internal pure returns (uint128) {
        if (value > type(uint128).max) {
            revert SafeCastOverflowedUintDowncast(128, value);
        }
        return uint128(value);
    }

    /**
     * @dev Returns the downcasted uint120 from uint256, reverting on
     * overflow (when the input is greater than largest uint120).
     *
     * Counterpart to Solidity's `uint120` operator.
     *
     * Requirements:
     *
     * - input must fit into 120 bits
     */
    function toUint120(uint256 value) internal pure returns (uint120) {
        if (value > type(uint120).max) {
            revert SafeCastOverflowedUintDowncast(120, value);
        }
        return uint120(value);
    }

    /**
     * @dev Returns the downcasted uint112 from uint256, reverting on
     * overflow (when the input is greater than largest uint112).
     *
     * Counterpart to Solidity's `uint112` operator.
     *
     * Requirements:
     *
     * - input must fit into 112 bits
     */
    function toUint112(uint256 value) internal pure returns (uint112) {
        if (value > type(uint112).max) {
            revert SafeCastOverflowedUintDowncast(112, value);
        }
        return uint112(value);
    }

    /**
     * @dev Returns the downcasted uint104 from uint256, reverting on
     * overflow (when the input is greater than largest uint104).
     *
     * Counterpart to Solidity's `uint104` operator.
     *
     * Requirements:
     *
     * - input must fit into 104 bits
     */
    function toUint104(uint256 value) internal pure returns (uint104) {
        if (value > type(uint104).max) {
            revert SafeCastOverflowedUintDowncast(104, value);
        }
        return uint104(value);
    }

    /**
     * @dev Returns the downcasted uint96 from uint256, reverting on
     * overflow (when the input is greater than largest uint96).
     *
     * Counterpart to Solidity's `uint96` operator.
     *
     * Requirements:
     *
     * - input must fit into 96 bits
     */
    function toUint96(uint256 value) internal pure returns (uint96) {
        if (value > type(uint96).max) {
            revert SafeCastOverflowedUintDowncast(96, value);
        }
        return uint96(value);
    }

    /**
     * @dev Returns the downcasted uint88 from uint256, reverting on
     * overflow (when the input is greater than largest uint88).
     *
     * Counterpart to Solidity's `uint88` operator.
     *
     * Requirements:
     *
     * - input must fit into 88 bits
     */
    function toUint88(uint256 value) internal pure returns (uint88) {
        if (value > type(uint88).max) {
            revert SafeCastOverflowedUintDowncast(88, value);
        }
        return uint88(value);
    }

    /**
     * @dev Returns the downcasted uint80 from uint256, reverting on
     * overflow (when the input is greater than largest uint80).
     *
     * Counterpart to Solidity's `uint80` operator.
     *
     * Requirements:
     *
     * - input must fit into 80 bits
     */
    function toUint80(uint256 value) internal pure returns (uint80) {
        if (value > type(uint80).max) {
            revert SafeCastOverflowedUintDowncast(80, value);
        }
        return uint80(value);
    }

    /**
     * @dev Returns the downcasted uint72 from uint256, reverting on
     * overflow (when the input is greater than largest uint72).
     *
     * Counterpart to Solidity's `uint72` operator.
     *
     * Requirements:
     *
     * - input must fit into 72 bits
     */
    function toUint72(uint256 value) internal pure returns (uint72) {
        if (value > type(uint72).max) {
            revert SafeCastOverflowedUintDowncast(72, value);
        }
        return uint72(value);
    }

    /**
     * @dev Returns the downcasted uint64 from uint256, reverting on
     * overflow (when the input is greater than largest uint64).
     *
     * Counterpart to Solidity's `uint64` operator.
     *
     * Requirements:
     *
     * - input must fit into 64 bits
     */
    function toUint64(uint256 value) internal pure returns (uint64) {
        if (value > type(uint64).max) {
            revert SafeCastOverflowedUintDowncast(64, value);
        }
        return uint64(value);
    }

    /**
     * @dev Returns the downcasted uint56 from uint256, reverting on
     * overflow (when the input is greater than largest uint56).
     *
     * Counterpart to Solidity's `uint56` operator.
     *
     * Requirements:
     *
     * - input must fit into 56 bits
     */
    function toUint56(uint256 value) internal pure returns (uint56) {
        if (value > type(uint56).max) {
            revert SafeCastOverflowedUintDowncast(56, value);
        }
        return uint56(value);
    }

    /**
     * @dev Returns the downcasted uint48 from uint256, reverting on
     * overflow (when the input is greater than largest uint48).
     *
     * Counterpart to Solidity's `uint48` operator.
     *
     * Requirements:
     *
     * - input must fit into 48 bits
     */
    function toUint48(uint256 value) internal pure returns (uint48) {
        if (value > type(uint48).max) {
            revert SafeCastOverflowedUintDowncast(48, value);
        }
        return uint48(value);
    }

    /**
     * @dev Returns the downcasted uint40 from uint256, reverting on
     * overflow (when the input is greater than largest uint40).
     *
     * Counterpart to Solidity's `uint40` operator.
     *
     * Requirements:
     *
     * - input must fit into 40 bits
     */
    function toUint40(uint256 value) internal pure returns (uint40) {
        if (value > type(uint40).max) {
            revert SafeCastOverflowedUintDowncast(40, value);
        }
        return uint40(value);
    }

    /**
     * @dev Returns the downcasted uint32 from uint256, reverting on
     * overflow (when the input is greater than largest uint32).
     *
     * Counterpart to Solidity's `uint32` operator.
     *
     * Requirements:
     *
     * - input must fit into 32 bits
     */
    function toUint32(uint256 value) internal pure returns (uint32) {
        if (value > type(uint32).max) {
            revert SafeCastOverflowedUintDowncast(32, value);
        }
        return uint32(value);
    }

    /**
     * @dev Returns the downcasted uint24 from uint256, reverting on
     * overflow (when the input is greater than largest uint24).
     *
     * Counterpart to Solidity's `uint24` operator.
     *
     * Requirements:
     *
     * - input must fit into 24 bits
     */
    function toUint24(uint256 value) internal pure returns (uint24) {
        if (value > type(uint24).max) {
            revert SafeCastOverflowedUintDowncast(24, value);
        }
        return uint24(value);
    }

    /**
     * @dev Returns the downcasted uint16 from uint256, reverting on
     * overflow (when the input is greater than largest uint16).
     *
     * Counterpart to Solidity's `uint16` operator.
     *
     * Requirements:
     *
     * - input must fit into 16 bits
     */
    function toUint16(uint256 value) internal pure returns (uint16) {
        if (value > type(uint16).max) {
            revert SafeCastOverflowedUintDowncast(16, value);
        }
        return uint16(value);
    }

    /**
     * @dev Returns the downcasted uint8 from uint256, reverting on
     * overflow (when the input is greater than largest uint8).
     *
     * Counterpart to Solidity's `uint8` operator.
     *
     * Requirements:
     *
     * - input must fit into 8 bits
     */
    function toUint8(uint256 value) internal pure returns (uint8) {
        if (value > type(uint8).max) {
            revert SafeCastOverflowedUintDowncast(8, value);
        }
        return uint8(value);
    }

    /**
     * @dev Converts a signed int256 into an unsigned uint256.
     *
     * Requirements:
     *
     * - input must be greater than or equal to 0.
     */
    function toUint256(int256 value) internal pure returns (uint256) {
        if (value < 0) {
            revert SafeCastOverflowedIntToUint(value);
        }
        return uint256(value);
    }

    /**
     * @dev Returns the downcasted int248 from int256, reverting on
     * overflow (when the input is less than smallest int248 or
     * greater than largest int248).
     *
     * Counterpart to Solidity's `int248` operator.
     *
     * Requirements:
     *
     * - input must fit into 248 bits
     */
    function toInt248(int256 value) internal pure returns (int248 downcasted) {
        downcasted = int248(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(248, value);
        }
    }

    /**
     * @dev Returns the downcasted int240 from int256, reverting on
     * overflow (when the input is less than smallest int240 or
     * greater than largest int240).
     *
     * Counterpart to Solidity's `int240` operator.
     *
     * Requirements:
     *
     * - input must fit into 240 bits
     */
    function toInt240(int256 value) internal pure returns (int240 downcasted) {
        downcasted = int240(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(240, value);
        }
    }

    /**
     * @dev Returns the downcasted int232 from int256, reverting on
     * overflow (when the input is less than smallest int232 or
     * greater than largest int232).
     *
     * Counterpart to Solidity's `int232` operator.
     *
     * Requirements:
     *
     * - input must fit into 232 bits
     */
    function toInt232(int256 value) internal pure returns (int232 downcasted) {
        downcasted = int232(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(232, value);
        }
    }

    /**
     * @dev Returns the downcasted int224 from int256, reverting on
     * overflow (when the input is less than smallest int224 or
     * greater than largest int224).
     *
     * Counterpart to Solidity's `int224` operator.
     *
     * Requirements:
     *
     * - input must fit into 224 bits
     */
    function toInt224(int256 value) internal pure returns (int224 downcasted) {
        downcasted = int224(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(224, value);
        }
    }

    /**
     * @dev Returns the downcasted int216 from int256, reverting on
     * overflow (when the input is less than smallest int216 or
     * greater than largest int216).
     *
     * Counterpart to Solidity's `int216` operator.
     *
     * Requirements:
     *
     * - input must fit into 216 bits
     */
    function toInt216(int256 value) internal pure returns (int216 downcasted) {
        downcasted = int216(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(216, value);
        }
    }

    /**
     * @dev Returns the downcasted int208 from int256, reverting on
     * overflow (when the input is less than smallest int208 or
     * greater than largest int208).
     *
     * Counterpart to Solidity's `int208` operator.
     *
     * Requirements:
     *
     * - input must fit into 208 bits
     */
    function toInt208(int256 value) internal pure returns (int208 downcasted) {
        downcasted = int208(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(208, value);
        }
    }

    /**
     * @dev Returns the downcasted int200 from int256, reverting on
     * overflow (when the input is less than smallest int200 or
     * greater than largest int200).
     *
     * Counterpart to Solidity's `int200` operator.
     *
     * Requirements:
     *
     * - input must fit into 200 bits
     */
    function toInt200(int256 value) internal pure returns (int200 downcasted) {
        downcasted = int200(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(200, value);
        }
    }

    /**
     * @dev Returns the downcasted int192 from int256, reverting on
     * overflow (when the input is less than smallest int192 or
     * greater than largest int192).
     *
     * Counterpart to Solidity's `int192` operator.
     *
     * Requirements:
     *
     * - input must fit into 192 bits
     */
    function toInt192(int256 value) internal pure returns (int192 downcasted) {
        downcasted = int192(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(192, value);
        }
    }

    /**
     * @dev Returns the downcasted int184 from int256, reverting on
     * overflow (when the input is less than smallest int184 or
     * greater than largest int184).
     *
     * Counterpart to Solidity's `int184` operator.
     *
     * Requirements:
     *
     * - input must fit into 184 bits
     */
    function toInt184(int256 value) internal pure returns (int184 downcasted) {
        downcasted = int184(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(184, value);
        }
    }

    /**
     * @dev Returns the downcasted int176 from int256, reverting on
     * overflow (when the input is less than smallest int176 or
     * greater than largest int176).
     *
     * Counterpart to Solidity's `int176` operator.
     *
     * Requirements:
     *
     * - input must fit into 176 bits
     */
    function toInt176(int256 value) internal pure returns (int176 downcasted) {
        downcasted = int176(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(176, value);
        }
    }

    /**
     * @dev Returns the downcasted int168 from int256, reverting on
     * overflow (when the input is less than smallest int168 or
     * greater than largest int168).
     *
     * Counterpart to Solidity's `int168` operator.
     *
     * Requirements:
     *
     * - input must fit into 168 bits
     */
    function toInt168(int256 value) internal pure returns (int168 downcasted) {
        downcasted = int168(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(168, value);
        }
    }

    /**
     * @dev Returns the downcasted int160 from int256, reverting on
     * overflow (when the input is less than smallest int160 or
     * greater than largest int160).
     *
     * Counterpart to Solidity's `int160` operator.
     *
     * Requirements:
     *
     * - input must fit into 160 bits
     */
    function toInt160(int256 value) internal pure returns (int160 downcasted) {
        downcasted = int160(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(160, value);
        }
    }

    /**
     * @dev Returns the downcasted int152 from int256, reverting on
     * overflow (when the input is less than smallest int152 or
     * greater than largest int152).
     *
     * Counterpart to Solidity's `int152` operator.
     *
     * Requirements:
     *
     * - input must fit into 152 bits
     */
    function toInt152(int256 value) internal pure returns (int152 downcasted) {
        downcasted = int152(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(152, value);
        }
    }

    /**
     * @dev Returns the downcasted int144 from int256, reverting on
     * overflow (when the input is less than smallest int144 or
     * greater than largest int144).
     *
     * Counterpart to Solidity's `int144` operator.
     *
     * Requirements:
     *
     * - input must fit into 144 bits
     */
    function toInt144(int256 value) internal pure returns (int144 downcasted) {
        downcasted = int144(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(144, value);
        }
    }

    /**
     * @dev Returns the downcasted int136 from int256, reverting on
     * overflow (when the input is less than smallest int136 or
     * greater than largest int136).
     *
     * Counterpart to Solidity's `int136` operator.
     *
     * Requirements:
     *
     * - input must fit into 136 bits
     */
    function toInt136(int256 value) internal pure returns (int136 downcasted) {
        downcasted = int136(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(136, value);
        }
    }

    /**
     * @dev Returns the downcasted int128 from int256, reverting on
     * overflow (when the input is less than smallest int128 or
     * greater than largest int128).
     *
     * Counterpart to Solidity's `int128` operator.
     *
     * Requirements:
     *
     * - input must fit into 128 bits
     */
    function toInt128(int256 value) internal pure returns (int128 downcasted) {
        downcasted = int128(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(128, value);
        }
    }

    /**
     * @dev Returns the downcasted int120 from int256, reverting on
     * overflow (when the input is less than smallest int120 or
     * greater than largest int120).
     *
     * Counterpart to Solidity's `int120` operator.
     *
     * Requirements:
     *
     * - input must fit into 120 bits
     */
    function toInt120(int256 value) internal pure returns (int120 downcasted) {
        downcasted = int120(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(120, value);
        }
    }

    /**
     * @dev Returns the downcasted int112 from int256, reverting on
     * overflow (when the input is less than smallest int112 or
     * greater than largest int112).
     *
     * Counterpart to Solidity's `int112` operator.
     *
     * Requirements:
     *
     * - input must fit into 112 bits
     */
    function toInt112(int256 value) internal pure returns (int112 downcasted) {
        downcasted = int112(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(112, value);
        }
    }

    /**
     * @dev Returns the downcasted int104 from int256, reverting on
     * overflow (when the input is less than smallest int104 or
     * greater than largest int104).
     *
     * Counterpart to Solidity's `int104` operator.
     *
     * Requirements:
     *
     * - input must fit into 104 bits
     */
    function toInt104(int256 value) internal pure returns (int104 downcasted) {
        downcasted = int104(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(104, value);
        }
    }

    /**
     * @dev Returns the downcasted int96 from int256, reverting on
     * overflow (when the input is less than smallest int96 or
     * greater than largest int96).
     *
     * Counterpart to Solidity's `int96` operator.
     *
     * Requirements:
     *
     * - input must fit into 96 bits
     */
    function toInt96(int256 value) internal pure returns (int96 downcasted) {
        downcasted = int96(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(96, value);
        }
    }

    /**
     * @dev Returns the downcasted int88 from int256, reverting on
     * overflow (when the input is less than smallest int88 or
     * greater than largest int88).
     *
     * Counterpart to Solidity's `int88` operator.
     *
     * Requirements:
     *
     * - input must fit into 88 bits
     */
    function toInt88(int256 value) internal pure returns (int88 downcasted) {
        downcasted = int88(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(88, value);
        }
    }

    /**
     * @dev Returns the downcasted int80 from int256, reverting on
     * overflow (when the input is less than smallest int80 or
     * greater than largest int80).
     *
     * Counterpart to Solidity's `int80` operator.
     *
     * Requirements:
     *
     * - input must fit into 80 bits
     */
    function toInt80(int256 value) internal pure returns (int80 downcasted) {
        downcasted = int80(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(80, value);
        }
    }

    /**
     * @dev Returns the downcasted int72 from int256, reverting on
     * overflow (when the input is less than smallest int72 or
     * greater than largest int72).
     *
     * Counterpart to Solidity's `int72` operator.
     *
     * Requirements:
     *
     * - input must fit into 72 bits
     */
    function toInt72(int256 value) internal pure returns (int72 downcasted) {
        downcasted = int72(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(72, value);
        }
    }

    /**
     * @dev Returns the downcasted int64 from int256, reverting on
     * overflow (when the input is less than smallest int64 or
     * greater than largest int64).
     *
     * Counterpart to Solidity's `int64` operator.
     *
     * Requirements:
     *
     * - input must fit into 64 bits
     */
    function toInt64(int256 value) internal pure returns (int64 downcasted) {
        downcasted = int64(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(64, value);
        }
    }

    /**
     * @dev Returns the downcasted int56 from int256, reverting on
     * overflow (when the input is less than smallest int56 or
     * greater than largest int56).
     *
     * Counterpart to Solidity's `int56` operator.
     *
     * Requirements:
     *
     * - input must fit into 56 bits
     */
    function toInt56(int256 value) internal pure returns (int56 downcasted) {
        downcasted = int56(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(56, value);
        }
    }

    /**
     * @dev Returns the downcasted int48 from int256, reverting on
     * overflow (when the input is less than smallest int48 or
     * greater than largest int48).
     *
     * Counterpart to Solidity's `int48` operator.
     *
     * Requirements:
     *
     * - input must fit into 48 bits
     */
    function toInt48(int256 value) internal pure returns (int48 downcasted) {
        downcasted = int48(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(48, value);
        }
    }

    /**
     * @dev Returns the downcasted int40 from int256, reverting on
     * overflow (when the input is less than smallest int40 or
     * greater than largest int40).
     *
     * Counterpart to Solidity's `int40` operator.
     *
     * Requirements:
     *
     * - input must fit into 40 bits
     */
    function toInt40(int256 value) internal pure returns (int40 downcasted) {
        downcasted = int40(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(40, value);
        }
    }

    /**
     * @dev Returns the downcasted int32 from int256, reverting on
     * overflow (when the input is less than smallest int32 or
     * greater than largest int32).
     *
     * Counterpart to Solidity's `int32` operator.
     *
     * Requirements:
     *
     * - input must fit into 32 bits
     */
    function toInt32(int256 value) internal pure returns (int32 downcasted) {
        downcasted = int32(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(32, value);
        }
    }

    /**
     * @dev Returns the downcasted int24 from int256, reverting on
     * overflow (when the input is less than smallest int24 or
     * greater than largest int24).
     *
     * Counterpart to Solidity's `int24` operator.
     *
     * Requirements:
     *
     * - input must fit into 24 bits
     */
    function toInt24(int256 value) internal pure returns (int24 downcasted) {
        downcasted = int24(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(24, value);
        }
    }

    /**
     * @dev Returns the downcasted int16 from int256, reverting on
     * overflow (when the input is less than smallest int16 or
     * greater than largest int16).
     *
     * Counterpart to Solidity's `int16` operator.
     *
     * Requirements:
     *
     * - input must fit into 16 bits
     */
    function toInt16(int256 value) internal pure returns (int16 downcasted) {
        downcasted = int16(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(16, value);
        }
    }

    /**
     * @dev Returns the downcasted int8 from int256, reverting on
     * overflow (when the input is less than smallest int8 or
     * greater than largest int8).
     *
     * Counterpart to Solidity's `int8` operator.
     *
     * Requirements:
     *
     * - input must fit into 8 bits
     */
    function toInt8(int256 value) internal pure returns (int8 downcasted) {
        downcasted = int8(value);
        if (downcasted != value) {
            revert SafeCastOverflowedIntDowncast(8, value);
        }
    }

    /**
     * @dev Converts an unsigned uint256 into a signed int256.
     *
     * Requirements:
     *
     * - input must be less than or equal to maxInt256.
     */
    function toInt256(uint256 value) internal pure returns (int256) {
        // Note: Unsafe cast below is okay because `type(int256).max` is guaranteed to be positive
        if (value > uint256(type(int256).max)) {
            revert SafeCastOverflowedUintToInt(value);
        }
        return int256(value);
    }

    /**
     * @dev Cast a boolean (false or true) to a uint256 (0 or 1) with no jump.
     */
    function toUint(bool b) internal pure returns (uint256 u) {
        assembly ("memory-safe") {
            u := iszero(iszero(b))
        }
    }
}

// File: @openzeppelin/contracts/utils/math/Math.sol

// OpenZeppelin Contracts (last updated v5.3.0) (utils/math/Math.sol)

pragma solidity ^0.8.20;

/**
 * @dev Standard math utilities missing in the Solidity language.
 */
library Math {
    enum Rounding {
        Floor, // Toward negative infinity
        Ceil, // Toward positive infinity
        Trunc, // Toward zero
        Expand // Away from zero
    }

    /**
     * @dev Return the 512-bit addition of two uint256.
     *
     * The result is stored in two 256 variables such that sum = high * 2²⁵⁶ + low.
     */
    function add512(
        uint256 a,
        uint256 b
    ) internal pure returns (uint256 high, uint256 low) {
        assembly ("memory-safe") {
            low := add(a, b)
            high := lt(low, a)
        }
    }

    /**
     * @dev Return the 512-bit multiplication of two uint256.
     *
     * The result is stored in two 256 variables such that product = high * 2²⁵⁶ + low.
     */
    function mul512(
        uint256 a,
        uint256 b
    ) internal pure returns (uint256 high, uint256 low) {
        // 512-bit multiply [high low] = x * y. Compute the product mod 2²⁵⁶ and mod 2²⁵⁶ - 1, then use
        // the Chinese Remainder Theorem to reconstruct the 512 bit result. The result is stored in two 256
        // variables such that product = high * 2²⁵⁶ + low.
        assembly ("memory-safe") {
            let mm := mulmod(a, b, not(0))
            low := mul(a, b)
            high := sub(sub(mm, low), lt(mm, low))
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, with a success flag (no overflow).
     */
    function tryAdd(
        uint256 a,
        uint256 b
    ) internal pure returns (bool success, uint256 result) {
        unchecked {
            uint256 c = a + b;
            success = c >= a;
            result = c * SafeCast.toUint(success);
        }
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, with a success flag (no overflow).
     */
    function trySub(
        uint256 a,
        uint256 b
    ) internal pure returns (bool success, uint256 result) {
        unchecked {
            uint256 c = a - b;
            success = c <= a;
            result = c * SafeCast.toUint(success);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with a success flag (no overflow).
     */
    function tryMul(
        uint256 a,
        uint256 b
    ) internal pure returns (bool success, uint256 result) {
        unchecked {
            uint256 c = a * b;
            assembly ("memory-safe") {
                // Only true when the multiplication doesn't overflow
                // (c / a == b) || (a == 0)
                success := or(eq(div(c, a), b), iszero(a))
            }
            // equivalent to: success ? c : 0
            result = c * SafeCast.toUint(success);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a success flag (no division by zero).
     */
    function tryDiv(
        uint256 a,
        uint256 b
    ) internal pure returns (bool success, uint256 result) {
        unchecked {
            success = b > 0;
            assembly ("memory-safe") {
                // The `DIV` opcode returns zero when the denominator is 0.
                result := div(a, b)
            }
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a success flag (no division by zero).
     */
    function tryMod(
        uint256 a,
        uint256 b
    ) internal pure returns (bool success, uint256 result) {
        unchecked {
            success = b > 0;
            assembly ("memory-safe") {
                // The `MOD` opcode returns zero when the denominator is 0.
                result := mod(a, b)
            }
        }
    }

    /**
     * @dev Unsigned saturating addition, bounds to `2²⁵⁶ - 1` instead of overflowing.
     */
    function saturatingAdd(
        uint256 a,
        uint256 b
    ) internal pure returns (uint256) {
        (bool success, uint256 result) = tryAdd(a, b);
        return ternary(success, result, type(uint256).max);
    }

    /**
     * @dev Unsigned saturating subtraction, bounds to zero instead of overflowing.
     */
    function saturatingSub(
        uint256 a,
        uint256 b
    ) internal pure returns (uint256) {
        (, uint256 result) = trySub(a, b);
        return result;
    }

    /**
     * @dev Unsigned saturating multiplication, bounds to `2²⁵⁶ - 1` instead of overflowing.
     */
    function saturatingMul(
        uint256 a,
        uint256 b
    ) internal pure returns (uint256) {
        (bool success, uint256 result) = tryMul(a, b);
        return ternary(success, result, type(uint256).max);
    }

    /**
     * @dev Branchless ternary evaluation for `a ? b : c`. Gas costs are constant.
     *
     * IMPORTANT: This function may reduce bytecode size and consume less gas when used standalone.
     * However, the compiler may optimize Solidity ternary operations (i.e. `a ? b : c`) to only compute
     * one branch when needed, making this function more expensive.
     */
    function ternary(
        bool condition,
        uint256 a,
        uint256 b
    ) internal pure returns (uint256) {
        unchecked {
            // branchless ternary works because:
            // b ^ (a ^ b) == a
            // b ^ 0 == b
            return b ^ ((a ^ b) * SafeCast.toUint(condition));
        }
    }

    /**
     * @dev Returns the largest of two numbers.
     */
    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return ternary(a > b, a, b);
    }

    /**
     * @dev Returns the smallest of two numbers.
     */
    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        return ternary(a < b, a, b);
    }

    /**
     * @dev Returns the average of two numbers. The result is rounded towards
     * zero.
     */
    function average(uint256 a, uint256 b) internal pure returns (uint256) {
        // (a + b) / 2 can overflow.
        return (a & b) + (a ^ b) / 2;
    }

    /**
     * @dev Returns the ceiling of the division of two numbers.
     *
     * This differs from standard division with `/` in that it rounds towards infinity instead
     * of rounding towards zero.
     */
    function ceilDiv(uint256 a, uint256 b) internal pure returns (uint256) {
        if (b == 0) {
            // Guarantee the same behavior as in a regular Solidity division.
            Panic.panic(Panic.DIVISION_BY_ZERO);
        }

        // The following calculation ensures accurate ceiling division without overflow.
        // Since a is non-zero, (a - 1) / b will not overflow.
        // The largest possible result occurs when (a - 1) / b is type(uint256).max,
        // but the largest value we can obtain is type(uint256).max - 1, which happens
        // when a = type(uint256).max and b = 1.
        unchecked {
            return SafeCast.toUint(a > 0) * ((a - 1) / b + 1);
        }
    }

    /**
     * @dev Calculates floor(x * y / denominator) with full precision. Throws if result overflows a uint256 or
     * denominator == 0.
     *
     * Original credit to Remco Bloemen under MIT license (https://xn--2-umb.com/21/muldiv) with further edits by
     * Uniswap Labs also under MIT license.
     */
    function mulDiv(
        uint256 x,
        uint256 y,
        uint256 denominator
    ) internal pure returns (uint256 result) {
        unchecked {
            (uint256 high, uint256 low) = mul512(x, y);

            // Handle non-overflow cases, 256 by 256 division.
            if (high == 0) {
                // Solidity will revert if denominator == 0, unlike the div opcode on its own.
                // The surrounding unchecked block does not change this fact.
                // See https://docs.soliditylang.org/en/latest/control-structures.html#checked-or-unchecked-arithmetic.
                return low / denominator;
            }

            // Make sure the result is less than 2²⁵⁶. Also prevents denominator == 0.
            if (denominator <= high) {
                Panic.panic(
                    ternary(
                        denominator == 0,
                        Panic.DIVISION_BY_ZERO,
                        Panic.UNDER_OVERFLOW
                    )
                );
            }

            ///////////////////////////////////////////////
            // 512 by 256 division.
            ///////////////////////////////////////////////

            // Make division exact by subtracting the remainder from [high low].
            uint256 remainder;
            assembly ("memory-safe") {
                // Compute remainder using mulmod.
                remainder := mulmod(x, y, denominator)

                // Subtract 256 bit number from 512 bit number.
                high := sub(high, gt(remainder, low))
                low := sub(low, remainder)
            }

            // Factor powers of two out of denominator and compute largest power of two divisor of denominator.
            // Always >= 1. See https://cs.stackexchange.com/q/138556/92363.

            uint256 twos = denominator & (0 - denominator);
            assembly ("memory-safe") {
                // Divide denominator by twos.
                denominator := div(denominator, twos)

                // Divide [high low] by twos.
                low := div(low, twos)

                // Flip twos such that it is 2²⁵⁶ / twos. If twos is zero, then it becomes one.
                twos := add(div(sub(0, twos), twos), 1)
            }

            // Shift in bits from high into low.
            low |= high * twos;

            // Invert denominator mod 2²⁵⁶. Now that denominator is an odd number, it has an inverse modulo 2²⁵⁶ such
            // that denominator * inv ≡ 1 mod 2²⁵⁶. Compute the inverse by starting with a seed that is correct for
            // four bits. That is, denominator * inv ≡ 1 mod 2⁴.
            uint256 inverse = (3 * denominator) ^ 2;

            // Use the Newton-Raphson iteration to improve the precision. Thanks to Hensel's lifting lemma, this also
            // works in modular arithmetic, doubling the correct bits in each step.
            inverse *= 2 - denominator * inverse; // inverse mod 2⁸
            inverse *= 2 - denominator * inverse; // inverse mod 2¹⁶
            inverse *= 2 - denominator * inverse; // inverse mod 2³²
            inverse *= 2 - denominator * inverse; // inverse mod 2⁶⁴
            inverse *= 2 - denominator * inverse; // inverse mod 2¹²⁸
            inverse *= 2 - denominator * inverse; // inverse mod 2²⁵⁶

            // Because the division is now exact we can divide by multiplying with the modular inverse of denominator.
            // This will give us the correct result modulo 2²⁵⁶. Since the preconditions guarantee that the outcome is
            // less than 2²⁵⁶, this is the final result. We don't need to compute the high bits of the result and high
            // is no longer required.
            result = low * inverse;
            return result;
        }
    }

    /**
     * @dev Calculates x * y / denominator with full precision, following the selected rounding direction.
     */
    function mulDiv(
        uint256 x,
        uint256 y,
        uint256 denominator,
        Rounding rounding
    ) internal pure returns (uint256) {
        return
            mulDiv(x, y, denominator) +
            SafeCast.toUint(
                unsignedRoundsUp(rounding) && mulmod(x, y, denominator) > 0
            );
    }

    /**
     * @dev Calculates floor(x * y >> n) with full precision. Throws if result overflows a uint256.
     */
    function mulShr(
        uint256 x,
        uint256 y,
        uint8 n
    ) internal pure returns (uint256 result) {
        unchecked {
            (uint256 high, uint256 low) = mul512(x, y);
            if (high >= 1 << n) {
                Panic.panic(Panic.UNDER_OVERFLOW);
            }
            return (high << (256 - n)) | (low >> n);
        }
    }

    /**
     * @dev Calculates x * y >> n with full precision, following the selected rounding direction.
     */
    function mulShr(
        uint256 x,
        uint256 y,
        uint8 n,
        Rounding rounding
    ) internal pure returns (uint256) {
        return
            mulShr(x, y, n) +
            SafeCast.toUint(
                unsignedRoundsUp(rounding) && mulmod(x, y, 1 << n) > 0
            );
    }

    /**
     * @dev Calculate the modular multiplicative inverse of a number in Z/nZ.
     *
     * If n is a prime, then Z/nZ is a field. In that case all elements are inversible, except 0.
     * If n is not a prime, then Z/nZ is not a field, and some elements might not be inversible.
     *
     * If the input value is not inversible, 0 is returned.
     *
     * NOTE: If you know for sure that n is (big) a prime, it may be cheaper to use Fermat's little theorem and get the
     * inverse using `Math.modExp(a, n - 2, n)`. See {invModPrime}.
     */
    function invMod(uint256 a, uint256 n) internal pure returns (uint256) {
        unchecked {
            if (n == 0) return 0;

            // The inverse modulo is calculated using the Extended Euclidean Algorithm (iterative version)
            // Used to compute integers x and y such that: ax + ny = gcd(a, n).
            // When the gcd is 1, then the inverse of a modulo n exists and it's x.
            // ax + ny = 1
            // ax = 1 + (-y)n
            // ax ≡ 1 (mod n) # x is the inverse of a modulo n

            // If the remainder is 0 the gcd is n right away.
            uint256 remainder = a % n;
            uint256 gcd = n;

            // Therefore the initial coefficients are:
            // ax + ny = gcd(a, n) = n
            // 0a + 1n = n
            int256 x = 0;
            int256 y = 1;

            while (remainder != 0) {
                uint256 quotient = gcd / remainder;

                (gcd, remainder) = (
                    // The old remainder is the next gcd to try.
                    remainder,
                    // Compute the next remainder.
                    // Can't overflow given that (a % gcd) * (gcd // (a % gcd)) <= gcd
                    // where gcd is at most n (capped to type(uint256).max)
                    gcd - remainder * quotient
                );

                (x, y) = (
                    // Increment the coefficient of a.
                    y,
                    // Decrement the coefficient of n.
                    // Can overflow, but the result is casted to uint256 so that the
                    // next value of y is "wrapped around" to a value between 0 and n - 1.
                    x - y * int256(quotient)
                );
            }

            if (gcd != 1) return 0; // No inverse exists.
            return ternary(x < 0, n - uint256(-x), uint256(x)); // Wrap the result if it's negative.
        }
    }

    /**
     * @dev Variant of {invMod}. More efficient, but only works if `p` is known to be a prime greater than `2`.
     *
     * From https://en.wikipedia.org/wiki/Fermat%27s_little_theorem[Fermat's little theorem], we know that if p is
     * prime, then `a**(p-1) ≡ 1 mod p`. As a consequence, we have `a * a**(p-2) ≡ 1 mod p`, which means that
     * `a**(p-2)` is the modular multiplicative inverse of a in Fp.
     *
     * NOTE: this function does NOT check that `p` is a prime greater than `2`.
     */
    function invModPrime(uint256 a, uint256 p) internal view returns (uint256) {
        unchecked {
            return Math.modExp(a, p - 2, p);
        }
    }

    /**
     * @dev Returns the modular exponentiation of the specified base, exponent and modulus (b ** e % m)
     *
     * Requirements:
     * - modulus can't be zero
     * - underlying staticcall to precompile must succeed
     *
     * IMPORTANT: The result is only valid if the underlying call succeeds. When using this function, make
     * sure the chain you're using it on supports the precompiled contract for modular exponentiation
     * at address 0x05 as specified in https://eips.ethereum.org/EIPS/eip-198[EIP-198]. Otherwise,
     * the underlying function will succeed given the lack of a revert, but the result may be incorrectly
     * interpreted as 0.
     */
    function modExp(
        uint256 b,
        uint256 e,
        uint256 m
    ) internal view returns (uint256) {
        (bool success, uint256 result) = tryModExp(b, e, m);
        if (!success) {
            Panic.panic(Panic.DIVISION_BY_ZERO);
        }
        return result;
    }

    /**
     * @dev Returns the modular exponentiation of the specified base, exponent and modulus (b ** e % m).
     * It includes a success flag indicating if the operation succeeded. Operation will be marked as failed if trying
     * to operate modulo 0 or if the underlying precompile reverted.
     *
     * IMPORTANT: The result is only valid if the success flag is true. When using this function, make sure the chain
     * you're using it on supports the precompiled contract for modular exponentiation at address 0x05 as specified in
     * https://eips.ethereum.org/EIPS/eip-198[EIP-198]. Otherwise, the underlying function will succeed given the lack
     * of a revert, but the result may be incorrectly interpreted as 0.
     */
    function tryModExp(
        uint256 b,
        uint256 e,
        uint256 m
    ) internal view returns (bool success, uint256 result) {
        if (m == 0) return (false, 0);
        assembly ("memory-safe") {
            let ptr := mload(0x40)
            // | Offset    | Content    | Content (Hex)                                                      |
            // |-----------|------------|--------------------------------------------------------------------|
            // | 0x00:0x1f | size of b  | 0x0000000000000000000000000000000000000000000000000000000000000020 |
            // | 0x20:0x3f | size of e  | 0x0000000000000000000000000000000000000000000000000000000000000020 |
            // | 0x40:0x5f | size of m  | 0x0000000000000000000000000000000000000000000000000000000000000020 |
            // | 0x60:0x7f | value of b | 0x<.............................................................b> |
            // | 0x80:0x9f | value of e | 0x<.............................................................e> |
            // | 0xa0:0xbf | value of m | 0x<.............................................................m> |
            mstore(ptr, 0x20)
            mstore(add(ptr, 0x20), 0x20)
            mstore(add(ptr, 0x40), 0x20)
            mstore(add(ptr, 0x60), b)
            mstore(add(ptr, 0x80), e)
            mstore(add(ptr, 0xa0), m)

            // Given the result < m, it's guaranteed to fit in 32 bytes,
            // so we can use the memory scratch space located at offset 0.
            success := staticcall(gas(), 0x05, ptr, 0xc0, 0x00, 0x20)
            result := mload(0x00)
        }
    }

    /**
     * @dev Variant of {modExp} that supports inputs of arbitrary length.
     */
    function modExp(
        bytes memory b,
        bytes memory e,
        bytes memory m
    ) internal view returns (bytes memory) {
        (bool success, bytes memory result) = tryModExp(b, e, m);
        if (!success) {
            Panic.panic(Panic.DIVISION_BY_ZERO);
        }
        return result;
    }

    /**
     * @dev Variant of {tryModExp} that supports inputs of arbitrary length.
     */
    function tryModExp(
        bytes memory b,
        bytes memory e,
        bytes memory m
    ) internal view returns (bool success, bytes memory result) {
        if (_zeroBytes(m)) return (false, new bytes(0));

        uint256 mLen = m.length;

        // Encode call args in result and move the free memory pointer
        result = abi.encodePacked(b.length, e.length, mLen, b, e, m);

        assembly ("memory-safe") {
            let dataPtr := add(result, 0x20)
            // Write result on top of args to avoid allocating extra memory.
            success := staticcall(
                gas(),
                0x05,
                dataPtr,
                mload(result),
                dataPtr,
                mLen
            )
            // Overwrite the length.
            // result.length > returndatasize() is guaranteed because returndatasize() == m.length
            mstore(result, mLen)
            // Set the memory pointer after the returned data.
            mstore(0x40, add(dataPtr, mLen))
        }
    }

    /**
     * @dev Returns whether the provided byte array is zero.
     */
    function _zeroBytes(bytes memory byteArray) private pure returns (bool) {
        for (uint256 i = 0; i < byteArray.length; ++i) {
            if (byteArray[i] != 0) {
                return false;
            }
        }
        return true;
    }

    /**
     * @dev Returns the square root of a number. If the number is not a perfect square, the value is rounded
     * towards zero.
     *
     * This method is based on Newton's method for computing square roots; the algorithm is restricted to only
     * using integer operations.
     */
    function sqrt(uint256 a) internal pure returns (uint256) {
        unchecked {
            // Take care of easy edge cases when a == 0 or a == 1
            if (a <= 1) {
                return a;
            }

            // In this function, we use Newton's method to get a root of `f(x) := x² - a`. It involves building a
            // sequence x_n that converges toward sqrt(a). For each iteration x_n, we also define the error between
            // the current value as `ε_n = | x_n - sqrt(a) |`.
            //
            // For our first estimation, we consider `e` the smallest power of 2 which is bigger than the square root
            // of the target. (i.e. `2**(e-1) ≤ sqrt(a) < 2**e`). We know that `e ≤ 128` because `(2¹²⁸)² = 2²⁵⁶` is
            // bigger than any uint256.
            //
            // By noticing that
            // `2**(e-1) ≤ sqrt(a) < 2**e → (2**(e-1))² ≤ a < (2**e)² → 2**(2*e-2) ≤ a < 2**(2*e)`
            // we can deduce that `e - 1` is `log2(a) / 2`. We can thus compute `x_n = 2**(e-1)` using a method similar
            // to the msb function.
            uint256 aa = a;
            uint256 xn = 1;

            if (aa >= (1 << 128)) {
                aa >>= 128;
                xn <<= 64;
            }
            if (aa >= (1 << 64)) {
                aa >>= 64;
                xn <<= 32;
            }
            if (aa >= (1 << 32)) {
                aa >>= 32;
                xn <<= 16;
            }
            if (aa >= (1 << 16)) {
                aa >>= 16;
                xn <<= 8;
            }
            if (aa >= (1 << 8)) {
                aa >>= 8;
                xn <<= 4;
            }
            if (aa >= (1 << 4)) {
                aa >>= 4;
                xn <<= 2;
            }
            if (aa >= (1 << 2)) {
                xn <<= 1;
            }

            // We now have x_n such that `x_n = 2**(e-1) ≤ sqrt(a) < 2**e = 2 * x_n`. This implies ε_n ≤ 2**(e-1).
            //
            // We can refine our estimation by noticing that the middle of that interval minimizes the error.
            // If we move x_n to equal 2**(e-1) + 2**(e-2), then we reduce the error to ε_n ≤ 2**(e-2).
            // This is going to be our x_0 (and ε_0)
            xn = (3 * xn) >> 1; // ε_0 := | x_0 - sqrt(a) | ≤ 2**(e-2)

            // From here, Newton's method give us:
            // x_{n+1} = (x_n + a / x_n) / 2
            //
            // One should note that:
            // x_{n+1}² - a = ((x_n + a / x_n) / 2)² - a
            //              = ((x_n² + a) / (2 * x_n))² - a
            //              = (x_n⁴ + 2 * a * x_n² + a²) / (4 * x_n²) - a
            //              = (x_n⁴ + 2 * a * x_n² + a² - 4 * a * x_n²) / (4 * x_n²)
            //              = (x_n⁴ - 2 * a * x_n² + a²) / (4 * x_n²)
            //              = (x_n² - a)² / (2 * x_n)²
            //              = ((x_n² - a) / (2 * x_n))²
            //              ≥ 0
            // Which proves that for all n ≥ 1, sqrt(a) ≤ x_n
            //
            // This gives us the proof of quadratic convergence of the sequence:
            // ε_{n+1} = | x_{n+1} - sqrt(a) |
            //         = | (x_n + a / x_n) / 2 - sqrt(a) |
            //         = | (x_n² + a - 2*x_n*sqrt(a)) / (2 * x_n) |
            //         = | (x_n - sqrt(a))² / (2 * x_n) |
            //         = | ε_n² / (2 * x_n) |
            //         = ε_n² / | (2 * x_n) |
            //
            // For the first iteration, we have a special case where x_0 is known:
            // ε_1 = ε_0² / | (2 * x_0) |
            //     ≤ (2**(e-2))² / (2 * (2**(e-1) + 2**(e-2)))
            //     ≤ 2**(2*e-4) / (3 * 2**(e-1))
            //     ≤ 2**(e-3) / 3
            //     ≤ 2**(e-3-log2(3))
            //     ≤ 2**(e-4.5)
            //
            // For the following iterations, we use the fact that, 2**(e-1) ≤ sqrt(a) ≤ x_n:
            // ε_{n+1} = ε_n² / | (2 * x_n) |
            //         ≤ (2**(e-k))² / (2 * 2**(e-1))
            //         ≤ 2**(2*e-2*k) / 2**e
            //         ≤ 2**(e-2*k)
            xn = (xn + a / xn) >> 1; // ε_1 := | x_1 - sqrt(a) | ≤ 2**(e-4.5)  -- special case, see above
            xn = (xn + a / xn) >> 1; // ε_2 := | x_2 - sqrt(a) | ≤ 2**(e-9)    -- general case with k = 4.5
            xn = (xn + a / xn) >> 1; // ε_3 := | x_3 - sqrt(a) | ≤ 2**(e-18)   -- general case with k = 9
            xn = (xn + a / xn) >> 1; // ε_4 := | x_4 - sqrt(a) | ≤ 2**(e-36)   -- general case with k = 18
            xn = (xn + a / xn) >> 1; // ε_5 := | x_5 - sqrt(a) | ≤ 2**(e-72)   -- general case with k = 36
            xn = (xn + a / xn) >> 1; // ε_6 := | x_6 - sqrt(a) | ≤ 2**(e-144)  -- general case with k = 72

            // Because e ≤ 128 (as discussed during the first estimation phase), we know have reached a precision
            // ε_6 ≤ 2**(e-144) < 1. Given we're operating on integers, then we can ensure that xn is now either
            // sqrt(a) or sqrt(a) + 1.
            return xn - SafeCast.toUint(xn > a / xn);
        }
    }

    /**
     * @dev Calculates sqrt(a), following the selected rounding direction.
     */
    function sqrt(
        uint256 a,
        Rounding rounding
    ) internal pure returns (uint256) {
        unchecked {
            uint256 result = sqrt(a);
            return
                result +
                SafeCast.toUint(
                    unsignedRoundsUp(rounding) && result * result < a
                );
        }
    }

    /**
     * @dev Return the log in base 2 of a positive value rounded towards zero.
     * Returns 0 if given 0.
     */
    function log2(uint256 x) internal pure returns (uint256 r) {
        // If value has upper 128 bits set, log2 result is at least 128
        r = SafeCast.toUint(x > 0xffffffffffffffffffffffffffffffff) << 7;
        // If upper 64 bits of 128-bit half set, add 64 to result
        r |= SafeCast.toUint((x >> r) > 0xffffffffffffffff) << 6;
        // If upper 32 bits of 64-bit half set, add 32 to result
        r |= SafeCast.toUint((x >> r) > 0xffffffff) << 5;
        // If upper 16 bits of 32-bit half set, add 16 to result
        r |= SafeCast.toUint((x >> r) > 0xffff) << 4;
        // If upper 8 bits of 16-bit half set, add 8 to result
        r |= SafeCast.toUint((x >> r) > 0xff) << 3;
        // If upper 4 bits of 8-bit half set, add 4 to result
        r |= SafeCast.toUint((x >> r) > 0xf) << 2;

        // Shifts value right by the current result and use it as an index into this lookup table:
        //
        // | x (4 bits) |  index  | table[index] = MSB position |
        // |------------|---------|-----------------------------|
        // |    0000    |    0    |        table[0] = 0         |
        // |    0001    |    1    |        table[1] = 0         |
        // |    0010    |    2    |        table[2] = 1         |
        // |    0011    |    3    |        table[3] = 1         |
        // |    0100    |    4    |        table[4] = 2         |
        // |    0101    |    5    |        table[5] = 2         |
        // |    0110    |    6    |        table[6] = 2         |
        // |    0111    |    7    |        table[7] = 2         |
        // |    1000    |    8    |        table[8] = 3         |
        // |    1001    |    9    |        table[9] = 3         |
        // |    1010    |   10    |        table[10] = 3        |
        // |    1011    |   11    |        table[11] = 3        |
        // |    1100    |   12    |        table[12] = 3        |
        // |    1101    |   13    |        table[13] = 3        |
        // |    1110    |   14    |        table[14] = 3        |
        // |    1111    |   15    |        table[15] = 3        |
        //
        // The lookup table is represented as a 32-byte value with the MSB positions for 0-15 in the last 16 bytes.
        assembly ("memory-safe") {
            r := or(
                r,
                byte(
                    shr(r, x),
                    0x0000010102020202030303030303030300000000000000000000000000000000
                )
            )
        }
    }

    /**
     * @dev Return the log in base 2, following the selected rounding direction, of a positive value.
     * Returns 0 if given 0.
     */
    function log2(
        uint256 value,
        Rounding rounding
    ) internal pure returns (uint256) {
        unchecked {
            uint256 result = log2(value);
            return
                result +
                SafeCast.toUint(
                    unsignedRoundsUp(rounding) && 1 << result < value
                );
        }
    }

    /**
     * @dev Return the log in base 10 of a positive value rounded towards zero.
     * Returns 0 if given 0.
     */
    function log10(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >= 10 ** 64) {
                value /= 10 ** 64;
                result += 64;
            }
            if (value >= 10 ** 32) {
                value /= 10 ** 32;
                result += 32;
            }
            if (value >= 10 ** 16) {
                value /= 10 ** 16;
                result += 16;
            }
            if (value >= 10 ** 8) {
                value /= 10 ** 8;
                result += 8;
            }
            if (value >= 10 ** 4) {
                value /= 10 ** 4;
                result += 4;
            }
            if (value >= 10 ** 2) {
                value /= 10 ** 2;
                result += 2;
            }
            if (value >= 10 ** 1) {
                result += 1;
            }
        }
        return result;
    }

    /**
     * @dev Return the log in base 10, following the selected rounding direction, of a positive value.
     * Returns 0 if given 0.
     */
    function log10(
        uint256 value,
        Rounding rounding
    ) internal pure returns (uint256) {
        unchecked {
            uint256 result = log10(value);
            return
                result +
                SafeCast.toUint(
                    unsignedRoundsUp(rounding) && 10 ** result < value
                );
        }
    }

    /**
     * @dev Return the log in base 256 of a positive value rounded towards zero.
     * Returns 0 if given 0.
     *
     * Adding one to the result gives the number of pairs of hex symbols needed to represent `value` as a hex string.
     */
    function log256(uint256 x) internal pure returns (uint256 r) {
        // If value has upper 128 bits set, log2 result is at least 128
        r = SafeCast.toUint(x > 0xffffffffffffffffffffffffffffffff) << 7;
        // If upper 64 bits of 128-bit half set, add 64 to result
        r |= SafeCast.toUint((x >> r) > 0xffffffffffffffff) << 6;
        // If upper 32 bits of 64-bit half set, add 32 to result
        r |= SafeCast.toUint((x >> r) > 0xffffffff) << 5;
        // If upper 16 bits of 32-bit half set, add 16 to result
        r |= SafeCast.toUint((x >> r) > 0xffff) << 4;
        // Add 1 if upper 8 bits of 16-bit half set, and divide accumulated result by 8
        return (r >> 3) | SafeCast.toUint((x >> r) > 0xff);
    }

    /**
     * @dev Return the log in base 256, following the selected rounding direction, of a positive value.
     * Returns 0 if given 0.
     */
    function log256(
        uint256 value,
        Rounding rounding
    ) internal pure returns (uint256) {
        unchecked {
            uint256 result = log256(value);
            return
                result +
                SafeCast.toUint(
                    unsignedRoundsUp(rounding) && 1 << (result << 3) < value
                );
        }
    }

    /**
     * @dev Returns whether a provided rounding mode is considered rounding up for unsigned integers.
     */
    function unsignedRoundsUp(Rounding rounding) internal pure returns (bool) {
        return uint8(rounding) % 2 == 1;
    }
}

// File: @openzeppelin/contracts/utils/math/SignedMath.sol

// OpenZeppelin Contracts (last updated v5.1.0) (utils/math/SignedMath.sol)

pragma solidity ^0.8.20;

/**
 * @dev Standard signed math utilities missing in the Solidity language.
 */
library SignedMath {
    /**
     * @dev Branchless ternary evaluation for `a ? b : c`. Gas costs are constant.
     *
     * IMPORTANT: This function may reduce bytecode size and consume less gas when used standalone.
     * However, the compiler may optimize Solidity ternary operations (i.e. `a ? b : c`) to only compute
     * one branch when needed, making this function more expensive.
     */
    function ternary(
        bool condition,
        int256 a,
        int256 b
    ) internal pure returns (int256) {
        unchecked {
            // branchless ternary works because:
            // b ^ (a ^ b) == a
            // b ^ 0 == b
            return b ^ ((a ^ b) * int256(SafeCast.toUint(condition)));
        }
    }

    /**
     * @dev Returns the largest of two signed numbers.
     */
    function max(int256 a, int256 b) internal pure returns (int256) {
        return ternary(a > b, a, b);
    }

    /**
     * @dev Returns the smallest of two signed numbers.
     */
    function min(int256 a, int256 b) internal pure returns (int256) {
        return ternary(a < b, a, b);
    }

    /**
     * @dev Returns the average of two signed numbers without overflow.
     * The result is rounded towards zero.
     */
    function average(int256 a, int256 b) internal pure returns (int256) {
        // Formula from the book "Hacker's Delight"
        int256 x = (a & b) + ((a ^ b) >> 1);
        return x + (int256(uint256(x) >> 255) & (a ^ b));
    }

    /**
     * @dev Returns the absolute unsigned value of a signed value.
     */
    function abs(int256 n) internal pure returns (uint256) {
        unchecked {
            // Formula from the "Bit Twiddling Hacks" by Sean Eron Anderson.
            // Since `n` is a signed integer, the generated bytecode will use the SAR opcode to perform the right shift,
            // taking advantage of the most significant (or "sign" bit) in two's complement representation.
            // This opcode adds new most significant bits set to the value of the previous most significant bit. As a result,
            // the mask will either be `bytes32(0)` (if n is positive) or `~bytes32(0)` (if n is negative).
            int256 mask = n >> 255;

            // A `bytes32(0)` mask leaves the input unchanged, while a `~bytes32(0)` mask complements it.
            return uint256((n + mask) ^ mask);
        }
    }
}

// File: @openzeppelin/contracts/utils/Strings.sol

// OpenZeppelin Contracts (last updated v5.4.0) (utils/Strings.sol)

pragma solidity ^0.8.20;

/**
 * @dev String operations.
 */
library Strings {
    using SafeCast for *;

    bytes16 private constant HEX_DIGITS = "0123456789abcdef";
    uint8 private constant ADDRESS_LENGTH = 20;
    uint256 private constant SPECIAL_CHARS_LOOKUP =
        (1 << 0x08) | // backspace
            (1 << 0x09) | // tab
            (1 << 0x0a) | // newline
            (1 << 0x0c) | // form feed
            (1 << 0x0d) | // carriage return
            (1 << 0x22) | // double quote
            (1 << 0x5c); // backslash

    /**
     * @dev The `value` string doesn't fit in the specified `length`.
     */
    error StringsInsufficientHexLength(uint256 value, uint256 length);

    /**
     * @dev The string being parsed contains characters that are not in scope of the given base.
     */
    error StringsInvalidChar();

    /**
     * @dev The string being parsed is not a properly formatted address.
     */
    error StringsInvalidAddressFormat();

    /**
     * @dev Converts a `uint256` to its ASCII `string` decimal representation.
     */
    function toString(uint256 value) internal pure returns (string memory) {
        unchecked {
            uint256 length = Math.log10(value) + 1;
            string memory buffer = new string(length);
            uint256 ptr;
            assembly ("memory-safe") {
                ptr := add(add(buffer, 0x20), length)
            }
            while (true) {
                ptr--;
                assembly ("memory-safe") {
                    mstore8(ptr, byte(mod(value, 10), HEX_DIGITS))
                }
                value /= 10;
                if (value == 0) break;
            }
            return buffer;
        }
    }

    /**
     * @dev Converts a `int256` to its ASCII `string` decimal representation.
     */
    function toStringSigned(
        int256 value
    ) internal pure returns (string memory) {
        return
            string.concat(
                value < 0 ? "-" : "",
                toString(SignedMath.abs(value))
            );
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation.
     */
    function toHexString(uint256 value) internal pure returns (string memory) {
        unchecked {
            return toHexString(value, Math.log256(value) + 1);
        }
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation with fixed length.
     */
    function toHexString(
        uint256 value,
        uint256 length
    ) internal pure returns (string memory) {
        uint256 localValue = value;
        bytes memory buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1; i > 1; --i) {
            buffer[i] = HEX_DIGITS[localValue & 0xf];
            localValue >>= 4;
        }
        if (localValue != 0) {
            revert StringsInsufficientHexLength(value, length);
        }
        return string(buffer);
    }

    /**
     * @dev Converts an `address` with fixed length of 20 bytes to its not checksummed ASCII `string` hexadecimal
     * representation.
     */
    function toHexString(address addr) internal pure returns (string memory) {
        return toHexString(uint256(uint160(addr)), ADDRESS_LENGTH);
    }

    /**
     * @dev Converts an `address` with fixed length of 20 bytes to its checksummed ASCII `string` hexadecimal
     * representation, according to EIP-55.
     */
    function toChecksumHexString(
        address addr
    ) internal pure returns (string memory) {
        bytes memory buffer = bytes(toHexString(addr));

        // hash the hex part of buffer (skip length + 2 bytes, length 40)
        uint256 hashValue;
        assembly ("memory-safe") {
            hashValue := shr(96, keccak256(add(buffer, 0x22), 40))
        }

        for (uint256 i = 41; i > 1; --i) {
            // possible values for buffer[i] are 48 (0) to 57 (9) and 97 (a) to 102 (f)
            if (hashValue & 0xf > 7 && uint8(buffer[i]) > 96) {
                // case shift by xoring with 0x20
                buffer[i] ^= 0x20;
            }
            hashValue >>= 4;
        }
        return string(buffer);
    }

    /**
     * @dev Returns true if the two strings are equal.
     */
    function equal(
        string memory a,
        string memory b
    ) internal pure returns (bool) {
        return
            bytes(a).length == bytes(b).length &&
            keccak256(bytes(a)) == keccak256(bytes(b));
    }

    /**
     * @dev Parse a decimal string and returns the value as a `uint256`.
     *
     * Requirements:
     * - The string must be formatted as `[0-9]*`
     * - The result must fit into an `uint256` type
     */
    function parseUint(string memory input) internal pure returns (uint256) {
        return parseUint(input, 0, bytes(input).length);
    }

    /**
     * @dev Variant of {parseUint-string} that parses a substring of `input` located between position `begin` (included) and
     * `end` (excluded).
     *
     * Requirements:
     * - The substring must be formatted as `[0-9]*`
     * - The result must fit into an `uint256` type
     */
    function parseUint(
        string memory input,
        uint256 begin,
        uint256 end
    ) internal pure returns (uint256) {
        (bool success, uint256 value) = tryParseUint(input, begin, end);
        if (!success) revert StringsInvalidChar();
        return value;
    }

    /**
     * @dev Variant of {parseUint-string} that returns false if the parsing fails because of an invalid character.
     *
     * NOTE: This function will revert if the result does not fit in a `uint256`.
     */
    function tryParseUint(
        string memory input
    ) internal pure returns (bool success, uint256 value) {
        return _tryParseUintUncheckedBounds(input, 0, bytes(input).length);
    }

    /**
     * @dev Variant of {parseUint-string-uint256-uint256} that returns false if the parsing fails because of an invalid
     * character.
     *
     * NOTE: This function will revert if the result does not fit in a `uint256`.
     */
    function tryParseUint(
        string memory input,
        uint256 begin,
        uint256 end
    ) internal pure returns (bool success, uint256 value) {
        if (end > bytes(input).length || begin > end) return (false, 0);
        return _tryParseUintUncheckedBounds(input, begin, end);
    }

    /**
     * @dev Implementation of {tryParseUint-string-uint256-uint256} that does not check bounds. Caller should make sure that
     * `begin <= end <= input.length`. Other inputs would result in undefined behavior.
     */
    function _tryParseUintUncheckedBounds(
        string memory input,
        uint256 begin,
        uint256 end
    ) private pure returns (bool success, uint256 value) {
        bytes memory buffer = bytes(input);

        uint256 result = 0;
        for (uint256 i = begin; i < end; ++i) {
            uint8 chr = _tryParseChr(bytes1(_unsafeReadBytesOffset(buffer, i)));
            if (chr > 9) return (false, 0);
            result *= 10;
            result += chr;
        }
        return (true, result);
    }

    /**
     * @dev Parse a decimal string and returns the value as a `int256`.
     *
     * Requirements:
     * - The string must be formatted as `[-+]?[0-9]*`
     * - The result must fit in an `int256` type.
     */
    function parseInt(string memory input) internal pure returns (int256) {
        return parseInt(input, 0, bytes(input).length);
    }

    /**
     * @dev Variant of {parseInt-string} that parses a substring of `input` located between position `begin` (included) and
     * `end` (excluded).
     *
     * Requirements:
     * - The substring must be formatted as `[-+]?[0-9]*`
     * - The result must fit in an `int256` type.
     */
    function parseInt(
        string memory input,
        uint256 begin,
        uint256 end
    ) internal pure returns (int256) {
        (bool success, int256 value) = tryParseInt(input, begin, end);
        if (!success) revert StringsInvalidChar();
        return value;
    }

    /**
     * @dev Variant of {parseInt-string} that returns false if the parsing fails because of an invalid character or if
     * the result does not fit in a `int256`.
     *
     * NOTE: This function will revert if the absolute value of the result does not fit in a `uint256`.
     */
    function tryParseInt(
        string memory input
    ) internal pure returns (bool success, int256 value) {
        return _tryParseIntUncheckedBounds(input, 0, bytes(input).length);
    }

    uint256 private constant ABS_MIN_INT256 = 2 ** 255;

    /**
     * @dev Variant of {parseInt-string-uint256-uint256} that returns false if the parsing fails because of an invalid
     * character or if the result does not fit in a `int256`.
     *
     * NOTE: This function will revert if the absolute value of the result does not fit in a `uint256`.
     */
    function tryParseInt(
        string memory input,
        uint256 begin,
        uint256 end
    ) internal pure returns (bool success, int256 value) {
        if (end > bytes(input).length || begin > end) return (false, 0);
        return _tryParseIntUncheckedBounds(input, begin, end);
    }

    /**
     * @dev Implementation of {tryParseInt-string-uint256-uint256} that does not check bounds. Caller should make sure that
     * `begin <= end <= input.length`. Other inputs would result in undefined behavior.
     */
    function _tryParseIntUncheckedBounds(
        string memory input,
        uint256 begin,
        uint256 end
    ) private pure returns (bool success, int256 value) {
        bytes memory buffer = bytes(input);

        // Check presence of a negative sign.
        bytes1 sign = begin == end
            ? bytes1(0)
            : bytes1(_unsafeReadBytesOffset(buffer, begin)); // don't do out-of-bound (possibly unsafe) read if sub-string is empty
        bool positiveSign = sign == bytes1("+");
        bool negativeSign = sign == bytes1("-");
        uint256 offset = (positiveSign || negativeSign).toUint();

        (bool absSuccess, uint256 absValue) = tryParseUint(
            input,
            begin + offset,
            end
        );

        if (absSuccess && absValue < ABS_MIN_INT256) {
            return (true, negativeSign ? -int256(absValue) : int256(absValue));
        } else if (absSuccess && negativeSign && absValue == ABS_MIN_INT256) {
            return (true, type(int256).min);
        } else return (false, 0);
    }

    /**
     * @dev Parse a hexadecimal string (with or without "0x" prefix), and returns the value as a `uint256`.
     *
     * Requirements:
     * - The string must be formatted as `(0x)?[0-9a-fA-F]*`
     * - The result must fit in an `uint256` type.
     */
    function parseHexUint(string memory input) internal pure returns (uint256) {
        return parseHexUint(input, 0, bytes(input).length);
    }

    /**
     * @dev Variant of {parseHexUint-string} that parses a substring of `input` located between position `begin` (included) and
     * `end` (excluded).
     *
     * Requirements:
     * - The substring must be formatted as `(0x)?[0-9a-fA-F]*`
     * - The result must fit in an `uint256` type.
     */
    function parseHexUint(
        string memory input,
        uint256 begin,
        uint256 end
    ) internal pure returns (uint256) {
        (bool success, uint256 value) = tryParseHexUint(input, begin, end);
        if (!success) revert StringsInvalidChar();
        return value;
    }

    /**
     * @dev Variant of {parseHexUint-string} that returns false if the parsing fails because of an invalid character.
     *
     * NOTE: This function will revert if the result does not fit in a `uint256`.
     */
    function tryParseHexUint(
        string memory input
    ) internal pure returns (bool success, uint256 value) {
        return _tryParseHexUintUncheckedBounds(input, 0, bytes(input).length);
    }

    /**
     * @dev Variant of {parseHexUint-string-uint256-uint256} that returns false if the parsing fails because of an
     * invalid character.
     *
     * NOTE: This function will revert if the result does not fit in a `uint256`.
     */
    function tryParseHexUint(
        string memory input,
        uint256 begin,
        uint256 end
    ) internal pure returns (bool success, uint256 value) {
        if (end > bytes(input).length || begin > end) return (false, 0);
        return _tryParseHexUintUncheckedBounds(input, begin, end);
    }

    /**
     * @dev Implementation of {tryParseHexUint-string-uint256-uint256} that does not check bounds. Caller should make sure that
     * `begin <= end <= input.length`. Other inputs would result in undefined behavior.
     */
    function _tryParseHexUintUncheckedBounds(
        string memory input,
        uint256 begin,
        uint256 end
    ) private pure returns (bool success, uint256 value) {
        bytes memory buffer = bytes(input);

        // skip 0x prefix if present
        bool hasPrefix = (end > begin + 1) &&
            bytes2(_unsafeReadBytesOffset(buffer, begin)) == bytes2("0x"); // don't do out-of-bound (possibly unsafe) read if sub-string is empty
        uint256 offset = hasPrefix.toUint() * 2;

        uint256 result = 0;
        for (uint256 i = begin + offset; i < end; ++i) {
            uint8 chr = _tryParseChr(bytes1(_unsafeReadBytesOffset(buffer, i)));
            if (chr > 15) return (false, 0);
            result *= 16;
            unchecked {
                // Multiplying by 16 is equivalent to a shift of 4 bits (with additional overflow check).
                // This guarantees that adding a value < 16 will not cause an overflow, hence the unchecked.
                result += chr;
            }
        }
        return (true, result);
    }

    /**
     * @dev Parse a hexadecimal string (with or without "0x" prefix), and returns the value as an `address`.
     *
     * Requirements:
     * - The string must be formatted as `(0x)?[0-9a-fA-F]{40}`
     */
    function parseAddress(string memory input) internal pure returns (address) {
        return parseAddress(input, 0, bytes(input).length);
    }

    /**
     * @dev Variant of {parseAddress-string} that parses a substring of `input` located between position `begin` (included) and
     * `end` (excluded).
     *
     * Requirements:
     * - The substring must be formatted as `(0x)?[0-9a-fA-F]{40}`
     */
    function parseAddress(
        string memory input,
        uint256 begin,
        uint256 end
    ) internal pure returns (address) {
        (bool success, address value) = tryParseAddress(input, begin, end);
        if (!success) revert StringsInvalidAddressFormat();
        return value;
    }

    /**
     * @dev Variant of {parseAddress-string} that returns false if the parsing fails because the input is not a properly
     * formatted address. See {parseAddress-string} requirements.
     */
    function tryParseAddress(
        string memory input
    ) internal pure returns (bool success, address value) {
        return tryParseAddress(input, 0, bytes(input).length);
    }

    /**
     * @dev Variant of {parseAddress-string-uint256-uint256} that returns false if the parsing fails because input is not a properly
     * formatted address. See {parseAddress-string-uint256-uint256} requirements.
     */
    function tryParseAddress(
        string memory input,
        uint256 begin,
        uint256 end
    ) internal pure returns (bool success, address value) {
        if (end > bytes(input).length || begin > end)
            return (false, address(0));

        bool hasPrefix = (end > begin + 1) &&
            bytes2(_unsafeReadBytesOffset(bytes(input), begin)) == bytes2("0x"); // don't do out-of-bound (possibly unsafe) read if sub-string is empty
        uint256 expectedLength = 40 + hasPrefix.toUint() * 2;

        // check that input is the correct length
        if (end - begin == expectedLength) {
            // length guarantees that this does not overflow, and value is at most type(uint160).max
            (bool s, uint256 v) = _tryParseHexUintUncheckedBounds(
                input,
                begin,
                end
            );
            return (s, address(uint160(v)));
        } else {
            return (false, address(0));
        }
    }

    function _tryParseChr(bytes1 chr) private pure returns (uint8) {
        uint8 value = uint8(chr);

        // Try to parse `chr`:
        // - Case 1: [0-9]
        // - Case 2: [a-f]
        // - Case 3: [A-F]
        // - otherwise not supported
        unchecked {
            if (value > 47 && value < 58) value -= 48;
            else if (value > 96 && value < 103) value -= 87;
            else if (value > 64 && value < 71) value -= 55;
            else return type(uint8).max;
        }

        return value;
    }

    /**
     * @dev Escape special characters in JSON strings. This can be useful to prevent JSON injection in NFT metadata.
     *
     * WARNING: This function should only be used in double quoted JSON strings. Single quotes are not escaped.
     *
     * NOTE: This function escapes all unicode characters, and not just the ones in ranges defined in section 2.5 of
     * RFC-4627 (U+0000 to U+001F, U+0022 and U+005C). ECMAScript's `JSON.parse` does recover escaped unicode
     * characters that are not in this range, but other tooling may provide different results.
     */
    function escapeJSON(
        string memory input
    ) internal pure returns (string memory) {
        bytes memory buffer = bytes(input);
        bytes memory output = new bytes(2 * buffer.length); // worst case scenario
        uint256 outputLength = 0;

        for (uint256 i; i < buffer.length; ++i) {
            bytes1 char = bytes1(_unsafeReadBytesOffset(buffer, i));
            if (((SPECIAL_CHARS_LOOKUP & (1 << uint8(char))) != 0)) {
                output[outputLength++] = "\\";
                if (char == 0x08) output[outputLength++] = "b";
                else if (char == 0x09) output[outputLength++] = "t";
                else if (char == 0x0a) output[outputLength++] = "n";
                else if (char == 0x0c) output[outputLength++] = "f";
                else if (char == 0x0d) output[outputLength++] = "r";
                else if (char == 0x5c) output[outputLength++] = "\\";
                else if (char == 0x22) {
                    // solhint-disable-next-line quotes
                    output[outputLength++] = '"';
                }
            } else {
                output[outputLength++] = char;
            }
        }
        // write the actual length and deallocate unused memory
        assembly ("memory-safe") {
            mstore(output, outputLength)
            mstore(0x40, add(output, shl(5, shr(5, add(outputLength, 63)))))
        }

        return string(output);
    }

    /**
     * @dev Reads a bytes32 from a bytes array without bounds checking.
     *
     * NOTE: making this function internal would mean it could be used with memory unsafe offset, and marking the
     * assembly block as such would prevent some optimizations.
     */
    function _unsafeReadBytesOffset(
        bytes memory buffer,
        uint256 offset
    ) private pure returns (bytes32 value) {
        // This is not memory safe in the general case, but all calls to this private function are within bounds.
        assembly ("memory-safe") {
            value := mload(add(add(buffer, 0x20), offset))
        }
    }
}

// File: @openzeppelin/contracts/utils/cryptography/MessageHashUtils.sol

// OpenZeppelin Contracts (last updated v5.3.0) (utils/cryptography/MessageHashUtils.sol)

pragma solidity ^0.8.20;

/**
 * @dev Signature message hash utilities for producing digests to be consumed by {ECDSA} recovery or signing.
 *
 * The library provides methods for generating a hash of a message that conforms to the
 * https://eips.ethereum.org/EIPS/eip-191[ERC-191] and https://eips.ethereum.org/EIPS/eip-712[EIP 712]
 * specifications.
 */
library MessageHashUtils {
    /**
     * @dev Returns the keccak256 digest of an ERC-191 signed data with version
     * `0x45` (`personal_sign` messages).
     *
     * The digest is calculated by prefixing a bytes32 `messageHash` with
     * `"\x19Ethereum Signed Message:\n32"` and hashing the result. It corresponds with the
     * hash signed when using the https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_sign[`eth_sign`] JSON-RPC method.
     *
     * NOTE: The `messageHash` parameter is intended to be the result of hashing a raw message with
     * keccak256, although any bytes32 value can be safely used because the final digest will
     * be re-hashed.
     *
     * See {ECDSA-recover}.
     */
    function toEthSignedMessageHash(
        bytes32 messageHash
    ) internal pure returns (bytes32 digest) {
        assembly ("memory-safe") {
            mstore(0x00, "\x19Ethereum Signed Message:\n32") // 32 is the bytes-length of messageHash
            mstore(0x1c, messageHash) // 0x1c (28) is the length of the prefix
            digest := keccak256(0x00, 0x3c) // 0x3c is the length of the prefix (0x1c) + messageHash (0x20)
        }
    }

    /**
     * @dev Returns the keccak256 digest of an ERC-191 signed data with version
     * `0x45` (`personal_sign` messages).
     *
     * The digest is calculated by prefixing an arbitrary `message` with
     * `"\x19Ethereum Signed Message:\n" + len(message)` and hashing the result. It corresponds with the
     * hash signed when using the https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_sign[`eth_sign`] JSON-RPC method.
     *
     * See {ECDSA-recover}.
     */
    function toEthSignedMessageHash(
        bytes memory message
    ) internal pure returns (bytes32) {
        return
            keccak256(
                bytes.concat(
                    "\x19Ethereum Signed Message:\n",
                    bytes(Strings.toString(message.length)),
                    message
                )
            );
    }

    /**
     * @dev Returns the keccak256 digest of an ERC-191 signed data with version
     * `0x00` (data with intended validator).
     *
     * The digest is calculated by prefixing an arbitrary `data` with `"\x19\x00"` and the intended
     * `validator` address. Then hashing the result.
     *
     * See {ECDSA-recover}.
     */
    function toDataWithIntendedValidatorHash(
        address validator,
        bytes memory data
    ) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(hex"19_00", validator, data));
    }

    /**
     * @dev Variant of {toDataWithIntendedValidatorHash-address-bytes} optimized for cases where `data` is a bytes32.
     */
    function toDataWithIntendedValidatorHash(
        address validator,
        bytes32 messageHash
    ) internal pure returns (bytes32 digest) {
        assembly ("memory-safe") {
            mstore(0x00, hex"19_00")
            mstore(0x02, shl(96, validator))
            mstore(0x16, messageHash)
            digest := keccak256(0x00, 0x36)
        }
    }

    /**
     * @dev Returns the keccak256 digest of an EIP-712 typed data (ERC-191 version `0x01`).
     *
     * The digest is calculated from a `domainSeparator` and a `structHash`, by prefixing them with
     * `\x19\x01` and hashing the result. It corresponds to the hash signed by the
     * https://eips.ethereum.org/EIPS/eip-712[`eth_signTypedData`] JSON-RPC method as part of EIP-712.
     *
     * See {ECDSA-recover}.
     */
    function toTypedDataHash(
        bytes32 domainSeparator,
        bytes32 structHash
    ) internal pure returns (bytes32 digest) {
        assembly ("memory-safe") {
            let ptr := mload(0x40)
            mstore(ptr, hex"19_01")
            mstore(add(ptr, 0x02), domainSeparator)
            mstore(add(ptr, 0x22), structHash)
            digest := keccak256(ptr, 0x42)
        }
    }
}

// File: @openzeppelin/contracts/utils/StorageSlot.sol

// OpenZeppelin Contracts (last updated v5.1.0) (utils/StorageSlot.sol)
// This file was procedurally generated from scripts/generate/templates/StorageSlot.js.

pragma solidity ^0.8.20;

/**
 * @dev Library for reading and writing primitive types to specific storage slots.
 *
 * Storage slots are often used to avoid storage conflict when dealing with upgradeable contracts.
 * This library helps with reading and writing to such slots without the need for inline assembly.
 *
 * The functions in this library return Slot structs that contain a `value` member that can be used to read or write.
 *
 * Example usage to set ERC-1967 implementation slot:
 * ```solidity
 * contract ERC1967 {
 *     // Define the slot. Alternatively, use the SlotDerivation library to derive the slot.
 *     bytes32 internal constant _IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;
 *
 *     function _getImplementation() internal view returns (address) {
 *         return StorageSlot.getAddressSlot(_IMPLEMENTATION_SLOT).value;
 *     }
 *
 *     function _setImplementation(address newImplementation) internal {
 *         require(newImplementation.code.length > 0);
 *         StorageSlot.getAddressSlot(_IMPLEMENTATION_SLOT).value = newImplementation;
 *     }
 * }
 * ```
 *
 * TIP: Consider using this library along with {SlotDerivation}.
 */
library StorageSlot {
    struct AddressSlot {
        address value;
    }

    struct BooleanSlot {
        bool value;
    }

    struct Bytes32Slot {
        bytes32 value;
    }

    struct Uint256Slot {
        uint256 value;
    }

    struct Int256Slot {
        int256 value;
    }

    struct StringSlot {
        string value;
    }

    struct BytesSlot {
        bytes value;
    }

    /**
     * @dev Returns an `AddressSlot` with member `value` located at `slot`.
     */
    function getAddressSlot(
        bytes32 slot
    ) internal pure returns (AddressSlot storage r) {
        assembly ("memory-safe") {
            r.slot := slot
        }
    }

    /**
     * @dev Returns a `BooleanSlot` with member `value` located at `slot`.
     */
    function getBooleanSlot(
        bytes32 slot
    ) internal pure returns (BooleanSlot storage r) {
        assembly ("memory-safe") {
            r.slot := slot
        }
    }

    /**
     * @dev Returns a `Bytes32Slot` with member `value` located at `slot`.
     */
    function getBytes32Slot(
        bytes32 slot
    ) internal pure returns (Bytes32Slot storage r) {
        assembly ("memory-safe") {
            r.slot := slot
        }
    }

    /**
     * @dev Returns a `Uint256Slot` with member `value` located at `slot`.
     */
    function getUint256Slot(
        bytes32 slot
    ) internal pure returns (Uint256Slot storage r) {
        assembly ("memory-safe") {
            r.slot := slot
        }
    }

    /**
     * @dev Returns a `Int256Slot` with member `value` located at `slot`.
     */
    function getInt256Slot(
        bytes32 slot
    ) internal pure returns (Int256Slot storage r) {
        assembly ("memory-safe") {
            r.slot := slot
        }
    }

    /**
     * @dev Returns a `StringSlot` with member `value` located at `slot`.
     */
    function getStringSlot(
        bytes32 slot
    ) internal pure returns (StringSlot storage r) {
        assembly ("memory-safe") {
            r.slot := slot
        }
    }

    /**
     * @dev Returns an `StringSlot` representation of the string storage pointer `store`.
     */
    function getStringSlot(
        string storage store
    ) internal pure returns (StringSlot storage r) {
        assembly ("memory-safe") {
            r.slot := store.slot
        }
    }

    /**
     * @dev Returns a `BytesSlot` with member `value` located at `slot`.
     */
    function getBytesSlot(
        bytes32 slot
    ) internal pure returns (BytesSlot storage r) {
        assembly ("memory-safe") {
            r.slot := slot
        }
    }

    /**
     * @dev Returns an `BytesSlot` representation of the bytes storage pointer `store`.
     */
    function getBytesSlot(
        bytes storage store
    ) internal pure returns (BytesSlot storage r) {
        assembly ("memory-safe") {
            r.slot := store.slot
        }
    }
}

// File: @openzeppelin/contracts/utils/ShortStrings.sol

// OpenZeppelin Contracts (last updated v5.3.0) (utils/ShortStrings.sol)

pragma solidity ^0.8.20;

// | string  | 0xAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA   |
// | length  | 0x                                                              BB |
type ShortString is bytes32;

/**
 * @dev This library provides functions to convert short memory strings
 * into a `ShortString` type that can be used as an immutable variable.
 *
 * Strings of arbitrary length can be optimized using this library if
 * they are short enough (up to 31 bytes) by packing them with their
 * length (1 byte) in a single EVM word (32 bytes). Additionally, a
 * fallback mechanism can be used for every other case.
 *
 * Usage example:
 *
 * ```solidity
 * contract Named {
 *     using ShortStrings for *;
 *
 *     ShortString private immutable _name;
 *     string private _nameFallback;
 *
 *     constructor(string memory contractName) {
 *         _name = contractName.toShortStringWithFallback(_nameFallback);
 *     }
 *
 *     function name() external view returns (string memory) {
 *         return _name.toStringWithFallback(_nameFallback);
 *     }
 * }
 * ```
 */
library ShortStrings {
    // Used as an identifier for strings longer than 31 bytes.
    bytes32 private constant FALLBACK_SENTINEL =
        0x00000000000000000000000000000000000000000000000000000000000000FF;

    error StringTooLong(string str);
    error InvalidShortString();

    /**
     * @dev Encode a string of at most 31 chars into a `ShortString`.
     *
     * This will trigger a `StringTooLong` error is the input string is too long.
     */
    function toShortString(
        string memory str
    ) internal pure returns (ShortString) {
        bytes memory bstr = bytes(str);
        if (bstr.length > 31) {
            revert StringTooLong(str);
        }
        return ShortString.wrap(bytes32(uint256(bytes32(bstr)) | bstr.length));
    }

    /**
     * @dev Decode a `ShortString` back to a "normal" string.
     */
    function toString(ShortString sstr) internal pure returns (string memory) {
        uint256 len = byteLength(sstr);
        // using `new string(len)` would work locally but is not memory safe.
        string memory str = new string(32);
        assembly ("memory-safe") {
            mstore(str, len)
            mstore(add(str, 0x20), sstr)
        }
        return str;
    }

    /**
     * @dev Return the length of a `ShortString`.
     */
    function byteLength(ShortString sstr) internal pure returns (uint256) {
        uint256 result = uint256(ShortString.unwrap(sstr)) & 0xFF;
        if (result > 31) {
            revert InvalidShortString();
        }
        return result;
    }

    /**
     * @dev Encode a string into a `ShortString`, or write it to storage if it is too long.
     */
    function toShortStringWithFallback(
        string memory value,
        string storage store
    ) internal returns (ShortString) {
        if (bytes(value).length < 32) {
            return toShortString(value);
        } else {
            StorageSlot.getStringSlot(store).value = value;
            return ShortString.wrap(FALLBACK_SENTINEL);
        }
    }

    /**
     * @dev Decode a string that was encoded to `ShortString` or written to storage using {toShortStringWithFallback}.
     */
    function toStringWithFallback(
        ShortString value,
        string storage store
    ) internal pure returns (string memory) {
        if (ShortString.unwrap(value) != FALLBACK_SENTINEL) {
            return toString(value);
        } else {
            return store;
        }
    }

    /**
     * @dev Return the length of a string that was encoded to `ShortString` or written to storage using
     * {toShortStringWithFallback}.
     *
     * WARNING: This will return the "byte length" of the string. This may not reflect the actual length in terms of
     * actual characters as the UTF-8 encoding of a single character can span over multiple bytes.
     */
    function byteLengthWithFallback(
        ShortString value,
        string storage store
    ) internal view returns (uint256) {
        if (ShortString.unwrap(value) != FALLBACK_SENTINEL) {
            return byteLength(value);
        } else {
            return bytes(store).length;
        }
    }
}

// File: @openzeppelin/contracts/interfaces/IERC5267.sol

// OpenZeppelin Contracts (last updated v5.4.0) (interfaces/IERC5267.sol)

pragma solidity >=0.4.16;

interface IERC5267 {
    /**
     * @dev MAY be emitted to signal that the domain could have changed.
     */
    event EIP712DomainChanged();

    /**
     * @dev returns the fields and values that describe the domain separator used by this contract for EIP-712
     * signature.
     */
    function eip712Domain()
        external
        view
        returns (
            bytes1 fields,
            string memory name,
            string memory version,
            uint256 chainId,
            address verifyingContract,
            bytes32 salt,
            uint256[] memory extensions
        );
}

// File: @openzeppelin/contracts/utils/cryptography/EIP712.sol

// OpenZeppelin Contracts (last updated v5.4.0) (utils/cryptography/EIP712.sol)

pragma solidity ^0.8.20;

/**
 * @dev https://eips.ethereum.org/EIPS/eip-712[EIP-712] is a standard for hashing and signing of typed structured data.
 *
 * The encoding scheme specified in the EIP requires a domain separator and a hash of the typed structured data, whose
 * encoding is very generic and therefore its implementation in Solidity is not feasible, thus this contract
 * does not implement the encoding itself. Protocols need to implement the type-specific encoding they need in order to
 * produce the hash of their typed data using a combination of `abi.encode` and `keccak256`.
 *
 * This contract implements the EIP-712 domain separator ({_domainSeparatorV4}) that is used as part of the encoding
 * scheme, and the final step of the encoding to obtain the message digest that is then signed via ECDSA
 * ({_hashTypedDataV4}).
 *
 * The implementation of the domain separator was designed to be as efficient as possible while still properly updating
 * the chain id to protect against replay attacks on an eventual fork of the chain.
 *
 * NOTE: This contract implements the version of the encoding known as "v4", as implemented by the JSON RPC method
 * https://docs.metamask.io/guide/signing-data.html[`eth_signTypedDataV4` in MetaMask].
 *
 * NOTE: In the upgradeable version of this contract, the cached values will correspond to the address, and the domain
 * separator of the implementation contract. This will cause the {_domainSeparatorV4} function to always rebuild the
 * separator from the immutable values, which is cheaper than accessing a cached version in cold storage.
 *
 * @custom:oz-upgrades-unsafe-allow state-variable-immutable
 */
abstract contract EIP712 is IERC5267 {
    using ShortStrings for *;

    bytes32 private constant TYPE_HASH =
        keccak256(
            "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
        );

    // Cache the domain separator as an immutable value, but also store the chain id that it corresponds to, in order to
    // invalidate the cached domain separator if the chain id changes.
    bytes32 private immutable _cachedDomainSeparator;
    uint256 private immutable _cachedChainId;
    address private immutable _cachedThis;

    bytes32 private immutable _hashedName;
    bytes32 private immutable _hashedVersion;

    ShortString private immutable _name;
    ShortString private immutable _version;
    // slither-disable-next-line constable-states
    string private _nameFallback;
    // slither-disable-next-line constable-states
    string private _versionFallback;

    /**
     * @dev Initializes the domain separator and parameter caches.
     *
     * The meaning of `name` and `version` is specified in
     * https://eips.ethereum.org/EIPS/eip-712#definition-of-domainseparator[EIP-712]:
     *
     * - `name`: the user readable name of the signing domain, i.e. the name of the DApp or the protocol.
     * - `version`: the current major version of the signing domain.
     *
     * NOTE: These parameters cannot be changed except through a xref:learn::upgrading-smart-contracts.adoc[smart
     * contract upgrade].
     */
    constructor(string memory name, string memory version) {
        _name = name.toShortStringWithFallback(_nameFallback);
        _version = version.toShortStringWithFallback(_versionFallback);
        _hashedName = keccak256(bytes(name));
        _hashedVersion = keccak256(bytes(version));

        _cachedChainId = block.chainid;
        _cachedDomainSeparator = _buildDomainSeparator();
        _cachedThis = address(this);
    }

    /**
     * @dev Returns the domain separator for the current chain.
     */
    function _domainSeparatorV4() internal view returns (bytes32) {
        if (address(this) == _cachedThis && block.chainid == _cachedChainId) {
            return _cachedDomainSeparator;
        } else {
            return _buildDomainSeparator();
        }
    }

    function _buildDomainSeparator() private view returns (bytes32) {
        return
            keccak256(
                abi.encode(
                    TYPE_HASH,
                    _hashedName,
                    _hashedVersion,
                    block.chainid,
                    address(this)
                )
            );
    }

    /**
     * @dev Given an already https://eips.ethereum.org/EIPS/eip-712#definition-of-hashstruct[hashed struct], this
     * function returns the hash of the fully encoded EIP712 message for this domain.
     *
     * This hash can be used together with {ECDSA-recover} to obtain the signer of a message. For example:
     *
     * ```solidity
     * bytes32 digest = _hashTypedDataV4(keccak256(abi.encode(
     *     keccak256("Mail(address to,string contents)"),
     *     mailTo,
     *     keccak256(bytes(mailContents))
     * )));
     * address signer = ECDSA.recover(digest, signature);
     * ```
     */
    function _hashTypedDataV4(
        bytes32 structHash
    ) internal view virtual returns (bytes32) {
        return
            MessageHashUtils.toTypedDataHash(_domainSeparatorV4(), structHash);
    }

    /// @inheritdoc IERC5267
    function eip712Domain()
        public
        view
        virtual
        returns (
            bytes1 fields,
            string memory name,
            string memory version,
            uint256 chainId,
            address verifyingContract,
            bytes32 salt,
            uint256[] memory extensions
        )
    {
        return (
            hex"0f", // 01111
            _EIP712Name(),
            _EIP712Version(),
            block.chainid,
            address(this),
            bytes32(0),
            new uint256[](0)
        );
    }

    /**
     * @dev The name parameter for the EIP712 domain.
     *
     * NOTE: By default this function reads _name which is an immutable value.
     * It only reads from storage if necessary (in case the value is too large to fit in a ShortString).
     */
    // solhint-disable-next-line func-name-mixedcase
    function _EIP712Name() internal view returns (string memory) {
        return _name.toStringWithFallback(_nameFallback);
    }

    /**
     * @dev The version parameter for the EIP712 domain.
     *
     * NOTE: By default this function reads _version which is an immutable value.
     * It only reads from storage if necessary (in case the value is too large to fit in a ShortString).
     */
    // solhint-disable-next-line func-name-mixedcase
    function _EIP712Version() internal view returns (string memory) {
        return _version.toStringWithFallback(_versionFallback);
    }
}

// File: @openzeppelin/contracts/utils/Context.sol

// OpenZeppelin Contracts (last updated v5.0.1) (utils/Context.sol)

pragma solidity ^0.8.20;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }

    function _contextSuffixLength() internal view virtual returns (uint256) {
        return 0;
    }
}

// File: @openzeppelin/contracts/access/Ownable.sol

// OpenZeppelin Contracts (last updated v5.0.0) (access/Ownable.sol)

pragma solidity ^0.8.20;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * The initial owner is set to the address provided by the deployer. This can
 * later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    /**
     * @dev The caller account is not authorized to perform an operation.
     */
    error OwnableUnauthorizedAccount(address account);

    /**
     * @dev The owner is not a valid owner account. (eg. `address(0)`)
     */
    error OwnableInvalidOwner(address owner);

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    /**
     * @dev Initializes the contract setting the address provided by the deployer as the initial owner.
     */
    constructor(address initialOwner) {
        if (initialOwner == address(0)) {
            revert OwnableInvalidOwner(address(0));
        }
        _transferOwnership(initialOwner);
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        if (owner() != _msgSender()) {
            revert OwnableUnauthorizedAccount(_msgSender());
        }
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby disabling any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        if (newOwner == address(0)) {
            revert OwnableInvalidOwner(address(0));
        }
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

// File: @openzeppelin/contracts/utils/Pausable.sol

// OpenZeppelin Contracts (last updated v5.3.0) (utils/Pausable.sol)

pragma solidity ^0.8.20;

/**
 * @dev Contract module which allows children to implement an emergency stop
 * mechanism that can be triggered by an authorized account.
 *
 * This module is used through inheritance. It will make available the
 * modifiers `whenNotPaused` and `whenPaused`, which can be applied to
 * the functions of your contract. Note that they will not be pausable by
 * simply including this module, only once the modifiers are put in place.
 */
abstract contract Pausable is Context {
    bool private _paused;

    /**
     * @dev Emitted when the pause is triggered by `account`.
     */
    event Paused(address account);

    /**
     * @dev Emitted when the pause is lifted by `account`.
     */
    event Unpaused(address account);

    /**
     * @dev The operation failed because the contract is paused.
     */
    error EnforcedPause();

    /**
     * @dev The operation failed because the contract is not paused.
     */
    error ExpectedPause();

    /**
     * @dev Modifier to make a function callable only when the contract is not paused.
     *
     * Requirements:
     *
     * - The contract must not be paused.
     */
    modifier whenNotPaused() {
        _requireNotPaused();
        _;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is paused.
     *
     * Requirements:
     *
     * - The contract must be paused.
     */
    modifier whenPaused() {
        _requirePaused();
        _;
    }

    /**
     * @dev Returns true if the contract is paused, and false otherwise.
     */
    function paused() public view virtual returns (bool) {
        return _paused;
    }

    /**
     * @dev Throws if the contract is paused.
     */
    function _requireNotPaused() internal view virtual {
        if (paused()) {
            revert EnforcedPause();
        }
    }

    /**
     * @dev Throws if the contract is not paused.
     */
    function _requirePaused() internal view virtual {
        if (!paused()) {
            revert ExpectedPause();
        }
    }

    /**
     * @dev Triggers stopped state.
     *
     * Requirements:
     *
     * - The contract must not be paused.
     */
    function _pause() internal virtual whenNotPaused {
        _paused = true;
        emit Paused(_msgSender());
    }

    /**
     * @dev Returns to normal state.
     *
     * Requirements:
     *
     * - The contract must be paused.
     */
    function _unpause() internal virtual whenPaused {
        _paused = false;
        emit Unpaused(_msgSender());
    }
}

// File: @openzeppelin/contracts/token/ERC20/IERC20.sol

// OpenZeppelin Contracts (last updated v5.4.0) (token/ERC20/IERC20.sol)

pragma solidity >=0.4.16;

/**
 * @dev Interface of the ERC-20 standard as defined in the ERC.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    /**
     * @dev Returns the value of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the value of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves a `value` amount of tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 value) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    /**
     * @dev Sets a `value` amount of tokens as the allowance of `spender` over the
     * caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 value) external returns (bool);

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to` using the
     * allowance mechanism. `value` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);
}

// File: @1inch/solidity-utils/contracts/interfaces/IWETH.sol

pragma solidity ^0.8.0;

/**
 * @title IWETH
 * @dev Interface for wrapper as WETH-like token.
 */
interface IWETH is IERC20 {
    /**
     * @notice Emitted when Ether is deposited to get wrapper tokens.
     */
    event Deposit(address indexed dst, uint256 wad);

    /**
     * @notice Emitted when wrapper tokens is withdrawn as Ether.
     */
    event Withdrawal(address indexed src, uint256 wad);

    /**
     * @notice Deposit Ether to get wrapper tokens.
     */
    function deposit() external payable;

    /**
     * @notice Withdraw wrapped tokens as Ether.
     * @param amount Amount of wrapped tokens to withdraw.
     */
    function withdraw(uint256 amount) external;
}

// File: @openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol

// OpenZeppelin Contracts (last updated v5.4.0) (token/ERC20/extensions/IERC20Permit.sol)

pragma solidity >=0.4.16;

/**
 * @dev Interface of the ERC-20 Permit extension allowing approvals to be made via signatures, as defined in
 * https://eips.ethereum.org/EIPS/eip-2612[ERC-2612].
 *
 * Adds the {permit} method, which can be used to change an account's ERC-20 allowance (see {IERC20-allowance}) by
 * presenting a message signed by the account. By not relying on {IERC20-approve}, the token holder account doesn't
 * need to send a transaction, and thus is not required to hold Ether at all.
 *
 * ==== Security Considerations
 *
 * There are two important considerations concerning the use of `permit`. The first is that a valid permit signature
 * expresses an allowance, and it should not be assumed to convey additional meaning. In particular, it should not be
 * considered as an intention to spend the allowance in any specific way. The second is that because permits have
 * built-in replay protection and can be submitted by anyone, they can be frontrun. A protocol that uses permits should
 * take this into consideration and allow a `permit` call to fail. Combining these two aspects, a pattern that may be
 * generally recommended is:
 *
 * ```solidity
 * function doThingWithPermit(..., uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) public {
 *     try token.permit(msg.sender, address(this), value, deadline, v, r, s) {} catch {}
 *     doThing(..., value);
 * }
 *
 * function doThing(..., uint256 value) public {
 *     token.safeTransferFrom(msg.sender, address(this), value);
 *     ...
 * }
 * ```
 *
 * Observe that: 1) `msg.sender` is used as the owner, leaving no ambiguity as to the signer intent, and 2) the use of
 * `try/catch` allows the permit to fail and makes the code tolerant to frontrunning. (See also
 * {SafeERC20-safeTransferFrom}).
 *
 * Additionally, note that smart contract wallets (such as Argent or Safe) are not able to produce permit signatures, so
 * contracts should have entry points that don't rely on permit.
 */
interface IERC20Permit {
    /**
     * @dev Sets `value` as the allowance of `spender` over ``owner``'s tokens,
     * given ``owner``'s signed approval.
     *
     * IMPORTANT: The same issues {IERC20-approve} has related to transaction
     * ordering also apply here.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `deadline` must be a timestamp in the future.
     * - `v`, `r` and `s` must be a valid `secp256k1` signature from `owner`
     * over the EIP712-formatted function arguments.
     * - the signature must use ``owner``'s current nonce (see {nonces}).
     *
     * For more information on the signature format, see the
     * https://eips.ethereum.org/EIPS/eip-2612#specification[relevant EIP
     * section].
     *
     * CAUTION: See Security Considerations above.
     */
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    /**
     * @dev Returns the current nonce for `owner`. This value must be
     * included whenever a signature is generated for {permit}.
     *
     * Every successful call to {permit} increases ``owner``'s nonce by one. This
     * prevents a signature from being used multiple times.
     */
    function nonces(address owner) external view returns (uint256);

    /**
     * @dev Returns the domain separator used in the encoding of the signature for {permit}, as defined by {EIP712}.
     */
    // solhint-disable-next-line func-name-mixedcase
    function DOMAIN_SEPARATOR() external view returns (bytes32);
}

// File: @1inch/solidity-utils/contracts/interfaces/IDaiLikePermit.sol

pragma solidity ^0.8.0;

/**
 * @title IDaiLikePermit
 * @dev Interface for Dai-like permit function allowing token spending via signatures.
 */
interface IDaiLikePermit {
    /**
     * @notice Approves spending of tokens via off-chain signatures.
     * @param holder Token holder's address.
     * @param spender Spender's address.
     * @param nonce Current nonce of the holder.
     * @param expiry Time when the permit expires.
     * @param allowed True to allow, false to disallow spending.
     * @param v, r, s Signature components.
     */
    function permit(
        address holder,
        address spender,
        uint256 nonce,
        uint256 expiry,
        bool allowed,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;
}

// File: @1inch/solidity-utils/contracts/interfaces/IPermit2.sol

pragma solidity ^0.8.0;

/**
 * @title IPermit2
 * @dev Interface for a flexible permit system that extends ERC20 tokens to support permits in tokens lacking native permit functionality.
 */
interface IPermit2 {
    /**
     * @dev Struct for holding permit details.
     * @param token ERC20 token address for which the permit is issued.
     * @param amount The maximum amount allowed to spend.
     * @param expiration Timestamp until which the permit is valid.
     * @param nonce An incrementing value for each signature, unique per owner, token, and spender.
     */
    struct PermitDetails {
        address token;
        uint160 amount;
        uint48 expiration;
        uint48 nonce;
    }

    /**
     * @dev Struct for a single token allowance permit.
     * @param details Permit details including token, amount, expiration, and nonce.
     * @param spender Address authorized to spend the tokens.
     * @param sigDeadline Deadline for the permit signature, ensuring timeliness of the permit.
     */
    struct PermitSingle {
        PermitDetails details;
        address spender;
        uint256 sigDeadline;
    }

    /**
     * @dev Struct for packed allowance data to optimize storage.
     * @param amount Amount allowed.
     * @param expiration Permission expiry timestamp.
     * @param nonce Unique incrementing value for tracking allowances.
     */
    struct PackedAllowance {
        uint160 amount;
        uint48 expiration;
        uint48 nonce;
    }

    /**
     * @notice Executes a token transfer from one address to another.
     * @param user The token owner's address.
     * @param spender The address authorized to spend the tokens.
     * @param amount The amount of tokens to transfer.
     * @param token The address of the token being transferred.
     */
    function transferFrom(
        address user,
        address spender,
        uint160 amount,
        address token
    ) external;

    /**
     * @notice Issues a permit for spending tokens via a signed authorization.
     * @param owner The token owner's address.
     * @param permitSingle Struct containing the permit details.
     * @param signature The signature proving the owner authorized the permit.
     */
    function permit(
        address owner,
        PermitSingle memory permitSingle,
        bytes calldata signature
    ) external;

    /**
     * @notice Retrieves the allowance details between a token owner and spender.
     * @param user The token owner's address.
     * @param token The token address.
     * @param spender The spender's address.
     * @return The packed allowance details.
     */
    function allowance(
        address user,
        address token,
        address spender
    ) external view returns (PackedAllowance memory);

    /**
     * @notice Approves the spender to use up to amount of the specified token up until the expiration
     * @param token The token to approve
     * @param spender The spender address to approve
     * @param amount The approved amount of the token
     * @param expiration The timestamp at which the approval is no longer valid
     * @dev The packed allowance also holds a nonce, which will stay unchanged in approve
     * @dev Setting amount to type(uint160).max sets an unlimited approval
     */
    function approve(
        address token,
        address spender,
        uint160 amount,
        uint48 expiration
    ) external;
}

// File: @1inch/solidity-utils/contracts/interfaces/IERC7597Permit.sol

pragma solidity ^0.8.0;

/**
 * @title IERC7597Permit
 * @dev A new extension for ERC-2612 permit, which has already been added to USDC v2.2.
 */
interface IERC7597Permit {
    /**
     * @notice Update allowance with a signed permit.
     * @dev Signature bytes can be used for both EOA wallets and contract wallets.
     * @param owner Token owner's address (Authorizer).
     * @param spender Spender's address.
     * @param value Amount of allowance.
     * @param deadline The time at which the signature expires (unixtime).
     * @param signature Unstructured bytes signature signed by an EOA wallet or a contract wallet.
     */
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        bytes memory signature
    ) external;
}

// File: @1inch/solidity-utils/contracts/libraries/RevertReasonForwarder.sol

pragma solidity ^0.8.0;

/**
 * @title RevertReasonForwarder
 * @notice Provides utilities for forwarding and retrieving revert reasons from failed external calls.
 */
library RevertReasonForwarder {
    /**
     * @dev Forwards the revert reason from the latest external call.
     * This method allows propagating the revert reason of a failed external call to the caller.
     */
    function reRevert() internal pure {
        // bubble up revert reason from latest external call
        assembly ("memory-safe") {
            // solhint-disable-line no-inline-assembly
            let ptr := mload(0x40)
            returndatacopy(ptr, 0, returndatasize())
            revert(ptr, returndatasize())
        }
    }

    /**
     * @dev Retrieves the revert reason from the latest external call.
     * This method enables capturing the revert reason of a failed external call for inspection or processing.
     * @return reason The latest external call revert reason.
     */
    function reReason() internal pure returns (bytes memory reason) {
        assembly ("memory-safe") {
            // solhint-disable-line no-inline-assembly
            reason := mload(0x40)
            let length := returndatasize()
            mstore(reason, length)
            returndatacopy(add(reason, 0x20), 0, length)
            mstore(0x40, add(reason, add(0x20, length)))
        }
    }
}

// File: @1inch/solidity-utils/contracts/libraries/SafeERC20.sol

pragma solidity ^0.8.0;

/**
 * @title Implements efficient safe methods for ERC20 interface.
 * @notice Compared to the standard ERC20, this implementation offers several enhancements:
 * 1. more gas-efficient, providing significant savings in transaction costs.
 * 2. support for different permit implementations
 * 3. forceApprove functionality
 * 4. support for WETH deposit and withdraw
 */
library SafeERC20 {
    error SafeTransferFailed();
    error SafeTransferFromFailed();
    error ForceApproveFailed();
    error SafeIncreaseAllowanceFailed();
    error SafeDecreaseAllowanceFailed();
    error SafePermitBadLength();
    error Permit2TransferAmountTooHigh();

    // Uniswap Permit2 address
    address private constant _PERMIT2 =
        0x000000000022D473030F116dDEE9F6B43aC78BA3;
    address private constant _PERMIT2_ZKSYNC =
        0x0000000000225e31D15943971F47aD3022F714Fa;
    bytes4 private constant _PERMIT_LENGTH_ERROR = 0x68275857; // SafePermitBadLength.selector

    /**
     * @notice Fetches the balance of a specific ERC20 token held by an account.
     * Consumes less gas then regular `ERC20.balanceOf`.
     * @dev Note that the implementation does not perform dirty bits cleaning, so it is the
     * responsibility of the caller to make sure that the higher 96 bits of the `account` parameter are clean.
     * @param token The IERC20 token contract for which the balance will be fetched.
     * @param account The address of the account whose token balance will be fetched.
     * @return tokenBalance The balance of the specified ERC20 token held by the account.
     */
    function safeBalanceOf(
        IERC20 token,
        address account
    ) internal view returns (uint256 tokenBalance) {
        bytes4 selector = IERC20.balanceOf.selector;
        assembly ("memory-safe") {
            // solhint-disable-line no-inline-assembly
            mstore(0x00, selector)
            mstore(0x04, account)
            let success := staticcall(gas(), token, 0x00, 0x24, 0x00, 0x20)
            tokenBalance := mload(0)

            if or(iszero(success), lt(returndatasize(), 0x20)) {
                let ptr := mload(0x40)
                returndatacopy(ptr, 0, returndatasize())
                revert(ptr, returndatasize())
            }
        }
    }

    /**
     * @notice Attempts to safely transfer tokens from one address to another.
     * @dev If permit2 is true, uses the Permit2 standard; otherwise uses the standard ERC20 transferFrom.
     * Either requires `true` in return data, or requires target to be smart-contract and empty return data.
     * Note that the implementation does not perform dirty bits cleaning, so it is the responsibility of
     * the caller to make sure that the higher 96 bits of the `from` and `to` parameters are clean.
     * @param token The IERC20 token contract from which the tokens will be transferred.
     * @param from The address from which the tokens will be transferred.
     * @param to The address to which the tokens will be transferred.
     * @param amount The amount of tokens to transfer.
     * @param permit2 If true, uses the Permit2 standard for the transfer; otherwise uses the standard ERC20 transferFrom.
     */
    function safeTransferFromUniversal(
        IERC20 token,
        address from,
        address to,
        uint256 amount,
        bool permit2
    ) internal {
        if (permit2) {
            safeTransferFromPermit2(token, from, to, amount);
        } else {
            safeTransferFrom(token, from, to, amount);
        }
    }

    /**
     * @notice Attempts to safely transfer tokens from one address to another using the ERC20 standard.
     * @dev Either requires `true` in return data, or requires target to be smart-contract and empty return data.
     * Note that the implementation does not perform dirty bits cleaning, so it is the responsibility of
     * the caller to make sure that the higher 96 bits of the `from` and `to` parameters are clean.
     * @param token The IERC20 token contract from which the tokens will be transferred.
     * @param from The address from which the tokens will be transferred.
     * @param to The address to which the tokens will be transferred.
     * @param amount The amount of tokens to transfer.
     */
    function safeTransferFrom(
        IERC20 token,
        address from,
        address to,
        uint256 amount
    ) internal {
        bytes4 selector = token.transferFrom.selector;
        bool success;
        assembly ("memory-safe") {
            // solhint-disable-line no-inline-assembly
            let data := mload(0x40)

            mstore(data, selector)
            mstore(add(data, 0x04), from)
            mstore(add(data, 0x24), to)
            mstore(add(data, 0x44), amount)
            success := call(gas(), token, 0, data, 0x64, 0x0, 0x20)
            if success {
                switch returndatasize()
                case 0 {
                    success := gt(extcodesize(token), 0)
                }
                default {
                    success := and(gt(returndatasize(), 31), eq(mload(0), 1))
                }
            }
        }
        if (!success) revert SafeTransferFromFailed();
    }

    /**
     * @notice Attempts to safely transfer tokens from one address to another using the Permit2 standard.
     * @dev Either requires `true` in return data, or requires target to be smart-contract and empty return data.
     * Note that the implementation does not perform dirty bits cleaning, so it is the responsibility of
     * the caller to make sure that the higher 96 bits of the `from` and `to` parameters are clean.
     * @param token The IERC20 token contract from which the tokens will be transferred.
     * @param from The address from which the tokens will be transferred.
     * @param to The address to which the tokens will be transferred.
     * @param amount The amount of tokens to transfer.
     */
    function safeTransferFromPermit2(
        IERC20 token,
        address from,
        address to,
        uint256 amount
    ) internal {
        if (amount > type(uint160).max) revert Permit2TransferAmountTooHigh();
        address permit2 = _getPermit2Address();
        bytes4 selector = IPermit2.transferFrom.selector;
        bool success;
        assembly ("memory-safe") {
            // solhint-disable-line no-inline-assembly
            let data := mload(0x40)

            mstore(data, selector)
            mstore(add(data, 0x04), from)
            mstore(add(data, 0x24), to)
            mstore(add(data, 0x44), amount)
            mstore(add(data, 0x64), token)
            success := call(gas(), permit2, 0, data, 0x84, 0x0, 0x0)
            if success {
                success := gt(extcodesize(permit2), 0)
            }
        }
        if (!success) revert SafeTransferFromFailed();
    }

    /**
     * @notice Attempts to safely transfer tokens to another address.
     * @dev Either requires `true` in return data, or requires target to be smart-contract and empty return data.
     * Note that the implementation does not perform dirty bits cleaning, so it is the responsibility of
     * the caller to make sure that the higher 96 bits of the `to` parameter are clean.
     * @param token The IERC20 token contract from which the tokens will be transferred.
     * @param to The address to which the tokens will be transferred.
     * @param amount The amount of tokens to transfer.
     */
    function safeTransfer(IERC20 token, address to, uint256 amount) internal {
        if (!_makeCall(token, token.transfer.selector, to, amount)) {
            revert SafeTransferFailed();
        }
    }

    /**
     * @notice Attempts to approve a spender to spend a certain amount of tokens.
     * @dev If `approve(from, to, amount)` fails, it tries to set the allowance to zero, and retries the `approve` call.
     * Note that the implementation does not perform dirty bits cleaning, so it is the responsibility of
     * the caller to make sure that the higher 96 bits of the `spender` parameter are clean.
     * @param token The IERC20 token contract on which the call will be made.
     * @param spender The address which will spend the funds.
     * @param value The amount of tokens to be spent.
     */
    function forceApprove(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        if (!_makeCall(token, token.approve.selector, spender, value)) {
            if (
                !_makeCall(token, token.approve.selector, spender, 0) ||
                !_makeCall(token, token.approve.selector, spender, value)
            ) {
                revert ForceApproveFailed();
            }
        }
    }

    /**
     * @notice Safely increases the allowance of a spender.
     * @dev Increases with safe math check. Checks if the increased allowance will overflow, if yes, then it reverts the transaction.
     * Then uses `forceApprove` to increase the allowance.
     * Note that the implementation does not perform dirty bits cleaning, so it is the responsibility of
     * the caller to make sure that the higher 96 bits of the `spender` parameter are clean.
     * @param token The IERC20 token contract on which the call will be made.
     * @param spender The address which will spend the funds.
     * @param value The amount of tokens to increase the allowance by.
     */
    function safeIncreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        uint256 allowance = token.allowance(address(this), spender);
        if (value > type(uint256).max - allowance)
            revert SafeIncreaseAllowanceFailed();
        forceApprove(token, spender, allowance + value);
    }

    /**
     * @notice Safely decreases the allowance of a spender.
     * @dev Decreases with safe math check. Checks if the decreased allowance will underflow, if yes, then it reverts the transaction.
     * Then uses `forceApprove` to increase the allowance.
     * Note that the implementation does not perform dirty bits cleaning, so it is the responsibility of
     * the caller to make sure that the higher 96 bits of the `spender` parameter are clean.
     * @param token The IERC20 token contract on which the call will be made.
     * @param spender The address which will spend the funds.
     * @param value The amount of tokens to decrease the allowance by.
     */
    function safeDecreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        uint256 allowance = token.allowance(address(this), spender);
        if (value > allowance) revert SafeDecreaseAllowanceFailed();
        forceApprove(token, spender, allowance - value);
    }

    /**
     * @notice Attempts to execute the `permit` function on the provided token with the sender and contract as parameters.
     * Permit type is determined automatically based on permit calldata (IERC20Permit, IDaiLikePermit, and IPermit2).
     * @dev Wraps `tryPermit` function and forwards revert reason if permit fails.
     * @param token The IERC20 token to execute the permit function on.
     * @param permit The permit data to be used in the function call.
     */
    function safePermit(IERC20 token, bytes calldata permit) internal {
        if (!tryPermit(token, msg.sender, address(this), permit))
            RevertReasonForwarder.reRevert();
    }

    /**
     * @notice Attempts to execute the `permit` function on the provided token with custom owner and spender parameters.
     * Permit type is determined automatically based on permit calldata (IERC20Permit, IDaiLikePermit, and IPermit2).
     * @dev Wraps `tryPermit` function and forwards revert reason if permit fails.
     * Note that the implementation does not perform dirty bits cleaning, so it is the responsibility of
     * the caller to make sure that the higher 96 bits of the `owner` and `spender` parameters are clean.
     * @param token The IERC20 token to execute the permit function on.
     * @param owner The owner of the tokens for which the permit is made.
     * @param spender The spender allowed to spend the tokens by the permit.
     * @param permit The permit data to be used in the function call.
     */
    function safePermit(
        IERC20 token,
        address owner,
        address spender,
        bytes calldata permit
    ) internal {
        if (!tryPermit(token, owner, spender, permit))
            RevertReasonForwarder.reRevert();
    }

    /**
     * @notice Attempts to execute the `permit` function on the provided token with the sender and contract as parameters.
     * @dev Invokes `tryPermit` with sender as owner and contract as spender.
     * @param token The IERC20 token to execute the permit function on.
     * @param permit The permit data to be used in the function call.
     * @return success Returns true if the permit function was successfully executed, false otherwise.
     */
    function tryPermit(
        IERC20 token,
        bytes calldata permit
    ) internal returns (bool success) {
        return tryPermit(token, msg.sender, address(this), permit);
    }

    /**
     * @notice The function attempts to call the permit function on a given ERC20 token.
     * @dev The function is designed to support a variety of permit functions, namely: IERC20Permit, IDaiLikePermit, IERC7597Permit and IPermit2.
     * It accommodates both Compact and Full formats of these permit types.
     * Please note, it is expected that the `expiration` parameter for the compact Permit2 and the `deadline` parameter
     * for the compact Permit are to be incremented by one before invoking this function. This approach is motivated by
     * gas efficiency considerations; as the unlimited expiration period is likely to be the most common scenario, and
     * zeros are cheaper to pass in terms of gas cost. Thus, callers should increment the expiration or deadline by one
     * before invocation for optimized performance.
     * Note that the implementation does not perform dirty bits cleaning, so it is the responsibility of
     * the caller to make sure that the higher 96 bits of the `owner` and `spender` parameters are clean.
     * @param token The address of the ERC20 token on which to call the permit function.
     * @param owner The owner of the tokens. This address should have signed the off-chain permit.
     * @param spender The address which will be approved for transfer of tokens.
     * @param permit The off-chain permit data, containing different fields depending on the type of permit function.
     * @return success A boolean indicating whether the permit call was successful.
     */
    function tryPermit(
        IERC20 token,
        address owner,
        address spender,
        bytes calldata permit
    ) internal returns (bool success) {
        address permit2 = _getPermit2Address();
        // load function selectors for different permit standards
        bytes4 permitSelector = IERC20Permit.permit.selector;
        bytes4 daiPermitSelector = IDaiLikePermit.permit.selector;
        bytes4 permit2Selector = IPermit2.permit.selector;
        bytes4 erc7597PermitSelector = IERC7597Permit.permit.selector;
        assembly ("memory-safe") {
            // solhint-disable-line no-inline-assembly
            let ptr := mload(0x40)

            // Switch case for different permit lengths, indicating different permit standards
            switch permit.length
            // Compact IERC20Permit
            case 100 {
                mstore(ptr, permitSelector) // store selector
                mstore(add(ptr, 0x04), owner) // store owner
                mstore(add(ptr, 0x24), spender) // store spender

                // Compact IERC20Permit.permit(uint256 value, uint32 deadline, uint256 r, uint256 vs)
                {
                    // stack too deep
                    let deadline := shr(
                        224,
                        calldataload(add(permit.offset, 0x20))
                    ) // loads permit.offset 0x20..0x23
                    let vs := calldataload(add(permit.offset, 0x44)) // loads permit.offset 0x44..0x63

                    calldatacopy(add(ptr, 0x44), permit.offset, 0x20) // store value     = copy permit.offset 0x00..0x19
                    mstore(add(ptr, 0x64), sub(deadline, 1)) // store deadline  = deadline - 1
                    mstore(add(ptr, 0x84), add(27, shr(255, vs))) // store v         = most significant bit of vs + 27 (27 or 28)
                    calldatacopy(add(ptr, 0xa4), add(permit.offset, 0x24), 0x20) // store r         = copy permit.offset 0x24..0x43
                    mstore(add(ptr, 0xc4), shr(1, shl(1, vs))) // store s         = vs without most significant bit
                }
                // IERC20Permit.permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s)
                success := call(gas(), token, 0, ptr, 0xe4, 0, 0)
            }
            // Compact IDaiLikePermit
            case 72 {
                mstore(ptr, daiPermitSelector) // store selector
                mstore(add(ptr, 0x04), owner) // store owner
                mstore(add(ptr, 0x24), spender) // store spender

                // Compact IDaiLikePermit.permit(uint32 nonce, uint32 expiry, uint256 r, uint256 vs)
                {
                    // stack too deep
                    let expiry := shr(
                        224,
                        calldataload(add(permit.offset, 0x04))
                    ) // loads permit.offset 0x04..0x07
                    let vs := calldataload(add(permit.offset, 0x28)) // loads permit.offset 0x28..0x47

                    mstore(
                        add(ptr, 0x44),
                        shr(224, calldataload(permit.offset))
                    ) // store nonce   = copy permit.offset 0x00..0x03
                    mstore(add(ptr, 0x64), sub(expiry, 1)) // store expiry  = expiry - 1
                    mstore(add(ptr, 0x84), true) // store allowed = true
                    mstore(add(ptr, 0xa4), add(27, shr(255, vs))) // store v       = most significant bit of vs + 27 (27 or 28)
                    calldatacopy(add(ptr, 0xc4), add(permit.offset, 0x08), 0x20) // store r       = copy permit.offset 0x08..0x27
                    mstore(add(ptr, 0xe4), shr(1, shl(1, vs))) // store s       = vs without most significant bit
                }
                // IDaiLikePermit.permit(address holder, address spender, uint256 nonce, uint256 expiry, bool allowed, uint8 v, bytes32 r, bytes32 s)
                success := call(gas(), token, 0, ptr, 0x104, 0, 0)
            }
            // IERC20Permit
            case 224 {
                mstore(ptr, permitSelector)
                calldatacopy(add(ptr, 0x04), permit.offset, permit.length) // copy permit calldata
                // IERC20Permit.permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s)
                success := call(gas(), token, 0, ptr, 0xe4, 0, 0)
            }
            // IDaiLikePermit
            case 256 {
                mstore(ptr, daiPermitSelector)
                calldatacopy(add(ptr, 0x04), permit.offset, permit.length) // copy permit calldata
                // IDaiLikePermit.permit(address holder, address spender, uint256 nonce, uint256 expiry, bool allowed, uint8 v, bytes32 r, bytes32 s)
                success := call(gas(), token, 0, ptr, 0x104, 0, 0)
            }
            // Compact IPermit2
            case 96 {
                // Compact IPermit2.permit(uint160 amount, uint32 expiration, uint32 nonce, uint32 sigDeadline, uint256 r, uint256 vs)
                mstore(ptr, permit2Selector) // store selector
                mstore(add(ptr, 0x04), owner) // store owner
                mstore(add(ptr, 0x24), token) // store token

                calldatacopy(add(ptr, 0x50), permit.offset, 0x14) // store amount = copy permit.offset 0x00..0x13
                // and(0xffffffffffff, ...) - conversion to uint48
                mstore(
                    add(ptr, 0x64),
                    and(
                        0xffffffffffff,
                        sub(shr(224, calldataload(add(permit.offset, 0x14))), 1)
                    )
                ) // store expiration = ((permit.offset 0x14..0x17 - 1) & 0xffffffffffff)
                mstore(
                    add(ptr, 0x84),
                    shr(224, calldataload(add(permit.offset, 0x18)))
                ) // store nonce = copy permit.offset 0x18..0x1b
                mstore(add(ptr, 0xa4), spender) // store spender
                // and(0xffffffffffff, ...) - conversion to uint48
                mstore(
                    add(ptr, 0xc4),
                    and(
                        0xffffffffffff,
                        sub(shr(224, calldataload(add(permit.offset, 0x1c))), 1)
                    )
                ) // store sigDeadline = ((permit.offset 0x1c..0x1f - 1) & 0xffffffffffff)
                mstore(add(ptr, 0xe4), 0x100) // store offset = 256
                mstore(add(ptr, 0x104), 0x40) // store length = 64
                calldatacopy(add(ptr, 0x124), add(permit.offset, 0x20), 0x20) // store r      = copy permit.offset 0x20..0x3f
                calldatacopy(add(ptr, 0x144), add(permit.offset, 0x40), 0x20) // store vs     = copy permit.offset 0x40..0x5f
                // IPermit2.permit(address owner, PermitSingle calldata permitSingle, bytes calldata signature)
                success := call(gas(), permit2, 0, ptr, 0x164, 0, 0)
            }
            // IPermit2
            case 352 {
                mstore(ptr, permit2Selector)
                calldatacopy(add(ptr, 0x04), permit.offset, permit.length) // copy permit calldata
                // IPermit2.permit(address owner, PermitSingle calldata permitSingle, bytes calldata signature)
                success := call(gas(), permit2, 0, ptr, 0x164, 0, 0)
            }
            // Dynamic length
            default {
                mstore(ptr, erc7597PermitSelector)
                calldatacopy(add(ptr, 0x04), permit.offset, permit.length) // copy permit calldata
                // IERC7597Permit.permit(address owner, address spender, uint256 value, uint256 deadline, bytes memory signature)
                success := call(
                    gas(),
                    token,
                    0,
                    ptr,
                    add(permit.length, 4),
                    0,
                    0
                )
            }
        }
    }

    /**
     * @dev Executes a low level call to a token contract, making it resistant to reversion and erroneous boolean returns.
     * @param token The IERC20 token contract on which the call will be made.
     * @param selector The function signature that is to be called on the token contract.
     * @param to The address to which the token amount will be transferred.
     * @param amount The token amount to be transferred.
     * @return success A boolean indicating if the call was successful. Returns 'true' on success and 'false' on failure.
     * In case of success but no returned data, validates that the contract code exists.
     * In case of returned data, ensures that it's a boolean `true`.
     */
    function _makeCall(
        IERC20 token,
        bytes4 selector,
        address to,
        uint256 amount
    ) private returns (bool success) {
        assembly ("memory-safe") {
            // solhint-disable-line no-inline-assembly
            let data := mload(0x40)

            mstore(data, selector)
            mstore(add(data, 0x04), to)
            mstore(add(data, 0x24), amount)
            success := call(gas(), token, 0, data, 0x44, 0x0, 0x20)
            if success {
                switch returndatasize()
                case 0 {
                    success := gt(extcodesize(token), 0)
                }
                default {
                    success := and(gt(returndatasize(), 31), eq(mload(0), 1))
                }
            }
        }
    }

    /**
     * @notice Safely deposits a specified amount of Ether into the IWETH contract. Consumes less gas then regular `IWETH.deposit`.
     * @param weth The IWETH token contract.
     * @param amount The amount of Ether to deposit into the IWETH contract.
     */
    function safeDeposit(IWETH weth, uint256 amount) internal {
        bytes4 selector = IWETH.deposit.selector;
        assembly ("memory-safe") {
            // solhint-disable-line no-inline-assembly
            mstore(0, selector)
            if iszero(call(gas(), weth, amount, 0, 4, 0, 0)) {
                let ptr := mload(0x40)
                returndatacopy(ptr, 0, returndatasize())
                revert(ptr, returndatasize())
            }
        }
    }

    /**
     * @notice Safely withdraws a specified amount of wrapped Ether from the IWETH contract. Consumes less gas then regular `IWETH.withdraw`.
     * @dev Uses inline assembly to interact with the IWETH contract.
     * @param weth The IWETH token contract.
     * @param amount The amount of wrapped Ether to withdraw from the IWETH contract.
     */
    function safeWithdraw(IWETH weth, uint256 amount) internal {
        bytes4 selector = IWETH.withdraw.selector;
        assembly ("memory-safe") {
            // solhint-disable-line no-inline-assembly
            mstore(0, selector)
            mstore(4, amount)
            if iszero(call(gas(), weth, 0, 0, 0x24, 0, 0)) {
                let ptr := mload(0x40)
                returndatacopy(ptr, 0, returndatasize())
                revert(ptr, returndatasize())
            }
        }
    }

    /**
     * @notice Safely withdraws a specified amount of wrapped Ether from the IWETH contract to a specified recipient.
     * Consumes less gas then regular `IWETH.withdraw`.
     * @param weth The IWETH token contract.
     * @param amount The amount of wrapped Ether to withdraw from the IWETH contract.
     * @param to The recipient of the withdrawn Ether.
     */
    function safeWithdrawTo(IWETH weth, uint256 amount, address to) internal {
        safeWithdraw(weth, amount);
        if (to != address(this)) {
            assembly ("memory-safe") {
                // solhint-disable-line no-inline-assembly
                if iszero(call(gas(), to, amount, 0, 0, 0, 0)) {
                    let ptr := mload(0x40)
                    returndatacopy(ptr, 0, returndatasize())
                    revert(ptr, returndatasize())
                }
            }
        }
    }

    function _getPermit2Address() private view returns (address permit2) {
        assembly ("memory-safe") {
            // solhint-disable-line no-inline-assembly
            switch chainid()
            case 324 {
                // zksync mainnet
                permit2 := _PERMIT2_ZKSYNC
            }
            case 300 {
                // zksync testnet
                permit2 := _PERMIT2_ZKSYNC
            }
            case 260 {
                // zksync fork network
                permit2 := _PERMIT2_ZKSYNC
            }
            default {
                permit2 := _PERMIT2
            }
        }
    }
}

// File: @1inch/solidity-utils/contracts/mixins/EthReceiver.sol

pragma solidity ^0.8.0;

/**
 * @title EthReceiver
 * @dev Abstract contract for rejecting direct ETH transfers from EOAs.
 * Implements a custom error and logic to reject ETH deposits from non-contract addresses.
 */
abstract contract EthReceiver {
    /// @dev Error thrown when an ETH deposit from an EOA is attempted.
    error EthDepositRejected();

    /// @dev External payable function to receive ETH, automatically rejects deposits from EOAs.
    receive() external payable {
        _receive();
    }

    /**
     * @dev Internal function containing the logic to reject ETH deposits.
     * Can be overridden by derived contracts for specific behaviors while maintaining the base rejection mechanism.
     */
    function _receive() internal virtual {
        // solhint-disable-next-line avoid-tx-origin
        if (msg.sender == tx.origin) revert EthDepositRejected();
    }
}

// File: @1inch/solidity-utils/contracts/mixins/OnlyWethReceiver.sol

pragma solidity ^0.8.0;

/**
 * @title OnlyWethReceiver
 * @dev Abstract contract extending EthReceiver to accept only ETH deposits from a specified WETH contract.
 * This contract ensures that only wrapped ETH (WETH) can be deposited, rejecting all other direct ETH transfers.
 */
abstract contract OnlyWethReceiver is EthReceiver {
    /// @notice Address of the WETH contract allowed to deposit ETH.
    address private immutable _WETH; // solhint-disable-line var-name-mixedcase

    /**
     * @dev Sets the WETH contract address during construction.
     * @param weth Address of the WETH contract.
     */
    constructor(address weth) {
        _WETH = address(weth);
    }

    /**
     * @dev Overrides _receive to restrict ETH transfers solely to the WETH contract.
     * Reverts with EthDepositRejected if ETH is sent from any other address.
     */
    function _receive() internal virtual override {
        if (msg.sender != _WETH) revert EthDepositRejected();
    }
}

// File: @1inch/solidity-utils/contracts/mixins/PermitAndCall.sol

pragma solidity ^0.8.0;

/**
 * @title PermitAndCall
 * @dev Abstract contract to support permit and action execution in a single transaction.
 * Allows tokens that implement EIP-2612 permits, DAI-like permits, USDC-like permits and Permit2 to be approved and spent in a single transaction.
 */
abstract contract PermitAndCall {
    using SafeERC20 for IERC20;

    /**
     * @notice Executes a permit for an ERC20 token and then a specified action in a single transaction.
     * @param permit ERC20 token address (20 bytes) concatenated with the permit data, allowing this contract to spend the token.
     * Format: [token address (20 bytes)][permit data]
     * @param action The data representing the action to be executed after the permit.
     */
    function permitAndCall(
        bytes calldata permit,
        bytes calldata action
    ) external payable {
        IERC20(address(bytes20(permit))).tryPermit(permit[20:]);
        // solhint-disable-next-line no-inline-assembly
        assembly ("memory-safe") {
            let ptr := mload(0x40)
            calldatacopy(ptr, action.offset, action.length)
            let success := delegatecall(
                gas(),
                address(),
                ptr,
                action.length,
                0,
                0
            )
            returndatacopy(ptr, 0, returndatasize())
            switch success
            case 0 {
                revert(ptr, returndatasize())
            }
            default {
                return(ptr, returndatasize())
            }
        }
    }
}

// File: https://github.com/1inch/limit-order-protocol/blob/master/contracts/helpers/PredicateHelper.sol

pragma solidity 0.8.23;

/// @title A helper contract for executing boolean functions on arbitrary target call results
contract PredicateHelper {
    error ArbitraryStaticCallFailed();

    /// @notice Calls every target with corresponding data
    /// @return Result True if call to any target returned True. Otherwise, false
    function or(
        uint256 offsets,
        bytes calldata data
    ) public view returns (bool) {
        uint256 previous;
        for (
            uint256 current;
            (current = uint32(offsets)) != 0;
            offsets >>= 32
        ) {
            (bool success, uint256 res) = _staticcallForUint(
                address(this),
                data[previous:current]
            );
            if (success && res == 1) {
                return true;
            }
            previous = current;
        }
        return false;
    }

    /// @notice Calls every target with corresponding data
    /// @return Result True if calls to all targets returned True. Otherwise, false
    function and(
        uint256 offsets,
        bytes calldata data
    ) public view returns (bool) {
        uint256 previous;
        for (
            uint256 current;
            (current = uint32(offsets)) != 0;
            offsets >>= 32
        ) {
            (bool success, uint256 res) = _staticcallForUint(
                address(this),
                data[previous:current]
            );
            if (!success || res != 1) {
                return false;
            }
            previous = current;
        }
        return true;
    }

    /// @notice Calls target with specified data and tests if it's equal to 0
    /// @return Result True if call to target returns 0. Otherwise, false
    function not(bytes calldata data) public view returns (bool) {
        (bool success, uint256 res) = _staticcallForUint(address(this), data);
        return success && res == 0;
    }

    /// @notice Calls target with specified data and tests if it's equal to the value
    /// @param value Value to test
    /// @return Result True if call to target returns the same value as `value`. Otherwise, false
    function eq(uint256 value, bytes calldata data) public view returns (bool) {
        (bool success, uint256 res) = _staticcallForUint(address(this), data);
        return success && res == value;
    }

    /// @notice Calls target with specified data and tests if it's lower than value
    /// @param value Value to test
    /// @return Result True if call to target returns value which is lower than `value`. Otherwise, false
    function lt(uint256 value, bytes calldata data) public view returns (bool) {
        (bool success, uint256 res) = _staticcallForUint(address(this), data);
        return success && res < value;
    }

    /// @notice Calls target with specified data and tests if it's bigger than value
    /// @param value Value to test
    /// @return Result True if call to target returns value which is bigger than `value`. Otherwise, false
    function gt(uint256 value, bytes calldata data) public view returns (bool) {
        (bool success, uint256 res) = _staticcallForUint(address(this), data);
        return success && res > value;
    }

    /// @notice Performs an arbitrary call to target with data
    /// @return Result Bytes transmuted to uint256
    function arbitraryStaticCall(
        address target,
        bytes calldata data
    ) public view returns (uint256) {
        (bool success, uint256 res) = _staticcallForUint(target, data);
        if (!success) revert ArbitraryStaticCallFailed();
        return res;
    }

    function _staticcallForUint(
        address target,
        bytes calldata data
    ) internal view returns (bool success, uint256 res) {
        assembly ("memory-safe") {
            // solhint-disable-line no-inline-assembly
            let ptr := mload(0x40)

            calldatacopy(ptr, data.offset, data.length)
            success := staticcall(gas(), target, ptr, data.length, 0x0, 0x20)
            success := and(success, eq(returndatasize(), 32))
            if success {
                res := mload(0)
            }
        }
    }
}

// File: https://github.com/1inch/limit-order-protocol/blob/master/contracts/helpers/SeriesEpochManager.sol

pragma solidity 0.8.23;

/// @title A helper contract to manage nonce with the series
contract SeriesEpochManager {
    error AdvanceEpochFailed();
    event EpochIncreased(
        address indexed maker,
        uint256 series,
        uint256 newEpoch
    );

    // {
    //    1: {
    //        '0x762f73Ad...842Ffa8': 0,
    //        '0xd20c41ee...32aaDe2': 1
    //    },
    //    2: {
    //        '0x762f73Ad...842Ffa8': 3,
    //        '0xd20c41ee...32aaDe2': 15
    //    },
    //    ...
    // }
    mapping(uint256 seriesId => uint256 epoch) private _epochs;

    /// @notice Returns nonce for `maker` and `series`
    function epoch(address maker, uint96 series) public view returns (uint256) {
        return _epochs[uint160(maker) | (uint256(series) << 160)];
    }

    /// @notice Advances nonce by one
    function increaseEpoch(uint96 series) external {
        advanceEpoch(series, 1);
    }

    /// @notice Advances nonce by specified amount
    function advanceEpoch(uint96 series, uint256 amount) public {
        if (amount == 0 || amount > 255) revert AdvanceEpochFailed();
        unchecked {
            uint256 key = uint160(msg.sender) | (uint256(series) << 160);
            uint256 newEpoch = _epochs[key] + amount;
            _epochs[key] = newEpoch;
            emit EpochIncreased(msg.sender, series, newEpoch);
        }
    }

    /// @notice Checks if `maker` has specified `makerEpoch` for `series`
    /// @return Result True if `maker` has specified epoch. Otherwise, false
    function epochEquals(
        address maker,
        uint256 series,
        uint256 makerEpoch
    ) public view returns (bool) {
        return _epochs[uint160(maker) | (uint256(series) << 160)] == makerEpoch;
    }
}

// File: @1inch/solidity-utils/contracts/libraries/AddressLib.sol

pragma solidity ^0.8.0;

type Address is uint256;

/**
 * @notice AddressLib
 * @notice Library for working with addresses encoded as uint256 values, which can include flags in the highest bits.
 */
library AddressLib {
    uint256 private constant _LOW_160_BIT_MASK = (1 << 160) - 1;

    /**
     * @notice Returns the address representation of a uint256.
     * @param a The uint256 value to convert to an address.
     * @return The address representation of the provided uint256 value.
     */
    function get(Address a) internal pure returns (address) {
        return address(uint160(Address.unwrap(a) & _LOW_160_BIT_MASK));
    }

    /**
     * @notice Checks if a given flag is set for the provided address.
     * @param a The address to check for the flag.
     * @param flag The flag to check for in the provided address.
     * @return True if the provided flag is set in the address, false otherwise.
     */
    function getFlag(Address a, uint256 flag) internal pure returns (bool) {
        return (Address.unwrap(a) & flag) != 0;
    }

    /**
     * @notice Returns a uint32 value stored at a specific bit offset in the provided address.
     * @param a The address containing the uint32 value.
     * @param offset The bit offset at which the uint32 value is stored.
     * @return The uint32 value stored in the address at the specified bit offset.
     */
    function getUint32(
        Address a,
        uint256 offset
    ) internal pure returns (uint32) {
        return uint32(Address.unwrap(a) >> offset);
    }

    /**
     * @notice Returns a uint64 value stored at a specific bit offset in the provided address.
     * @param a The address containing the uint64 value.
     * @param offset The bit offset at which the uint64 value is stored.
     * @return The uint64 value stored in the address at the specified bit offset.
     */
    function getUint64(
        Address a,
        uint256 offset
    ) internal pure returns (uint64) {
        return uint64(Address.unwrap(a) >> offset);
    }
}

// File: https://github.com/1inch/limit-order-protocol/blob/master/contracts/libraries/MakerTraitsLib.sol

pragma solidity ^0.8.0;

type MakerTraits is uint256;

/**
 * @title MakerTraitsLib
 * @notice A library to manage and check MakerTraits, which are used to encode the maker's preferences for an order in a single uint256.
 * @dev
 * The MakerTraits type is a uint256 and different parts of the number are used to encode different traits.
 * High bits are used for flags
 * 255 bit `NO_PARTIAL_FILLS_FLAG`          - if set, the order does not allow partial fills
 * 254 bit `ALLOW_MULTIPLE_FILLS_FLAG`      - if set, the order permits multiple fills
 * 253 bit                                  - unused
 * 252 bit `PRE_INTERACTION_CALL_FLAG`      - if set, the order requires pre-interaction call
 * 251 bit `POST_INTERACTION_CALL_FLAG`     - if set, the order requires post-interaction call
 * 250 bit `NEED_CHECK_EPOCH_MANAGER_FLAG`  - if set, the order requires to check the epoch manager
 * 249 bit `HAS_EXTENSION_FLAG`             - if set, the order has extension(s)
 * 248 bit `USE_PERMIT2_FLAG`               - if set, the order uses permit2
 * 247 bit `UNWRAP_WETH_FLAG`               - if set, the order requires to unwrap WETH

 * Low 200 bits are used for allowed sender, expiration, nonceOrEpoch, and series
 * uint80 last 10 bytes of allowed sender address (0 if any)
 * uint40 expiration timestamp (0 if none)
 * uint40 nonce or epoch
 * uint40 series
 */
library MakerTraitsLib {
    // Low 200 bits are used for allowed sender, expiration, nonceOrEpoch, and series
    uint256 private constant _ALLOWED_SENDER_MASK = type(uint80).max;
    uint256 private constant _EXPIRATION_OFFSET = 80;
    uint256 private constant _EXPIRATION_MASK = type(uint40).max;
    uint256 private constant _NONCE_OR_EPOCH_OFFSET = 120;
    uint256 private constant _NONCE_OR_EPOCH_MASK = type(uint40).max;
    uint256 private constant _SERIES_OFFSET = 160;
    uint256 private constant _SERIES_MASK = type(uint40).max;

    uint256 private constant _NO_PARTIAL_FILLS_FLAG = 1 << 255;
    uint256 private constant _ALLOW_MULTIPLE_FILLS_FLAG = 1 << 254;
    uint256 private constant _PRE_INTERACTION_CALL_FLAG = 1 << 252;
    uint256 private constant _POST_INTERACTION_CALL_FLAG = 1 << 251;
    uint256 private constant _NEED_CHECK_EPOCH_MANAGER_FLAG = 1 << 250;
    uint256 private constant _HAS_EXTENSION_FLAG = 1 << 249;
    uint256 private constant _USE_PERMIT2_FLAG = 1 << 248;
    uint256 private constant _UNWRAP_WETH_FLAG = 1 << 247;

    /**
     * @notice Checks if the order has the extension flag set.
     * @dev If the `HAS_EXTENSION_FLAG` is set in the makerTraits, then the protocol expects that the order has extension(s).
     * @param makerTraits The traits of the maker.
     * @return result A boolean indicating whether the flag is set.
     */
    function hasExtension(
        MakerTraits makerTraits
    ) internal pure returns (bool) {
        return (MakerTraits.unwrap(makerTraits) & _HAS_EXTENSION_FLAG) != 0;
    }

    /**
     * @notice Checks if the maker allows a specific taker to fill the order.
     * @param makerTraits The traits of the maker.
     * @param sender The address of the taker to be checked.
     * @return result A boolean indicating whether the taker is allowed.
     */
    function isAllowedSender(
        MakerTraits makerTraits,
        address sender
    ) internal pure returns (bool) {
        uint160 allowedSender = uint160(
            MakerTraits.unwrap(makerTraits) & _ALLOWED_SENDER_MASK
        );
        return
            allowedSender == 0 ||
            allowedSender == uint160(sender) & _ALLOWED_SENDER_MASK;
    }

    /**
     * @notice Returns the expiration time of the order.
     * @param makerTraits The traits of the maker.
     * @return result The expiration timestamp of the order.
     */
    function getExpirationTime(
        MakerTraits makerTraits
    ) internal pure returns (uint256) {
        return
            (MakerTraits.unwrap(makerTraits) >> _EXPIRATION_OFFSET) &
            _EXPIRATION_MASK;
    }

    /**
     * @notice Checks if the order has expired.
     * @param makerTraits The traits of the maker.
     * @return result A boolean indicating whether the order has expired.
     */
    function isExpired(MakerTraits makerTraits) internal view returns (bool) {
        uint256 expiration = getExpirationTime(makerTraits);
        return expiration != 0 && expiration < block.timestamp; // solhint-disable-line not-rely-on-time
    }

    /**
     * @notice Returns the nonce or epoch of the order.
     * @param makerTraits The traits of the maker.
     * @return result The nonce or epoch of the order.
     */
    function nonceOrEpoch(
        MakerTraits makerTraits
    ) internal pure returns (uint256) {
        return
            (MakerTraits.unwrap(makerTraits) >> _NONCE_OR_EPOCH_OFFSET) &
            _NONCE_OR_EPOCH_MASK;
    }

    /**
     * @notice Returns the series of the order.
     * @param makerTraits The traits of the maker.
     * @return result The series of the order.
     */
    function series(MakerTraits makerTraits) internal pure returns (uint256) {
        return
            (MakerTraits.unwrap(makerTraits) >> _SERIES_OFFSET) & _SERIES_MASK;
    }

    /**
     * @notice Determines if the order allows partial fills.
     * @dev If the _NO_PARTIAL_FILLS_FLAG is not set in the makerTraits, then the order allows partial fills.
     * @param makerTraits The traits of the maker, determining their preferences for the order.
     * @return result A boolean indicating whether the maker allows partial fills.
     */
    function allowPartialFills(
        MakerTraits makerTraits
    ) internal pure returns (bool) {
        return (MakerTraits.unwrap(makerTraits) & _NO_PARTIAL_FILLS_FLAG) == 0;
    }

    /**
     * @notice Checks if the maker needs pre-interaction call.
     * @param makerTraits The traits of the maker.
     * @return result A boolean indicating whether the maker needs a pre-interaction call.
     */
    function needPreInteractionCall(
        MakerTraits makerTraits
    ) internal pure returns (bool) {
        return
            (MakerTraits.unwrap(makerTraits) & _PRE_INTERACTION_CALL_FLAG) != 0;
    }

    /**
     * @notice Checks if the maker needs post-interaction call.
     * @param makerTraits The traits of the maker.
     * @return result A boolean indicating whether the maker needs a post-interaction call.
     */
    function needPostInteractionCall(
        MakerTraits makerTraits
    ) internal pure returns (bool) {
        return
            (MakerTraits.unwrap(makerTraits) & _POST_INTERACTION_CALL_FLAG) !=
            0;
    }

    /**
     * @notice Determines if the order allows multiple fills.
     * @dev If the _ALLOW_MULTIPLE_FILLS_FLAG is set in the makerTraits, then the maker allows multiple fills.
     * @param makerTraits The traits of the maker, determining their preferences for the order.
     * @return result A boolean indicating whether the maker allows multiple fills.
     */
    function allowMultipleFills(
        MakerTraits makerTraits
    ) internal pure returns (bool) {
        return
            (MakerTraits.unwrap(makerTraits) & _ALLOW_MULTIPLE_FILLS_FLAG) != 0;
    }

    /**
     * @notice Determines if an order should use the bit invalidator or remaining amount validator.
     * @dev The bit invalidator can be used if the order does not allow partial or multiple fills.
     * @param makerTraits The traits of the maker, determining their preferences for the order.
     * @return result A boolean indicating whether the bit invalidator should be used.
     * True if the order requires the use of the bit invalidator.
     */
    function useBitInvalidator(
        MakerTraits makerTraits
    ) internal pure returns (bool) {
        return
            !allowPartialFills(makerTraits) || !allowMultipleFills(makerTraits);
    }

    /**
     * @notice Checks if the maker needs to check the epoch.
     * @param makerTraits The traits of the maker.
     * @return result A boolean indicating whether the maker needs to check the epoch manager.
     */
    function needCheckEpochManager(
        MakerTraits makerTraits
    ) internal pure returns (bool) {
        return
            (MakerTraits.unwrap(makerTraits) &
                _NEED_CHECK_EPOCH_MANAGER_FLAG) != 0;
    }

    /**
     * @notice Checks if the maker uses permit2.
     * @param makerTraits The traits of the maker.
     * @return result A boolean indicating whether the maker uses permit2.
     */
    function usePermit2(MakerTraits makerTraits) internal pure returns (bool) {
        return MakerTraits.unwrap(makerTraits) & _USE_PERMIT2_FLAG != 0;
    }

    /**
     * @notice Checks if the maker needs to unwraps WETH.
     * @param makerTraits The traits of the maker.
     * @return result A boolean indicating whether the maker needs to unwrap WETH.
     */
    function unwrapWeth(MakerTraits makerTraits) internal pure returns (bool) {
        return MakerTraits.unwrap(makerTraits) & _UNWRAP_WETH_FLAG != 0;
    }
}

// File: https://github.com/1inch/limit-order-protocol/blob/master/contracts/libraries/TakerTraitsLib.sol

pragma solidity ^0.8.0;

type TakerTraits is uint256;

/**
 * @title TakerTraitsLib
 * @notice This library to manage and check TakerTraits, which are used to encode the taker's preferences for an order in a single uint256.
 * @dev The TakerTraits are structured as follows:
 * High bits are used for flags
 * 255 bit `_MAKER_AMOUNT_FLAG`           - If set, the taking amount is calculated based on making amount, otherwise making amount is calculated based on taking amount.
 * 254 bit `_UNWRAP_WETH_FLAG`            - If set, the WETH will be unwrapped into ETH before sending to taker.
 * 253 bit `_SKIP_ORDER_PERMIT_FLAG`      - If set, the order skips maker's permit execution.
 * 252 bit `_USE_PERMIT2_FLAG`            - If set, the order uses the permit2 function for authorization.
 * 251 bit `_ARGS_HAS_TARGET`             - If set, then first 20 bytes of args are treated as target address for maker’s funds transfer.
 * 224-247 bits `ARGS_EXTENSION_LENGTH`   - The length of the extension calldata in the args.
 * 200-223 bits `ARGS_INTERACTION_LENGTH` - The length of the interaction calldata in the args.
 * 0-184 bits                             - The threshold amount (the maximum amount a taker agrees to give in exchange for a making amount).
 */
library TakerTraitsLib {
    uint256 private constant _MAKER_AMOUNT_FLAG = 1 << 255;
    uint256 private constant _UNWRAP_WETH_FLAG = 1 << 254;
    uint256 private constant _SKIP_ORDER_PERMIT_FLAG = 1 << 253;
    uint256 private constant _USE_PERMIT2_FLAG = 1 << 252;
    uint256 private constant _ARGS_HAS_TARGET = 1 << 251;

    uint256 private constant _ARGS_EXTENSION_LENGTH_OFFSET = 224;
    uint256 private constant _ARGS_EXTENSION_LENGTH_MASK = 0xffffff;
    uint256 private constant _ARGS_INTERACTION_LENGTH_OFFSET = 200;
    uint256 private constant _ARGS_INTERACTION_LENGTH_MASK = 0xffffff;

    uint256 private constant _AMOUNT_MASK =
        0x000000000000000000ffffffffffffffffffffffffffffffffffffffffffffff;

    /**
     * @notice Checks if the args should contain target address.
     * @param takerTraits The traits of the taker.
     * @return result A boolean indicating whether the args should contain target address.
     */
    function argsHasTarget(
        TakerTraits takerTraits
    ) internal pure returns (bool) {
        return (TakerTraits.unwrap(takerTraits) & _ARGS_HAS_TARGET) != 0;
    }

    /**
     * @notice Retrieves the length of the extension calldata from the takerTraits.
     * @param takerTraits The traits of the taker.
     * @return result The length of the extension calldata encoded in the takerTraits.
     */
    function argsExtensionLength(
        TakerTraits takerTraits
    ) internal pure returns (uint256) {
        return
            (TakerTraits.unwrap(takerTraits) >> _ARGS_EXTENSION_LENGTH_OFFSET) &
            _ARGS_EXTENSION_LENGTH_MASK;
    }

    /**
     * @notice Retrieves the length of the interaction calldata from the takerTraits.
     * @param takerTraits The traits of the taker.
     * @return result The length of the interaction calldata encoded in the takerTraits.
     */
    function argsInteractionLength(
        TakerTraits takerTraits
    ) internal pure returns (uint256) {
        return
            (TakerTraits.unwrap(takerTraits) >>
                _ARGS_INTERACTION_LENGTH_OFFSET) &
            _ARGS_INTERACTION_LENGTH_MASK;
    }

    /**
     * @notice Checks if the taking amount should be calculated based on making amount.
     * @param takerTraits The traits of the taker.
     * @return result A boolean indicating whether the taking amount should be calculated based on making amount.
     */
    function isMakingAmount(
        TakerTraits takerTraits
    ) internal pure returns (bool) {
        return (TakerTraits.unwrap(takerTraits) & _MAKER_AMOUNT_FLAG) != 0;
    }

    /**
     * @notice Checks if the order should unwrap WETH and send ETH to taker.
     * @param takerTraits The traits of the taker.
     * @return result A boolean indicating whether the order should unwrap WETH.
     */
    function unwrapWeth(TakerTraits takerTraits) internal pure returns (bool) {
        return (TakerTraits.unwrap(takerTraits) & _UNWRAP_WETH_FLAG) != 0;
    }

    /**
     * @notice Checks if the order should skip maker's permit execution.
     * @param takerTraits The traits of the taker.
     * @return result A boolean indicating whether the order don't apply permit.
     */
    function skipMakerPermit(
        TakerTraits takerTraits
    ) internal pure returns (bool) {
        return (TakerTraits.unwrap(takerTraits) & _SKIP_ORDER_PERMIT_FLAG) != 0;
    }

    /**
     * @notice Checks if the order uses the permit2 instead of permit.
     * @param takerTraits The traits of the taker.
     * @return result A boolean indicating whether the order uses the permit2.
     */
    function usePermit2(TakerTraits takerTraits) internal pure returns (bool) {
        return (TakerTraits.unwrap(takerTraits) & _USE_PERMIT2_FLAG) != 0;
    }

    /**
     * @notice Retrieves the threshold amount from the takerTraits.
     * The maximum amount a taker agrees to give in exchange for a making amount.
     * @param takerTraits The traits of the taker.
     * @return result The threshold amount encoded in the takerTraits.
     */
    function threshold(
        TakerTraits takerTraits
    ) internal pure returns (uint256) {
        return TakerTraits.unwrap(takerTraits) & _AMOUNT_MASK;
    }
}

// File: https://github.com/1inch/limit-order-protocol/blob/master/contracts/interfaces/IOrderMixin.sol

pragma solidity ^0.8.0;

/**
 * @title IOrderMixin
 * @notice Interface for order processing logic in the 1inch Limit Order Protocol.
 */
interface IOrderMixin {
    struct Order {
        uint256 salt;
        Address maker;
        Address receiver;
        Address makerAsset;
        Address takerAsset;
        uint256 makingAmount;
        uint256 takingAmount;
        MakerTraits makerTraits;
    }

    error InvalidatedOrder();
    error TakingAmountExceeded();
    error PrivateOrder();
    error BadSignature();
    error OrderExpired();
    error WrongSeriesNonce();
    error SwapWithZeroAmount();
    error PartialFillNotAllowed();
    error OrderIsNotSuitableForMassInvalidation();
    error EpochManagerAndBitInvalidatorsAreIncompatible();
    error ReentrancyDetected();
    error PredicateIsNotTrue();
    error TakingAmountTooHigh();
    error MakingAmountTooLow();
    error TransferFromMakerToTakerFailed();
    error TransferFromTakerToMakerFailed();
    error MismatchArraysLengths();
    error InvalidPermit2Transfer();
    error SimulationResults(bool success, bytes res);

    /**
     * @notice Emitted when order gets filled
     * @param orderHash Hash of the order
     * @param remainingAmount Amount of the maker asset that remains to be filled
     */
    event OrderFilled(bytes32 orderHash, uint256 remainingAmount);

    /**
     * @notice Emitted when order without `useBitInvalidator` gets cancelled
     * @param orderHash Hash of the order
     */
    event OrderCancelled(bytes32 orderHash);

    /**
     * @notice Emitted when order with `useBitInvalidator` gets cancelled
     * @param maker Maker address
     * @param slotIndex Slot index that was updated
     * @param slotValue New slot value
     */
    event BitInvalidatorUpdated(
        address indexed maker,
        uint256 slotIndex,
        uint256 slotValue
    );

    /**
     * @notice Delegates execution to custom implementation. Could be used to validate if `transferFrom` works properly
     * @dev The function always reverts and returns the simulation results in revert data.
     * @param target Addresses that will be delegated
     * @param data Data that will be passed to delegatee
     */
    function simulate(address target, bytes calldata data) external;

    /**
     * @notice Cancels order's quote
     * @param makerTraits Order makerTraits
     * @param orderHash Hash of the order to cancel
     */
    function cancelOrder(MakerTraits makerTraits, bytes32 orderHash) external;

    /**
     * @notice Cancels orders' quotes
     * @param makerTraits Orders makerTraits
     * @param orderHashes Hashes of the orders to cancel
     */
    function cancelOrders(
        MakerTraits[] calldata makerTraits,
        bytes32[] calldata orderHashes
    ) external;

    /**
     * @notice Cancels all quotes of the maker (works for bit-invalidating orders only)
     * @param makerTraits Order makerTraits
     * @param additionalMask Additional bitmask to invalidate orders
     */
    function bitsInvalidateForOrder(
        MakerTraits makerTraits,
        uint256 additionalMask
    ) external;

    /**
     * @notice Fills order's quote, fully or partially (whichever is possible).
     * @param order Order quote to fill
     * @param r R component of signature
     * @param vs VS component of signature
     * @param amount Taker amount to fill
     * @param takerTraits Specifies threshold as maximum allowed takingAmount when takingAmount is zero, otherwise specifies
     * minimum allowed makingAmount. The 2nd (0 based index) highest bit specifies whether taker wants to skip maker's permit.
     * @return makingAmount Actual amount transferred from maker to taker
     * @return takingAmount Actual amount transferred from taker to maker
     * @return orderHash Hash of the filled order
     */
    function fillOrder(
        Order calldata order,
        bytes32 r,
        bytes32 vs,
        uint256 amount,
        TakerTraits takerTraits
    )
        external
        payable
        returns (uint256 makingAmount, uint256 takingAmount, bytes32 orderHash);

    /**
     * @notice Same as `fillOrder` but allows to specify arguments that are used by the taker.
     * @param order Order quote to fill
     * @param r R component of signature
     * @param vs VS component of signature
     * @param amount Taker amount to fill
     * @param takerTraits Specifies threshold as maximum allowed takingAmount when takingAmount is zero, otherwise specifies
     * minimum allowed makingAmount. The 2nd (0 based index) highest bit specifies whether taker wants to skip maker's permit.
     * @param args Arguments that are used by the taker (target, extension, interaction, permit)
     * @return makingAmount Actual amount transferred from maker to taker
     * @return takingAmount Actual amount transferred from taker to maker
     * @return orderHash Hash of the filled order
     */
    function fillOrderArgs(
        IOrderMixin.Order calldata order,
        bytes32 r,
        bytes32 vs,
        uint256 amount,
        TakerTraits takerTraits,
        bytes calldata args
    )
        external
        payable
        returns (uint256 makingAmount, uint256 takingAmount, bytes32 orderHash);

    /**
     * @notice Same as `fillOrder` but uses contract-based signatures.
     * @param order Order quote to fill
     * @param signature Signature to confirm quote ownership
     * @param amount Taker amount to fill
     * @param takerTraits Specifies threshold as maximum allowed takingAmount when takingAmount is zero, otherwise specifies
     * minimum allowed makingAmount. The 2nd (0 based index) highest bit specifies whether taker wants to skip maker's permit.
     * @return makingAmount Actual amount transferred from maker to taker
     * @return takingAmount Actual amount transferred from taker to maker
     * @return orderHash Hash of the filled order
     * @dev See tests for examples
     */
    function fillContractOrder(
        Order calldata order,
        bytes calldata signature,
        uint256 amount,
        TakerTraits takerTraits
    )
        external
        returns (uint256 makingAmount, uint256 takingAmount, bytes32 orderHash);

    /**
     * @notice Same as `fillContractOrder` but allows to specify arguments that are used by the taker.
     * @param order Order quote to fill
     * @param signature Signature to confirm quote ownership
     * @param amount Taker amount to fill
     * @param takerTraits Specifies threshold as maximum allowed takingAmount when takingAmount is zero, otherwise specifies
     * minimum allowed makingAmount. The 2nd (0 based index) highest bit specifies whether taker wants to skip maker's permit.
     * @param args Arguments that are used by the taker (target, extension, interaction, permit)
     * @return makingAmount Actual amount transferred from maker to taker
     * @return takingAmount Actual amount transferred from taker to maker
     * @return orderHash Hash of the filled order
     * @dev See tests for examples
     */
    function fillContractOrderArgs(
        Order calldata order,
        bytes calldata signature,
        uint256 amount,
        TakerTraits takerTraits,
        bytes calldata args
    )
        external
        returns (uint256 makingAmount, uint256 takingAmount, bytes32 orderHash);

    /**
     * @notice Returns bitmask for double-spend invalidators based on lowest byte of order.info and filled quotes
     * @param maker Maker address
     * @param slot Slot number to return bitmask for
     * @return result Each bit represents whether corresponding was already invalidated
     */
    function bitInvalidatorForOrder(
        address maker,
        uint256 slot
    ) external view returns (uint256 result);

    /**
     * @notice Returns bitmask for double-spend invalidators based on lowest byte of order.info and filled quotes
     * @param orderHash Hash of the order
     * @return remaining Remaining amount of the order
     */
    function remainingInvalidatorForOrder(
        address maker,
        bytes32 orderHash
    ) external view returns (uint256 remaining);

    /**
     * @notice Returns bitmask for double-spend invalidators based on lowest byte of order.info and filled quotes
     * @param orderHash Hash of the order
     * @return remainingRaw Inverse of the remaining amount of the order if order was filled at least once, otherwise 0
     */
    function rawRemainingInvalidatorForOrder(
        address maker,
        bytes32 orderHash
    ) external view returns (uint256 remainingRaw);

    /**
     * @notice Returns order hash, hashed with limit order protocol contract EIP712
     * @param order Order
     * @return orderHash Hash of the order
     */
    function hashOrder(
        IOrderMixin.Order calldata order
    ) external view returns (bytes32 orderHash);
}

// File: https://github.com/1inch/limit-order-protocol/blob/master/contracts/interfaces/ITakerInteraction.sol

pragma solidity ^0.8.0;

/**
 * @title Interface for interactor which acts after `maker -> taker` transfer but before `taker -> maker` transfer.
 * @notice The order filling steps are `preInteraction` =>` Transfer "maker -> taker"` => **`Interaction`** => `Transfer "taker -> maker"` => `postInteraction`
 */
interface ITakerInteraction {
    /**
     * @dev This callback allows to interactively handle maker aseets to produce takers assets, doesn't supports ETH as taker assets
     * @notice Callback method that gets called after maker fund transfer but before taker fund transfer
     * @param order Order being processed
     * @param extension Order extension data
     * @param orderHash Hash of the order being processed
     * @param taker Taker address
     * @param makingAmount Actual making amount
     * @param takingAmount Actual taking amount
     * @param remainingMakingAmount Order remaining making amount
     * @param extraData Extra data
     */
    function takerInteraction(
        IOrderMixin.Order calldata order,
        bytes calldata extension,
        bytes32 orderHash,
        address taker,
        uint256 makingAmount,
        uint256 takingAmount,
        uint256 remainingMakingAmount,
        bytes calldata extraData
    ) external;
}

// File: https://github.com/1inch/limit-order-protocol/blob/master/contracts/interfaces/IPreInteraction.sol

pragma solidity ^0.8.0;

interface IPreInteraction {
    /**
     * @notice Callback method that gets called before any funds transfers
     * @param order Order being processed
     * @param extension Order extension data
     * @param orderHash Hash of the order being processed
     * @param taker Taker address
     * @param makingAmount Actual making amount
     * @param takingAmount Actual taking amount
     * @param remainingMakingAmount Order remaining making amount
     * @param extraData Extra data
     */
    function preInteraction(
        IOrderMixin.Order calldata order,
        bytes calldata extension,
        bytes32 orderHash,
        address taker,
        uint256 makingAmount,
        uint256 takingAmount,
        uint256 remainingMakingAmount,
        bytes calldata extraData
    ) external;
}

// File: https://github.com/1inch/limit-order-protocol/blob/master/contracts/interfaces/IPostInteraction.sol

pragma solidity ^0.8.0;

interface IPostInteraction {
    /**
     * @notice Callback method that gets called after all fund transfers
     * @param order Order being processed
     * @param extension Order extension data
     * @param orderHash Hash of the order being processed
     * @param taker Taker address
     * @param makingAmount Actual making amount
     * @param takingAmount Actual taking amount
     * @param remainingMakingAmount Order remaining making amount
     * @param extraData Extra data
     */
    function postInteraction(
        IOrderMixin.Order calldata order,
        bytes calldata extension,
        bytes32 orderHash,
        address taker,
        uint256 makingAmount,
        uint256 takingAmount,
        uint256 remainingMakingAmount,
        bytes calldata extraData
    ) external;
}

// File: https://github.com/1inch/limit-order-protocol/blob/master/contracts/libraries/Errors.sol

pragma solidity ^0.8.0;

library Errors {
    error InvalidMsgValue();
    error ETHTransferFailed();
}

// File: https://github.com/1inch/limit-order-protocol/blob/master/contracts/libraries/BitInvalidatorLib.sol

pragma solidity ^0.8.0;

/**
 * @title BitInvalidatorLib
 * @dev The library provides a mechanism to invalidate objects based on a bit invalidator.
 * The bit invalidator holds a mapping where each key represents a slot number and each value contains an integer.
 * Each bit of the integer represents whether the object with corresponding index is valid or has been invalidated (0 - valid, 1 - invalidated).
 * The nonce given to access or invalidate an entity's state follows this structure:
 * - bits [0..7] represent the object state index in the slot.
 * - bits [8..255] represent the slot number (mapping key).
 */
library BitInvalidatorLib {
    /// @dev The error is thrown when an attempt is made to invalidate an already invalidated entity.
    error BitInvalidatedOrder();

    struct Data {
        mapping(uint256 slotIndex => uint256 slotData) _raw;
    }

    /**
     * @notice Retrieves the validity status of entities in a specific slot.
     * @dev Each bit in the returned value corresponds to the validity of an entity. 0 for valid, 1 for invalidated.
     * @param self The data structure.
     * @param nonce The nonce identifying the slot.
     * @return result The validity status of entities in the slot as a uint256.
     */
    function checkSlot(
        Data storage self,
        uint256 nonce
    ) internal view returns (uint256) {
        uint256 invalidatorSlot = nonce >> 8;
        return self._raw[invalidatorSlot];
    }

    /**
     * @notice Checks the validity of a specific entity and invalidates it if valid.
     * @dev Throws an error if the entity has already been invalidated.
     * @param self The data structure.
     * @param nonce The nonce identifying the slot and the entity.
     */
    function checkAndInvalidate(Data storage self, uint256 nonce) internal {
        uint256 invalidatorSlot = nonce >> 8;
        uint256 invalidatorBit = 1 << (nonce & 0xff);
        uint256 invalidator = self._raw[invalidatorSlot];
        if (invalidator & invalidatorBit == invalidatorBit)
            revert BitInvalidatedOrder();
        self._raw[invalidatorSlot] = invalidator | invalidatorBit;
    }

    /**
     * @notice Invalidates multiple entities in a single slot.
     * @dev The entities to be invalidated are identified by setting their corresponding bits to 1 in a mask.
     * @param self The data structure.
     * @param nonce The nonce identifying the slot.
     * @param additionalMask A mask of bits to be invalidated.
     * @return result Resulting validity status of entities in the slot as a uint256.
     */
    function massInvalidate(
        Data storage self,
        uint256 nonce,
        uint256 additionalMask
    ) internal returns (uint256 result) {
        uint256 invalidatorSlot = nonce >> 8;
        uint256 invalidatorBits = (1 << (nonce & 0xff)) | additionalMask;
        result = self._raw[invalidatorSlot] | invalidatorBits;
        self._raw[invalidatorSlot] = result;
    }
}

// File: https://github.com/1inch/limit-order-protocol/blob/master/contracts/libraries/RemainingInvalidatorLib.sol

pragma solidity ^0.8.0;

type RemainingInvalidator is uint256;

/**
 * @title RemainingInvalidatorLib
 * @notice The library provides a mechanism to invalidate order based on the remaining amount of the order.
 * @dev The remaining amount is used as a nonce to invalidate the order.
 * When order is created, the remaining invalidator is 0.
 * When order is filled, the remaining invalidator is the inverse of the remaining amount.
 */
library RemainingInvalidatorLib {
    /// @dev The error is thrown when an attempt is made to invalidate an already invalidated entity.
    error RemainingInvalidatedOrder();

    /**
     * @notice Checks if an order is new based on the invalidator value.
     * @param invalidator The remaining invalidator of the order.
     * @return result Whether the order is new or not.
     */
    function isNewOrder(
        RemainingInvalidator invalidator
    ) internal pure returns (bool) {
        return RemainingInvalidator.unwrap(invalidator) == 0;
    }

    /**
     * @notice Retrieves the remaining amount for an order.
     * @dev If the order is unknown, a RemainingInvalidatedOrder error is thrown.
     * @param invalidator The remaining invalidator for the order.
     * @return result The remaining amount for the order.
     */
    function remaining(
        RemainingInvalidator invalidator
    ) internal pure returns (uint256) {
        uint256 value = RemainingInvalidator.unwrap(invalidator);
        if (value == 0) {
            revert RemainingInvalidatedOrder();
        }
        unchecked {
            return ~value;
        }
    }

    /**
     * @notice Calculates the remaining amount for an order.
     * @dev If the order is unknown, the order maker amount is returned.
     * @param invalidator The remaining invalidator for the order.
     * @param orderMakerAmount The amount to return if the order is new.
     * @return result The remaining amount for the order.
     */
    function remaining(
        RemainingInvalidator invalidator,
        uint256 orderMakerAmount
    ) internal pure returns (uint256) {
        uint256 value = RemainingInvalidator.unwrap(invalidator);
        if (value == 0) {
            return orderMakerAmount;
        }
        unchecked {
            return ~value;
        }
    }

    /**
     * @notice Calculates the remaining invalidator of the order.
     * @param remainingMakingAmount The remaining making amount of the order.
     * @param makingAmount The making amount of the order.
     * @return result The remaining invalidator for the order.
     */
    function remains(
        uint256 remainingMakingAmount,
        uint256 makingAmount
    ) internal pure returns (RemainingInvalidator) {
        unchecked {
            return
                RemainingInvalidator.wrap(
                    ~(remainingMakingAmount - makingAmount)
                );
        }
    }

    /**
     * @notice Provides the remaining invalidator for a fully filled order.
     * @return result The remaining invalidator for a fully filled order.
     */
    function fullyFilled() internal pure returns (RemainingInvalidator) {
        return RemainingInvalidator.wrap(type(uint256).max);
    }
}

// File: @openzeppelin/contracts/interfaces/IERC1271.sol

// OpenZeppelin Contracts (last updated v5.4.0) (interfaces/IERC1271.sol)

pragma solidity >=0.5.0;

/**
 * @dev Interface of the ERC-1271 standard signature validation method for
 * contracts as defined in https://eips.ethereum.org/EIPS/eip-1271[ERC-1271].
 */
interface IERC1271 {
    /**
     * @dev Should return whether the signature provided is valid for the provided data
     * @param hash      Hash of the data to be signed
     * @param signature Signature byte array associated with `hash`
     */
    function isValidSignature(
        bytes32 hash,
        bytes calldata signature
    ) external view returns (bytes4 magicValue);
}

// File: @1inch/solidity-utils/contracts/libraries/ECDSA.sol

pragma solidity ^0.8.0;

/**
 * @title ECDSA signature operations
 * @notice Provides functions for recovering addresses from signatures and verifying signatures, including support for EIP-2098 compact signatures.
 */
library ECDSA {
    // EIP-2 still allows signature malleability for ecrecover(). Remove this possibility and make the signature
    // unique. Appendix F in the Ethereum Yellow paper (https://ethereum.github.io/yellowpaper/paper.pdf), defines
    // the valid range for s in (301): 0 < s < secp256k1n ÷ 2 + 1, and for v in (302): v ∈ {27, 28}. Most
    // signatures from current libraries generate a unique signature with an s-value in the lower half order.
    //
    // If your library generates malleable signatures, such as s-values in the upper range, calculate a new s-value
    // with 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141 - s1 and flip v from 27 to 28 or
    // vice versa. If your library also generates signatures with 0/1 for v instead 27/28, add 27 to v to accept
    // these malleable signatures as well.
    uint256 private constant _S_BOUNDARY =
        0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5D576E7357A4501DDFE92F46681B20A0 + 1;
    uint256 private constant _COMPACT_S_MASK =
        0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
    uint256 private constant _COMPACT_V_SHIFT = 255;

    /**
     * @notice Recovers the signer's address from the signature.
     * @dev Recovers the address that has signed a hash with `(v, r, s)` signature.
     * @param hash The keccak256 hash of the data signed.
     * @param v The recovery byte of the signature.
     * @param r The first 32 bytes of the signature.
     * @param s The second 32 bytes of the signature.
     * @return signer The address of the signer.
     */
    function recover(
        bytes32 hash,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) internal view returns (address signer) {
        assembly ("memory-safe") {
            // solhint-disable-line no-inline-assembly
            if lt(s, _S_BOUNDARY) {
                let ptr := mload(0x40)

                mstore(ptr, hash)
                mstore(add(ptr, 0x20), v)
                mstore(add(ptr, 0x40), r)
                mstore(add(ptr, 0x60), s)
                mstore(0, 0)
                pop(staticcall(gas(), 0x1, ptr, 0x80, 0, 0x20))
                signer := mload(0)
            }
        }
    }

    /**
     * @notice Recovers the signer's address from the signature using `r` and `vs` components.
     * @dev Recovers the address that has signed a hash with `r` and `vs`, where `vs` combines `v` and `s`.
     * @param hash The keccak256 hash of the data signed.
     * @param r The first 32 bytes of the signature.
     * @param vs The combined `v` and `s` values of the signature.
     * @return signer The address of the signer.
     */
    function recover(
        bytes32 hash,
        bytes32 r,
        bytes32 vs
    ) internal view returns (address signer) {
        assembly ("memory-safe") {
            // solhint-disable-line no-inline-assembly
            let s := and(vs, _COMPACT_S_MASK)
            if lt(s, _S_BOUNDARY) {
                let ptr := mload(0x40)

                mstore(ptr, hash)
                mstore(add(ptr, 0x20), add(27, shr(_COMPACT_V_SHIFT, vs)))
                mstore(add(ptr, 0x40), r)
                mstore(add(ptr, 0x60), s)
                mstore(0, 0)
                pop(staticcall(gas(), 0x1, ptr, 0x80, 0, 0x20))
                signer := mload(0)
            }
        }
    }

    /**
     * @notice Recovers the signer's address from a hash and a signature.
     * @param hash The keccak256 hash of the signed data.
     * @param signature The full signature from which the signer will be recovered.
     * @return signer The address of the signer.
     */
    /// @dev WARNING!!!
    /// There is a known signature malleability issue with two representations of signatures!
    /// Even though this function is able to verify both standard 65-byte and compact 64-byte EIP-2098 signatures
    /// one should never use raw signatures for any kind of invalidation logic in their code.
    /// As the standard and compact representations are interchangeable any invalidation logic that relies on
    /// signature uniqueness will get rekt.
    /// More info: https://github.com/OpenZeppelin/openzeppelin-contracts/security/advisories/GHSA-4h98-2769-gh6h
    function recover(
        bytes32 hash,
        bytes calldata signature
    ) internal view returns (address signer) {
        assembly ("memory-safe") {
            // solhint-disable-line no-inline-assembly
            let ptr := mload(0x40)

            // memory[ptr:ptr+0x80] = (hash, v, r, s)
            switch signature.length
            case 65 {
                // memory[ptr+0x20:ptr+0x80] = (v, r, s)
                mstore(
                    add(ptr, 0x20),
                    byte(0, calldataload(add(signature.offset, 0x40)))
                )
                calldatacopy(add(ptr, 0x40), signature.offset, 0x40)
            }
            case 64 {
                // memory[ptr+0x20:ptr+0x80] = (v, r, s)
                let vs := calldataload(add(signature.offset, 0x20))
                mstore(add(ptr, 0x20), add(27, shr(_COMPACT_V_SHIFT, vs)))
                calldatacopy(add(ptr, 0x40), signature.offset, 0x20)
                mstore(add(ptr, 0x60), and(vs, _COMPACT_S_MASK))
            }
            default {
                ptr := 0
            }

            if ptr {
                if lt(mload(add(ptr, 0x60)), _S_BOUNDARY) {
                    // memory[ptr:ptr+0x20] = (hash)
                    mstore(ptr, hash)

                    mstore(0, 0)
                    pop(staticcall(gas(), 0x1, ptr, 0x80, 0, 0x20))
                    signer := mload(0)
                }
            }
        }
    }

    /**
     * @notice Verifies the signature for a hash, either by recovering the signer or using EIP-1271's `isValidSignature` function.
     * @dev Attempts to recover the signer's address from the signature; if the address is non-zero, checks if it's valid according to EIP-1271.
     * @param signer The address to validate the signature against.
     * @param hash The hash of the signed data.
     * @param signature The signature to verify.
     * @return success True if the signature is verified, false otherwise.
     */
    function recoverOrIsValidSignature(
        address signer,
        bytes32 hash,
        bytes calldata signature
    ) internal view returns (bool success) {
        if (signer == address(0)) return false;
        if (
            (signature.length == 64 || signature.length == 65) &&
            recover(hash, signature) == signer
        ) {
            return true;
        }
        return isValidSignature(signer, hash, signature);
    }

    /**
     * @notice Verifies the signature for a hash, either by recovering the signer or using EIP-1271's `isValidSignature` function.
     * @dev Attempts to recover the signer's address from the signature; if the address is non-zero, checks if it's valid according to EIP-1271.
     * @param signer The address to validate the signature against.
     * @param hash The hash of the signed data.
     * @param v The recovery byte of the signature.
     * @param r The first 32 bytes of the signature.
     * @param s The second 32 bytes of the signature.
     * @return success True if the signature is verified, false otherwise.
     */
    function recoverOrIsValidSignature(
        address signer,
        bytes32 hash,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) internal view returns (bool success) {
        if (signer == address(0)) return false;
        if (recover(hash, v, r, s) == signer) {
            return true;
        }
        return isValidSignature(signer, hash, v, r, s);
    }

    /**
     * @notice Verifies the signature for a hash, either by recovering the signer or using EIP-1271's `isValidSignature` function.
     * @dev Attempts to recover the signer's address from the signature; if the address is non-zero, checks if it's valid according to EIP-1271.
     * @param signer The address to validate the signature against.
     * @param hash The hash of the signed data.
     * @param r The first 32 bytes of the signature.
     * @param vs The combined `v` and `s` values of the signature.
     * @return success True if the signature is verified, false otherwise.
     */
    function recoverOrIsValidSignature(
        address signer,
        bytes32 hash,
        bytes32 r,
        bytes32 vs
    ) internal view returns (bool success) {
        if (signer == address(0)) return false;
        if (recover(hash, r, vs) == signer) {
            return true;
        }
        return isValidSignature(signer, hash, r, vs);
    }

    /**
     * @notice Verifies the signature for a given hash, attempting to recover the signer's address or validates it using EIP-1271 for 65-byte signatures.
     * @dev Attempts to recover the signer's address from the signature. If the address is a contract, checks if the signature is valid according to EIP-1271.
     * @param signer The expected signer's address.
     * @param hash The keccak256 hash of the signed data.
     * @param r The first 32 bytes of the signature.
     * @param vs The last 32 bytes of the signature, with the last byte being the recovery id.
     * @return success True if the signature is valid, false otherwise.
     */
    function recoverOrIsValidSignature65(
        address signer,
        bytes32 hash,
        bytes32 r,
        bytes32 vs
    ) internal view returns (bool success) {
        if (signer == address(0)) return false;
        if (recover(hash, r, vs) == signer) {
            return true;
        }
        return isValidSignature65(signer, hash, r, vs);
    }

    /**
     * @notice Validates a signature for a hash using EIP-1271, if `signer` is a contract.
     * @dev Makes a static call to `signer` with `isValidSignature` function selector from EIP-1271.
     * @param signer The address of the signer to validate against, which could be an EOA or a contract.
     * @param hash The hash of the signed data.
     * @param signature The signature to validate.
     * @return success True if the signature is valid according to EIP-1271, false otherwise.
     */
    function isValidSignature(
        address signer,
        bytes32 hash,
        bytes calldata signature
    ) internal view returns (bool success) {
        // (bool success, bytes memory data) = signer.staticcall(abi.encodeWithSelector(IERC1271.isValidSignature.selector, hash, signature));
        // return success && data.length == 32 && abi.decode(data, (bytes4)) == IERC1271.isValidSignature.selector;
        bytes4 selector = IERC1271.isValidSignature.selector;
        assembly ("memory-safe") {
            // solhint-disable-line no-inline-assembly
            let ptr := mload(0x40)

            mstore(ptr, selector)
            mstore(add(ptr, 0x04), hash)
            mstore(add(ptr, 0x24), 0x40)
            mstore(add(ptr, 0x44), signature.length)
            calldatacopy(add(ptr, 0x64), signature.offset, signature.length)
            if staticcall(
                gas(),
                signer,
                ptr,
                add(0x64, signature.length),
                0,
                0x20
            ) {
                success := and(
                    eq(selector, mload(0)),
                    eq(returndatasize(), 0x20)
                )
            }
        }
    }

    /**
     * @notice Validates a signature for a hash using EIP-1271, if `signer` is a contract.
     * @dev Makes a static call to `signer` with `isValidSignature` function selector from EIP-1271.
     * @param signer The address of the signer to validate against, which could be an EOA or a contract.
     * @param hash The hash of the signed data.
     * @param v The recovery byte of the signature.
     * @param r The first 32 bytes of the signature.
     * @param s The second 32 bytes of the signature.
     * @return success True if the signature is valid according to EIP-1271, false otherwise.
     */
    function isValidSignature(
        address signer,
        bytes32 hash,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) internal view returns (bool success) {
        bytes4 selector = IERC1271.isValidSignature.selector;
        assembly ("memory-safe") {
            // solhint-disable-line no-inline-assembly
            let ptr := mload(0x40)

            mstore(ptr, selector)
            mstore(add(ptr, 0x04), hash)
            mstore(add(ptr, 0x24), 0x40)
            mstore(add(ptr, 0x44), 65)
            mstore(add(ptr, 0x64), r)
            mstore(add(ptr, 0x84), s)
            mstore8(add(ptr, 0xa4), v)
            if staticcall(gas(), signer, ptr, 0xa5, 0, 0x20) {
                success := and(
                    eq(selector, mload(0)),
                    eq(returndatasize(), 0x20)
                )
            }
        }
    }

    /**
     * @notice Validates a signature for a hash using EIP-1271, if `signer` is a contract.
     * @dev Makes a static call to `signer` with `isValidSignature` function selector from EIP-1271.
     * @param signer The address of the signer to validate against, which could be an EOA or a contract.
     * @param hash The hash of the signed data.
     * @param r The first 32 bytes of the signature.
     * @param vs The last 32 bytes of the signature, with the last byte being the recovery id.
     * @return success True if the signature is valid according to EIP-1271, false otherwise.
     */
    function isValidSignature(
        address signer,
        bytes32 hash,
        bytes32 r,
        bytes32 vs
    ) internal view returns (bool success) {
        // (bool success, bytes memory data) = signer.staticcall(abi.encodeWithSelector(IERC1271.isValidSignature.selector, hash, abi.encodePacked(r, vs)));
        // return success && data.length == 32 && abi.decode(data, (bytes4)) == IERC1271.isValidSignature.selector;
        bytes4 selector = IERC1271.isValidSignature.selector;
        assembly ("memory-safe") {
            // solhint-disable-line no-inline-assembly
            let ptr := mload(0x40)

            mstore(ptr, selector)
            mstore(add(ptr, 0x04), hash)
            mstore(add(ptr, 0x24), 0x40)
            mstore(add(ptr, 0x44), 64)
            mstore(add(ptr, 0x64), r)
            mstore(add(ptr, 0x84), vs)
            if staticcall(gas(), signer, ptr, 0xa4, 0, 0x20) {
                success := and(
                    eq(selector, mload(0)),
                    eq(returndatasize(), 0x20)
                )
            }
        }
    }

    /**
     * @notice Verifies if a 65-byte signature is valid for a given hash, according to EIP-1271.
     * @param signer The address of the signer to validate against, which could be an EOA or a contract.
     * @param hash The hash of the signed data.
     * @param r The first 32 bytes of the signature.
     * @param vs The combined `v` (recovery id) and `s` component of the signature, packed into the last 32 bytes.
     * @return success True if the signature is valid according to EIP-1271, false otherwise.
     */
    function isValidSignature65(
        address signer,
        bytes32 hash,
        bytes32 r,
        bytes32 vs
    ) internal view returns (bool success) {
        // (bool success, bytes memory data) = signer.staticcall(abi.encodeWithSelector(IERC1271.isValidSignature.selector, hash, abi.encodePacked(r, vs & ~uint256(1 << 255), uint8(vs >> 255))));
        // return success && data.length == 32 && abi.decode(data, (bytes4)) == IERC1271.isValidSignature.selector;
        bytes4 selector = IERC1271.isValidSignature.selector;
        assembly ("memory-safe") {
            // solhint-disable-line no-inline-assembly
            let ptr := mload(0x40)

            mstore(ptr, selector)
            mstore(add(ptr, 0x04), hash)
            mstore(add(ptr, 0x24), 0x40)
            mstore(add(ptr, 0x44), 65)
            mstore(add(ptr, 0x64), r)
            mstore(add(ptr, 0x84), and(vs, _COMPACT_S_MASK))
            mstore8(add(ptr, 0xa4), add(27, shr(_COMPACT_V_SHIFT, vs)))
            if staticcall(gas(), signer, ptr, 0xa5, 0, 0x20) {
                success := and(
                    eq(selector, mload(0)),
                    eq(returndatasize(), 0x20)
                )
            }
        }
    }

    /**
     * @notice Generates a hash compatible with Ethereum's signed message format.
     * @dev Prepends the hash with Ethereum's message prefix before hashing it.
     * @param hash The hash of the data to sign.
     * @return res The Ethereum signed message hash.
     */
    function toEthSignedMessageHash(
        bytes32 hash
    ) internal pure returns (bytes32 res) {
        // 32 is the length in bytes of hash, enforced by the type signature above
        // return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
        assembly ("memory-safe") {
            // solhint-disable-line no-inline-assembly
            mstore(
                0,
                0x19457468657265756d205369676e6564204d6573736167653a0a333200000000
            ) // "\x19Ethereum Signed Message:\n32"
            mstore(28, hash)
            res := keccak256(0, 60)
        }
    }

    /**
     * @notice Generates an EIP-712 compliant hash.
     * @dev Encodes the domain separator and the struct hash according to EIP-712.
     * @param domainSeparator The EIP-712 domain separator.
     * @param structHash The EIP-712 struct hash.
     * @return res The EIP-712 compliant hash.
     */
    function toTypedDataHash(
        bytes32 domainSeparator,
        bytes32 structHash
    ) internal pure returns (bytes32 res) {
        // return keccak256(abi.encodePacked("\x19\x01", domainSeparator, structHash));
        assembly ("memory-safe") {
            // solhint-disable-line no-inline-assembly
            let ptr := mload(0x40)
            mstore(
                ptr,
                0x1901000000000000000000000000000000000000000000000000000000000000
            ) // "\x19\x01"
            mstore(add(ptr, 0x02), domainSeparator)
            mstore(add(ptr, 0x22), structHash)
            res := keccak256(ptr, 66)
        }
    }
}

// File: https://github.com/1inch/limit-order-protocol/blob/master/contracts/libraries/OffsetsLib.sol

pragma solidity ^0.8.0;

type Offsets is uint256;

/// @title OffsetsLib
/// @dev A library for retrieving values by offsets from a concatenated calldata.
library OffsetsLib {
    /// @dev Error to be thrown when the offset is out of bounds.
    error OffsetOutOfBounds();

    /**
     * @notice Retrieves the field value calldata corresponding to the provided field index from the concatenated calldata.
     * @dev
     * The function performs the following steps:
     * 1. Retrieve the start and end of the segment corresponding to the provided index from the offsets array.
     * 2. Get the value from segment using offset and length calculated based on the start and end of the segment.
     * 3. Throw `OffsetOutOfBounds` error if the length of the segment is greater than the length of the concatenated data.
     * @param offsets The offsets encoding the start and end of each segment within the concatenated calldata.
     * @param concat The concatenated calldata.
     * @param index The index of the segment to retrieve. The field index 0 corresponds to the lowest bytes of the offsets array.
     * @return result The calldata from a segment of the concatenated calldata corresponding to the provided index.
     */
    function get(
        Offsets offsets,
        bytes calldata concat,
        uint256 index
    ) internal pure returns (bytes calldata result) {
        bytes4 exception = OffsetOutOfBounds.selector;
        assembly ("memory-safe") {
            // solhint-disable-line no-inline-assembly
            let bitShift := shl(5, index) // bitShift = index * 32
            let begin := and(0xffffffff, shr(bitShift, shl(32, offsets))) // begin = offsets[ bitShift : bitShift + 32 ]
            let end := and(0xffffffff, shr(bitShift, offsets)) // end   = offsets[ bitShift + 32 : bitShift + 64 ]
            result.offset := add(concat.offset, begin)
            result.length := sub(end, begin)
            if gt(end, concat.length) {
                mstore(0, exception)
                revert(0, 4)
            }
        }
    }
}

// File: https://github.com/1inch/limit-order-protocol/blob/master/contracts/libraries/ExtensionLib.sol

pragma solidity ^0.8.0;

/**
 * @title ExtensionLib
 * @notice Library for retrieving extensions information for the IOrderMixin Interface.
 */
library ExtensionLib {
    using AddressLib for Address;
    using OffsetsLib for Offsets;

    enum DynamicField {
        MakerAssetSuffix,
        TakerAssetSuffix,
        MakingAmountData,
        TakingAmountData,
        Predicate,
        MakerPermit,
        PreInteractionData,
        PostInteractionData,
        CustomData
    }

    /**
     * @notice Returns the MakerAssetSuffix from the provided extension calldata.
     * @param extension The calldata from which the MakerAssetSuffix is to be retrieved.
     * @return calldata Bytes representing the MakerAssetSuffix.
     */
    function makerAssetSuffix(
        bytes calldata extension
    ) internal pure returns (bytes calldata) {
        return _get(extension, DynamicField.MakerAssetSuffix);
    }

    /**
     * @notice Returns the TakerAssetSuffix from the provided extension calldata.
     * @param extension The calldata from which the TakerAssetSuffix is to be retrieved.
     * @return calldata Bytes representing the TakerAssetSuffix.
     */
    function takerAssetSuffix(
        bytes calldata extension
    ) internal pure returns (bytes calldata) {
        return _get(extension, DynamicField.TakerAssetSuffix);
    }

    /**
     * @notice Returns the MakingAmountData from the provided extension calldata.
     * @param extension The calldata from which the MakingAmountData is to be retrieved.
     * @return calldata Bytes representing the MakingAmountData.
     */
    function makingAmountData(
        bytes calldata extension
    ) internal pure returns (bytes calldata) {
        return _get(extension, DynamicField.MakingAmountData);
    }

    /**
     * @notice Returns the TakingAmountData from the provided extension calldata.
     * @param extension The calldata from which the TakingAmountData is to be retrieved.
     * @return calldata Bytes representing the TakingAmountData.
     */
    function takingAmountData(
        bytes calldata extension
    ) internal pure returns (bytes calldata) {
        return _get(extension, DynamicField.TakingAmountData);
    }

    /**
     * @notice Returns the order's predicate from the provided extension calldata.
     * @param extension The calldata from which the predicate is to be retrieved.
     * @return calldata Bytes representing the predicate.
     */
    function predicate(
        bytes calldata extension
    ) internal pure returns (bytes calldata) {
        return _get(extension, DynamicField.Predicate);
    }

    /**
     * @notice Returns the maker's permit from the provided extension calldata.
     * @param extension The calldata from which the maker's permit is to be retrieved.
     * @return calldata Bytes representing the maker's permit.
     */
    function makerPermit(
        bytes calldata extension
    ) internal pure returns (bytes calldata) {
        return _get(extension, DynamicField.MakerPermit);
    }

    /**
     * @notice Returns the pre-interaction from the provided extension calldata.
     * @param extension The calldata from which the pre-interaction is to be retrieved.
     * @return calldata Bytes representing the pre-interaction.
     */
    function preInteractionTargetAndData(
        bytes calldata extension
    ) internal pure returns (bytes calldata) {
        return _get(extension, DynamicField.PreInteractionData);
    }

    /**
     * @notice Returns the post-interaction from the provided extension calldata.
     * @param extension The calldata from which the post-interaction is to be retrieved.
     * @return calldata Bytes representing the post-interaction.
     */
    function postInteractionTargetAndData(
        bytes calldata extension
    ) internal pure returns (bytes calldata) {
        return _get(extension, DynamicField.PostInteractionData);
    }

    /**
     * @notice Returns extra suffix data from the provided extension calldata.
     * @param extension The calldata from which the extra suffix data is to be retrieved.
     * @return calldata Bytes representing the extra suffix data.
     */
    function customData(
        bytes calldata extension
    ) internal pure returns (bytes calldata) {
        if (extension.length < 0x20) return msg.data[:0];
        uint256 offsets = uint256(bytes32(extension));
        unchecked {
            return extension[0x20 + (offsets >> 224):];
        }
    }

    /**
     * @notice Retrieves a specific field from the provided extension calldata.
     * @dev The first 32 bytes of an extension calldata contain offsets to the end of each field within the calldata.
     * @param extension The calldata from which the field is to be retrieved.
     * @param field The specific dynamic field to retrieve from the extension.
     * @return calldata Bytes representing the requested field.
     */
    function _get(
        bytes calldata extension,
        DynamicField field
    ) private pure returns (bytes calldata) {
        if (extension.length < 0x20) return msg.data[:0];

        Offsets offsets;
        bytes calldata concat;
        assembly ("memory-safe") {
            // solhint-disable-line no-inline-assembly
            offsets := calldataload(extension.offset)
            concat.offset := add(extension.offset, 0x20)
            concat.length := sub(extension.length, 0x20)
        }

        return offsets.get(concat, uint256(field));
    }
}

// File: https://github.com/1inch/limit-order-protocol/blob/master/contracts/libraries/AmountCalculatorLib.sol

pragma solidity 0.8.23;

/// @title The helper library to calculate linearly taker amount from maker amount and vice versa.
library AmountCalculatorLib {
    /// @notice Calculates maker amount
    /// @return Result Floored maker amount
    function getMakingAmount(
        uint256 orderMakerAmount,
        uint256 orderTakerAmount,
        uint256 swapTakerAmount
    ) internal pure returns (uint256) {
        if ((swapTakerAmount | orderMakerAmount) >> 128 == 0) {
            unchecked {
                return (swapTakerAmount * orderMakerAmount) / orderTakerAmount;
            }
        }
        return (swapTakerAmount * orderMakerAmount) / orderTakerAmount;
    }

    /// @notice Calculates taker amount
    /// @return Result Ceiled taker amount
    function getTakingAmount(
        uint256 orderMakerAmount,
        uint256 orderTakerAmount,
        uint256 swapMakerAmount
    ) internal pure returns (uint256) {
        if ((swapMakerAmount | orderTakerAmount) >> 128 == 0) {
            unchecked {
                return
                    (swapMakerAmount *
                        orderTakerAmount +
                        orderMakerAmount -
                        1) / orderMakerAmount;
            }
        }
        return
            (swapMakerAmount * orderTakerAmount + orderMakerAmount - 1) /
            orderMakerAmount;
    }
}

// File: https://github.com/1inch/limit-order-protocol/blob/master/contracts/interfaces/IAmountGetter.sol

pragma solidity ^0.8.0;

/**
 * @title IAmountGetter
 * @notice Interface for external logic to determine actual making and taking amounts for orders.
 */
interface IAmountGetter {
    /**
     * @notice View method that gets called to determine the actual making amount
     * @param order Order being processed
     * @param extension Order extension data
     * @param orderHash Hash of the order being processed
     * @param taker Taker address
     * @param takingAmount Actual taking amount
     * @param remainingMakingAmount Order remaining making amount
     * @param extraData Extra data
     * @return makingAmount Actual making amount that should be used for the order
     */
    function getMakingAmount(
        IOrderMixin.Order calldata order,
        bytes calldata extension,
        bytes32 orderHash,
        address taker,
        uint256 takingAmount,
        uint256 remainingMakingAmount,
        bytes calldata extraData
    ) external view returns (uint256);

    /**
     * @notice View method that gets called to determine the actual taking amount
     * @param order Order being processed
     * @param extension Order extension data
     * @param orderHash Hash of the order being processed
     * @param taker Taker address
     * @param makingAmount Actual taking amount
     * @param remainingMakingAmount Order remaining making amount
     * @param extraData Extra data
     * @return takingAmount Actual taking amount that should be used for the order
     */
    function getTakingAmount(
        IOrderMixin.Order calldata order,
        bytes calldata extension,
        bytes32 orderHash,
        address taker,
        uint256 makingAmount,
        uint256 remainingMakingAmount,
        bytes calldata extraData
    ) external view returns (uint256);
}

// File: https://github.com/1inch/limit-order-protocol/blob/master/contracts/OrderLib.sol

pragma solidity 0.8.23;

/**
 * @title OrderLib
 * @dev The library provides common functionality for processing and manipulating limit orders.
 * It provides functionality to calculate and verify order hashes, calculate trade amounts, and validate
 * extension data associated with orders. The library also contains helper methods to get the receiver of
 * an order and call getter functions.
 */
library OrderLib {
    using AddressLib for Address;
    using MakerTraitsLib for MakerTraits;
    using ExtensionLib for bytes;

    /// @dev Error to be thrown when the extension data of an order is missing.
    error MissingOrderExtension();
    /// @dev Error to be thrown when the order has an unexpected extension.
    error UnexpectedOrderExtension();
    /// @dev Error to be thrown when the order extension hash is invalid.
    error InvalidExtensionHash();

    /// @dev The typehash of the order struct.
    bytes32 internal constant _LIMIT_ORDER_TYPEHASH =
        keccak256(
            "Order("
            "uint256 salt,"
            "address maker,"
            "address receiver,"
            "address makerAsset,"
            "address takerAsset,"
            "uint256 makingAmount,"
            "uint256 takingAmount,"
            "uint256 makerTraits"
            ")"
        );
    uint256 internal constant _ORDER_STRUCT_SIZE = 0x100;
    uint256 internal constant _DATA_HASH_SIZE = 0x120;

    /**
     * @notice Calculates the hash of an order.
     * @param order The order to be hashed.
     * @param domainSeparator The domain separator to be used for the EIP-712 hashing.
     * @return result The keccak256 hash of the order data.
     */
    function hash(
        IOrderMixin.Order calldata order,
        bytes32 domainSeparator
    ) internal pure returns (bytes32 result) {
        bytes32 typehash = _LIMIT_ORDER_TYPEHASH;
        assembly ("memory-safe") {
            // solhint-disable-line no-inline-assembly
            let ptr := mload(0x40)

            // keccak256(abi.encode(_LIMIT_ORDER_TYPEHASH, order));
            mstore(ptr, typehash)
            calldatacopy(add(ptr, 0x20), order, _ORDER_STRUCT_SIZE)
            result := keccak256(ptr, _DATA_HASH_SIZE)
        }
        result = ECDSA.toTypedDataHash(domainSeparator, result);
    }

    /**
     * @notice Returns the receiver address for an order.
     * @param order The order.
     * @return receiver The address of the receiver, either explicitly defined in the order or the maker's address if not specified.
     */
    function getReceiver(
        IOrderMixin.Order calldata order
    ) internal pure returns (address /*receiver*/) {
        address receiver = order.receiver.get();
        return receiver != address(0) ? receiver : order.maker.get();
    }

    /**
     * @notice Calculates the making amount based on the requested taking amount.
     * @dev If getter is specified in the extension data, the getter is called to calculate the making amount,
     * otherwise the making amount is calculated linearly.
     * @param order The order.
     * @param extension The extension data associated with the order.
     * @param requestedTakingAmount The amount the taker wants to take.
     * @param remainingMakingAmount The remaining amount of the asset left to fill.
     * @param orderHash The hash of the order.
     * @return makingAmount The amount of the asset the maker receives.
     */
    function calculateMakingAmount(
        IOrderMixin.Order calldata order,
        bytes calldata extension,
        uint256 requestedTakingAmount,
        uint256 remainingMakingAmount,
        bytes32 orderHash
    ) internal view returns (uint256) {
        bytes calldata data = extension.makingAmountData();
        if (data.length == 0) {
            // Linear proportion
            return
                AmountCalculatorLib.getMakingAmount(
                    order.makingAmount,
                    order.takingAmount,
                    requestedTakingAmount
                );
        }
        return
            IAmountGetter(address(bytes20(data))).getMakingAmount(
                order,
                extension,
                orderHash,
                msg.sender,
                requestedTakingAmount,
                remainingMakingAmount,
                data[20:]
            );
    }

    /**
     * @notice Calculates the taking amount based on the requested making amount.
     * @dev If getter is specified in the extension data, the getter is called to calculate the taking amount,
     * otherwise the taking amount is calculated linearly.
     * @param order The order.
     * @param extension The extension data associated with the order.
     * @param requestedMakingAmount The amount the maker wants to receive.
     * @param remainingMakingAmount The remaining amount of the asset left to be filled.
     * @param orderHash The hash of the order.
     * @return takingAmount The amount of the asset the taker takes.
     */
    function calculateTakingAmount(
        IOrderMixin.Order calldata order,
        bytes calldata extension,
        uint256 requestedMakingAmount,
        uint256 remainingMakingAmount,
        bytes32 orderHash
    ) internal view returns (uint256) {
        bytes calldata data = extension.takingAmountData();
        if (data.length == 0) {
            // Linear proportion
            return
                AmountCalculatorLib.getTakingAmount(
                    order.makingAmount,
                    order.takingAmount,
                    requestedMakingAmount
                );
        }
        return
            IAmountGetter(address(bytes20(data))).getTakingAmount(
                order,
                extension,
                orderHash,
                msg.sender,
                requestedMakingAmount,
                remainingMakingAmount,
                data[20:]
            );
    }

    /**
     * @dev Validates the extension associated with an order.
     * @param order The order to validate against.
     * @param extension The extension associated with the order.
     * @return valid True if the extension is valid, false otherwise.
     * @return errorSelector The error selector if the extension is invalid, 0x00000000 otherwise.
     */
    function isValidExtension(
        IOrderMixin.Order calldata order,
        bytes calldata extension
    ) internal pure returns (bool, bytes4) {
        if (order.makerTraits.hasExtension()) {
            if (extension.length == 0)
                return (false, MissingOrderExtension.selector);
            // Lowest 160 bits of the order salt must be equal to the lowest 160 bits of the extension hash
            if (
                uint256(keccak256(extension)) & type(uint160).max !=
                order.salt & type(uint160).max
            ) return (false, InvalidExtensionHash.selector);
        } else {
            if (extension.length > 0)
                return (false, UnexpectedOrderExtension.selector);
        }
        return (true, 0x00000000);
    }
}

// File: https://github.com/1inch/limit-order-protocol/blob/master/contracts/OrderMixin.sol

pragma solidity 0.8.23;

/// @title Limit Order mixin
abstract contract OrderMixin is
    IOrderMixin,
    EIP712,
    PredicateHelper,
    SeriesEpochManager,
    Pausable,
    OnlyWethReceiver,
    PermitAndCall
{
    using SafeERC20 for IERC20;
    using SafeERC20 for IWETH;
    using OrderLib for IOrderMixin.Order;
    using ExtensionLib for bytes;
    using AddressLib for Address;
    using MakerTraitsLib for MakerTraits;
    using TakerTraitsLib for TakerTraits;
    using BitInvalidatorLib for BitInvalidatorLib.Data;
    using RemainingInvalidatorLib for RemainingInvalidator;

    IWETH private immutable _WETH;
    mapping(address maker => BitInvalidatorLib.Data data)
        private _bitInvalidator;
    mapping(address maker => mapping(bytes32 orderHash => RemainingInvalidator remaining))
        private _remainingInvalidator;

    constructor(IWETH weth) OnlyWethReceiver(address(weth)) {
        _WETH = weth;
    }

    /**
     * @notice See {IOrderMixin-bitInvalidatorForOrder}.
     */
    function bitInvalidatorForOrder(
        address maker,
        uint256 slot
    ) external view returns (uint256 /* result */) {
        return _bitInvalidator[maker].checkSlot(slot);
    }

    /**
     * @notice See {IOrderMixin-remainingInvalidatorForOrder}.
     */
    function remainingInvalidatorForOrder(
        address maker,
        bytes32 orderHash
    ) external view returns (uint256 /* remaining */) {
        return _remainingInvalidator[maker][orderHash].remaining();
    }

    /**
     * @notice See {IOrderMixin-rawRemainingInvalidatorForOrder}.
     */
    function rawRemainingInvalidatorForOrder(
        address maker,
        bytes32 orderHash
    ) external view returns (uint256 /* remainingRaw */) {
        return
            RemainingInvalidator.unwrap(
                _remainingInvalidator[maker][orderHash]
            );
    }

    /**
     * @notice See {IOrderMixin-simulate}.
     */
    function simulate(address target, bytes calldata data) external {
        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory result) = target.delegatecall(data);
        revert SimulationResults(success, result);
    }

    /**
     * @notice See {IOrderMixin-cancelOrder}.
     */
    function cancelOrder(MakerTraits makerTraits, bytes32 orderHash) public {
        if (makerTraits.useBitInvalidator()) {
            uint256 invalidator = _bitInvalidator[msg.sender].massInvalidate(
                makerTraits.nonceOrEpoch(),
                0
            );
            emit BitInvalidatorUpdated(
                msg.sender,
                makerTraits.nonceOrEpoch() >> 8,
                invalidator
            );
        } else {
            _remainingInvalidator[msg.sender][
                orderHash
            ] = RemainingInvalidatorLib.fullyFilled();
            emit OrderCancelled(orderHash);
        }
    }

    /**
     * @notice See {IOrderMixin-cancelOrders}.
     */
    function cancelOrders(
        MakerTraits[] calldata makerTraits,
        bytes32[] calldata orderHashes
    ) external {
        if (makerTraits.length != orderHashes.length)
            revert MismatchArraysLengths();
        unchecked {
            for (uint256 i = 0; i < makerTraits.length; i++) {
                cancelOrder(makerTraits[i], orderHashes[i]);
            }
        }
    }

    /**
     * @notice See {IOrderMixin-bitsInvalidateForOrder}.
     */
    function bitsInvalidateForOrder(
        MakerTraits makerTraits,
        uint256 additionalMask
    ) external {
        if (!makerTraits.useBitInvalidator())
            revert OrderIsNotSuitableForMassInvalidation();
        uint256 invalidator = _bitInvalidator[msg.sender].massInvalidate(
            makerTraits.nonceOrEpoch(),
            additionalMask
        );
        emit BitInvalidatorUpdated(
            msg.sender,
            makerTraits.nonceOrEpoch() >> 8,
            invalidator
        );
    }

    /**
     * @notice See {IOrderMixin-hashOrder}.
     */
    function hashOrder(
        IOrderMixin.Order calldata order
    ) external view returns (bytes32) {
        return order.hash(_domainSeparatorV4());
    }

    /**
     * @notice See {IOrderMixin-checkPredicate}.
     */
    function checkPredicate(
        bytes calldata predicate
    ) public view returns (bool) {
        (bool success, uint256 res) = _staticcallForUint(
            address(this),
            predicate
        );
        return success && res == 1;
    }

    /**
     * @notice See {IOrderMixin-fillOrder}.
     */
    function fillOrder(
        IOrderMixin.Order calldata order,
        bytes32 r,
        bytes32 vs,
        uint256 amount,
        TakerTraits takerTraits
    )
        external
        payable
        returns (
            uint256 /* makingAmount */,
            uint256 /* takingAmount */,
            bytes32 /* orderHash */
        )
    {
        return
            _fillOrder(
                order,
                r,
                vs,
                amount,
                takerTraits,
                msg.sender,
                msg.data[:0],
                msg.data[:0]
            );
    }

    /**
     * @notice See {IOrderMixin-fillOrderArgs}.
     */
    function fillOrderArgs(
        IOrderMixin.Order calldata order,
        bytes32 r,
        bytes32 vs,
        uint256 amount,
        TakerTraits takerTraits,
        bytes calldata args
    )
        external
        payable
        returns (
            uint256 /* makingAmount */,
            uint256 /* takingAmount */,
            bytes32 /* orderHash */
        )
    {
        (
            address target,
            bytes calldata extension,
            bytes calldata interaction
        ) = _parseArgs(takerTraits, args);

        return
            _fillOrder(
                order,
                r,
                vs,
                amount,
                takerTraits,
                target,
                extension,
                interaction
            );
    }

    function _fillOrder(
        IOrderMixin.Order calldata order,
        bytes32 r,
        bytes32 vs,
        uint256 amount,
        TakerTraits takerTraits,
        address target,
        bytes calldata extension,
        bytes calldata interaction
    )
        private
        returns (uint256 makingAmount, uint256 takingAmount, bytes32 orderHash)
    {
        // Check signature and apply order/maker permit only on the first fill
        orderHash = order.hash(_domainSeparatorV4());
        uint256 remainingMakingAmount = _checkRemainingMakingAmount(
            order,
            orderHash
        );
        if (remainingMakingAmount == order.makingAmount) {
            address maker = order.maker.get();
            if (maker == address(0) || maker != ECDSA.recover(orderHash, r, vs))
                revert BadSignature();
            if (!takerTraits.skipMakerPermit()) {
                bytes calldata makerPermit = extension.makerPermit();
                if (makerPermit.length >= 20) {
                    // proceed only if taker is willing to execute permit and its length is enough to store address
                    IERC20(address(bytes20(makerPermit))).tryPermit(
                        maker,
                        address(this),
                        makerPermit[20:]
                    );
                    if (!order.makerTraits.useBitInvalidator()) {
                        // Bit orders are not subjects for reentrancy, but we still need to check remaining-based orders for reentrancy
                        if (
                            !_remainingInvalidator[order.maker.get()][orderHash]
                                .isNewOrder()
                        ) revert ReentrancyDetected();
                    }
                }
            }
        }

        (makingAmount, takingAmount) = _fill(
            order,
            orderHash,
            remainingMakingAmount,
            amount,
            takerTraits,
            target,
            extension,
            interaction
        );
    }

    /**
     * @notice See {IOrderMixin-fillContractOrder}.
     */
    function fillContractOrder(
        IOrderMixin.Order calldata order,
        bytes calldata signature,
        uint256 amount,
        TakerTraits takerTraits
    )
        external
        returns (
            uint256 /* makingAmount */,
            uint256 /* takingAmount */,
            bytes32 /* orderHash */
        )
    {
        return
            _fillContractOrder(
                order,
                signature,
                amount,
                takerTraits,
                msg.sender,
                msg.data[:0],
                msg.data[:0]
            );
    }

    /**
     * @notice See {IOrderMixin-fillContractOrderArgs}.
     */
    function fillContractOrderArgs(
        IOrderMixin.Order calldata order,
        bytes calldata signature,
        uint256 amount,
        TakerTraits takerTraits,
        bytes calldata args
    )
        external
        returns (
            uint256 /* makingAmount */,
            uint256 /* takingAmount */,
            bytes32 /* orderHash */
        )
    {
        (
            address target,
            bytes calldata extension,
            bytes calldata interaction
        ) = _parseArgs(takerTraits, args);

        return
            _fillContractOrder(
                order,
                signature,
                amount,
                takerTraits,
                target,
                extension,
                interaction
            );
    }

    function _fillContractOrder(
        IOrderMixin.Order calldata order,
        bytes calldata signature,
        uint256 amount,
        TakerTraits takerTraits,
        address target,
        bytes calldata extension,
        bytes calldata interaction
    )
        private
        returns (uint256 makingAmount, uint256 takingAmount, bytes32 orderHash)
    {
        // Check signature only on the first fill
        orderHash = order.hash(_domainSeparatorV4());
        uint256 remainingMakingAmount = _checkRemainingMakingAmount(
            order,
            orderHash
        );
        if (remainingMakingAmount == order.makingAmount) {
            if (
                !ECDSA.isValidSignature(order.maker.get(), orderHash, signature)
            ) revert BadSignature();
        }

        (makingAmount, takingAmount) = _fill(
            order,
            orderHash,
            remainingMakingAmount,
            amount,
            takerTraits,
            target,
            extension,
            interaction
        );
    }

    /**
     * @notice Fills an order and transfers making amount to a specified target.
     * @dev If the target is zero assigns it the caller's address.
     * The function flow is as follows:
     * 1. Validate order
     * 2. Call maker pre-interaction
     * 3. Transfer maker asset to taker
     * 4. Call taker interaction
     * 5. Transfer taker asset to maker
     * 5. Call maker post-interaction
     * 6. Emit OrderFilled event
     * @param order The order details.
     * @param orderHash The hash of the order.
     * @param extension The extension calldata of the order.
     * @param remainingMakingAmount The remaining amount to be filled.
     * @param amount The order amount.
     * @param takerTraits The taker preferences for the order.
     * @param target The address to which the order is filled.
     * @param interaction The interaction calldata.
     * @return makingAmount The computed amount that the maker will send.
     * @return takingAmount The computed amount that the taker will send.
     */
    function _fill(
        IOrderMixin.Order calldata order,
        bytes32 orderHash,
        uint256 remainingMakingAmount,
        uint256 amount,
        TakerTraits takerTraits,
        address target,
        bytes calldata extension,
        bytes calldata interaction
    )
        private
        whenNotPaused
        returns (uint256 makingAmount, uint256 takingAmount)
    {
        // Validate order
        {
            (bool valid, bytes4 validationResult) = order.isValidExtension(
                extension
            );
            if (!valid) {
                // solhint-disable-next-line no-inline-assembly
                assembly ("memory-safe") {
                    mstore(0, validationResult)
                    revert(0, 4)
                }
            }
        }
        if (!order.makerTraits.isAllowedSender(msg.sender))
            revert PrivateOrder();
        if (order.makerTraits.isExpired()) revert OrderExpired();
        if (order.makerTraits.needCheckEpochManager()) {
            if (order.makerTraits.useBitInvalidator())
                revert EpochManagerAndBitInvalidatorsAreIncompatible();
            if (
                !epochEquals(
                    order.maker.get(),
                    order.makerTraits.series(),
                    order.makerTraits.nonceOrEpoch()
                )
            ) revert WrongSeriesNonce();
        }

        // Check if orders predicate allows filling
        if (extension.length > 0) {
            bytes calldata predicate = extension.predicate();
            if (predicate.length > 0) {
                if (!checkPredicate(predicate)) revert PredicateIsNotTrue();
            }
        }

        // Compute maker and taker assets amount
        if (takerTraits.isMakingAmount()) {
            makingAmount = Math.min(amount, remainingMakingAmount);
            takingAmount = order.calculateTakingAmount(
                extension,
                makingAmount,
                remainingMakingAmount,
                orderHash
            );

            uint256 threshold = takerTraits.threshold();
            if (threshold > 0) {
                // Check rate: takingAmount / makingAmount <= threshold / amount
                if (amount == makingAmount) {
                    // Gas optimization, no SafeMath.mul()
                    if (takingAmount > threshold) revert TakingAmountTooHigh();
                } else {
                    if (takingAmount * amount > threshold * makingAmount)
                        revert TakingAmountTooHigh();
                }
            }
        } else {
            takingAmount = amount;
            makingAmount = order.calculateMakingAmount(
                extension,
                takingAmount,
                remainingMakingAmount,
                orderHash
            );
            if (makingAmount > remainingMakingAmount) {
                // Try to decrease taking amount because computed making amount exceeds remaining amount
                makingAmount = remainingMakingAmount;
                takingAmount = order.calculateTakingAmount(
                    extension,
                    makingAmount,
                    remainingMakingAmount,
                    orderHash
                );
                if (takingAmount > amount) revert TakingAmountExceeded();
            }

            uint256 threshold = takerTraits.threshold();
            if (threshold > 0) {
                // Check rate: makingAmount / takingAmount >= threshold / amount
                if (amount == takingAmount) {
                    // Gas optimization, no SafeMath.mul()
                    if (makingAmount < threshold) revert MakingAmountTooLow();
                } else {
                    if (makingAmount * amount < threshold * takingAmount)
                        revert MakingAmountTooLow();
                }
            }
        }
        if (
            !order.makerTraits.allowPartialFills() &&
            makingAmount != order.makingAmount
        ) revert PartialFillNotAllowed();
        unchecked {
            if (makingAmount * takingAmount == 0) revert SwapWithZeroAmount();
        }

        // Invalidate order depending on makerTraits
        if (order.makerTraits.useBitInvalidator()) {
            _bitInvalidator[order.maker.get()].checkAndInvalidate(
                order.makerTraits.nonceOrEpoch()
            );
        } else {
            _remainingInvalidator[order.maker.get()][
                orderHash
            ] = RemainingInvalidatorLib.remains(
                remainingMakingAmount,
                makingAmount
            );
        }

        // Pre interaction, where maker can prepare funds interactively
        if (order.makerTraits.needPreInteractionCall()) {
            bytes calldata data = extension.preInteractionTargetAndData();
            address listener = order.maker.get();
            if (data.length > 19) {
                listener = address(bytes20(data));
                data = data[20:];
            }
            IPreInteraction(listener).preInteraction(
                order,
                extension,
                orderHash,
                msg.sender,
                makingAmount,
                takingAmount,
                remainingMakingAmount,
                data
            );
        }

        // Maker => Taker
        {
            bool needUnwrap = order.makerAsset.get() == address(_WETH) &&
                takerTraits.unwrapWeth();
            address receiver = needUnwrap ? address(this) : target;
            if (order.makerTraits.usePermit2()) {
                if (extension.makerAssetSuffix().length > 0)
                    revert InvalidPermit2Transfer();
                IERC20(order.makerAsset.get()).safeTransferFromPermit2(
                    order.maker.get(),
                    receiver,
                    makingAmount
                );
            } else {
                if (
                    !_callTransferFromWithSuffix(
                        order.makerAsset.get(),
                        order.maker.get(),
                        receiver,
                        makingAmount,
                        extension.makerAssetSuffix()
                    )
                ) revert TransferFromMakerToTakerFailed();
            }
            if (needUnwrap) {
                _WETH.safeWithdrawTo(makingAmount, target);
            }
        }

        if (interaction.length > 19) {
            // proceed only if interaction length is enough to store address
            ITakerInteraction(address(bytes20(interaction))).takerInteraction(
                order,
                extension,
                orderHash,
                msg.sender,
                makingAmount,
                takingAmount,
                remainingMakingAmount,
                interaction[20:]
            );
        }

        // Taker => Maker
        if (order.takerAsset.get() == address(_WETH) && msg.value > 0) {
            if (msg.value < takingAmount) revert Errors.InvalidMsgValue();
            if (msg.value > takingAmount) {
                unchecked {
                    // solhint-disable-next-line avoid-low-level-calls
                    (bool success, ) = msg.sender.call{
                        value: msg.value - takingAmount
                    }("");
                    if (!success) revert Errors.ETHTransferFailed();
                }
            }

            if (order.makerTraits.unwrapWeth()) {
                // solhint-disable-next-line avoid-low-level-calls
                (bool success, ) = order.getReceiver().call{
                    value: takingAmount
                }("");
                if (!success) revert Errors.ETHTransferFailed();
            } else {
                _WETH.safeDeposit(takingAmount);
                _WETH.safeTransfer(order.getReceiver(), takingAmount);
            }
        } else {
            if (msg.value != 0) revert Errors.InvalidMsgValue();

            bool needUnwrap = order.takerAsset.get() == address(_WETH) &&
                order.makerTraits.unwrapWeth();
            address receiver = needUnwrap ? address(this) : order.getReceiver();
            if (takerTraits.usePermit2()) {
                if (extension.takerAssetSuffix().length > 0)
                    revert InvalidPermit2Transfer();
                IERC20(order.takerAsset.get()).safeTransferFromPermit2(
                    msg.sender,
                    receiver,
                    takingAmount
                );
            } else {
                if (
                    !_callTransferFromWithSuffix(
                        order.takerAsset.get(),
                        msg.sender,
                        receiver,
                        takingAmount,
                        extension.takerAssetSuffix()
                    )
                ) revert TransferFromTakerToMakerFailed();
            }

            if (needUnwrap) {
                _WETH.safeWithdrawTo(takingAmount, order.getReceiver());
            }
        }

        // Post interaction, where maker can handle funds interactively
        if (order.makerTraits.needPostInteractionCall()) {
            bytes calldata data = extension.postInteractionTargetAndData();
            address listener = order.maker.get();
            if (data.length > 19) {
                listener = address(bytes20(data));
                data = data[20:];
            }
            IPostInteraction(listener).postInteraction(
                order,
                extension,
                orderHash,
                msg.sender,
                makingAmount,
                takingAmount,
                remainingMakingAmount,
                data
            );
        }

        emit OrderFilled(orderHash, remainingMakingAmount - makingAmount);
    }

    /**
     * @notice Processes the taker interaction arguments.
     * @param takerTraits The taker preferences for the order.
     * @param args The taker interaction arguments.
     * @return target The address to which the order is filled.
     * @return extension The extension calldata of the order.
     * @return interaction The interaction calldata.
     */
    function _parseArgs(
        TakerTraits takerTraits,
        bytes calldata args
    )
        private
        view
        returns (
            address target,
            bytes calldata extension,
            bytes calldata interaction
        )
    {
        if (takerTraits.argsHasTarget()) {
            target = address(bytes20(args));
            args = args[20:];
        } else {
            target = msg.sender;
        }

        uint256 extensionLength = takerTraits.argsExtensionLength();
        if (extensionLength > 0) {
            extension = args[:extensionLength];
            args = args[extensionLength:];
        } else {
            extension = msg.data[:0];
        }

        uint256 interactionLength = takerTraits.argsInteractionLength();
        if (interactionLength > 0) {
            interaction = args[:interactionLength];
        } else {
            interaction = msg.data[:0];
        }
    }

    /**
     * @notice Checks the remaining making amount for the order.
     * @dev If the order has been invalidated, the function will revert.
     * @param order The order to check.
     * @param orderHash The hash of the order.
     * @return remainingMakingAmount The remaining amount of the order.
     */
    function _checkRemainingMakingAmount(
        IOrderMixin.Order calldata order,
        bytes32 orderHash
    ) private view returns (uint256 remainingMakingAmount) {
        if (order.makerTraits.useBitInvalidator()) {
            remainingMakingAmount = order.makingAmount;
        } else {
            remainingMakingAmount = _remainingInvalidator[order.maker.get()][
                orderHash
            ].remaining(order.makingAmount);
        }
        if (remainingMakingAmount == 0) revert InvalidatedOrder();
    }

    /**
     * @notice Calls the transferFrom function with an arbitrary suffix.
     * @dev The suffix is appended to the end of the standard ERC20 transferFrom function parameters.
     * @param asset The token to be transferred.
     * @param from The address to transfer the token from.
     * @param to The address to transfer the token to.
     * @param amount The amount of the token to transfer.
     * @param suffix The suffix (additional data) to append to the end of the transferFrom call.
     * @return success A boolean indicating whether the transfer was successful.
     */
    function _callTransferFromWithSuffix(
        address asset,
        address from,
        address to,
        uint256 amount,
        bytes calldata suffix
    ) private returns (bool success) {
        bytes4 selector = IERC20.transferFrom.selector;
        assembly ("memory-safe") {
            // solhint-disable-line no-inline-assembly
            let data := mload(0x40)
            mstore(data, selector)
            mstore(add(data, 0x04), from)
            mstore(add(data, 0x24), to)
            mstore(add(data, 0x44), amount)
            if suffix.length {
                calldatacopy(add(data, 0x64), suffix.offset, suffix.length)
            }
            let status := call(
                gas(),
                asset,
                0,
                data,
                add(0x64, suffix.length),
                0x0,
                0x20
            )
            success := and(
                status,
                or(
                    iszero(returndatasize()),
                    and(gt(returndatasize(), 31), eq(mload(0), 1))
                )
            )
        }
    }
}

// File: https://github.com/1inch/limit-order-protocol/blob/master/contracts/LimitOrderProtocol.sol

pragma solidity 0.8.23;

/**
 * @title ##1inch Limit Order Protocol v4
 * @notice Limit order protocol provides two different order types
 * - Regular Limit Order
 * - RFQ Order
 *
 * Both types provide similar order-fulfilling functionality. The difference is that regular order offers more customization options and features, while RFQ order is extremely gas efficient but without ability to customize.
 *
 * Regular limit order additionally supports
 * - Execution predicates. Conditions for order execution are set with predicates. For example, expiration timestamp or block number, price for stop loss or take profit strategies.
 * - Callbacks to notify maker on order execution
 *
 * See [OrderMixin](OrderMixin.md) for more details.
 *
 * RFQ orders supports
 * - Expiration time
 * - Cancelation by order id
 * - Partial Fill (only once)
 *
 * See [OrderMixin](OrderMixin.md) for more details.
 */
contract LimitOrderProtocol is
    EIP712("1inch Limit Order Protocol", "4"),
    Ownable,
    Pausable,
    OrderMixin
{
    // solhint-disable-next-line no-empty-blocks
    constructor(IWETH _weth) OrderMixin(_weth) Ownable(msg.sender) {}

    /// @dev Returns the domain separator for the current chain (EIP-712)
    // solhint-disable-next-line func-name-mixedcase
    function DOMAIN_SEPARATOR() external view returns (bytes32) {
        return _domainSeparatorV4();
    }

    /**
     * @notice Pauses all the trading functionality in the contract.
     */
    function pause() external onlyOwner {
        _pause();
    }

    /**
     * @notice Unpauses all the trading functionality in the contract.
     */
    function unpause() external onlyOwner {
        _unpause();
    }
}
