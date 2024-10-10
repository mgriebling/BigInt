
# Protocols and Additions

BigInt supports the standard integer data type's SignedInteger, BinaryInteger, Codable, and Numeric protocols.

BigInt (with protocols) now includes support for StaticBigInt number initialization
with macOS 13.3+, iOS 16.4+, tvOS 16.4+, watchOS 9.4+, macCatalyst 13.0+.
Note: These extensions required renaming `magnitude` to `_magnitude` to avoid conflict with the
Numeric protocol variable also called `magnitude`.

Why support protocols? By supporting them you gain the ability to
formulate generic algorithms and make use of algorithms from others
that use the protocol type(s) you support. For example, `Strideable`
compliance is free (with `BinaryInteger`) and lets you do things like

```swift
for i in BInt(1)...10 {
   print(i.words)
}
```

The BigInt struct also
includes `Codable` compliance conformity (for free). Codable
compliance allows BInts to be distributed/received or stored/read as
industry-standard JSONs.

Protocols mean you can support generic arguments:
(e.g., `func * <T:BinaryInteger>(_ lhs: Self, rhs: T) -> Self`)
which works with *all* `BinaryIntegers`, including BigInt's instead of
just Ints or a single integer type. 

Additionally, with support for StaticBigInt, initialization can now
use unlimited precision instead of requiring quoted numbers:

```swift
let huge = BInt(12_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789)
let hugeHex = BInt(0x1234_5678_9ABC_DEF0_1234_5678_9ABC_DEF0_1234_5678_9ABC_DEF0_1234_5678_9ABC_DEF0)
let hugeOctal = BInt(0o123_456_701_123_456_701_123_456_701_123_456_701_123_456_701_123_456_701)
let hugeBinary = BInt(0b10010101_01010101_01010101_01010010_10101000_01010111_11100101_01010101_01001010_10101010)
print(huge, "0x"+hugeHex.asString(radix: 16, uppercase: true), "0o"+hugeOctal.asString(radix: 8), 
        "0b"+hugeBinary.asString(radix: 2))
```
produces:

```
12345678901234567890123456789012345678901234567890123456789 
0x123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0 
0o123456701123456701123456701123456701123456701123456701 
0b10010101010101010101010101010010101010000101011111100101010101010100101010101010
```

Finally, protocol support allows simplified extensions to the BigDecimal
package available [here](https://github.com/mgriebling/BigDecimal.git).
It contains a complete arbitrary-precision Decimal number implementation
with support for standard 32-, 64-, and 128-bit decimal number formats.

