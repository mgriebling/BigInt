
# Protocols

BigInt supports Apple's `SignedInteger`, `BinaryInteger`, `Codable`, and `Numeric` protocols.

It now includes support for `StaticBigInt` number initialization.  
Note: These extensions require renaming `magnitude` to `_magnitude` to avoid conflict with the
`Numeric` protocol variable also called `magnitude`.

Why support protocols? By supporting them you gain the ability to
formulate generic algorithms and make use of algorithms from others
that use the protocol type(s) you support. For example, `Strideable`
compliance is free (with `BinaryInteger`) and lets you do things like

```swift
for i in BInt(1)...10 {
   print(i.words)
}
```

The main header also
includes `Codable` compliance conformity (for free).  `Codable`
compliance allows `BInt`s to be distributed/received or stored/read as
JSONs instead of bunches of bytes that are inherently non-portable.

Protocols mean you can support generic arguments:
(e.g., `func * <T:BinaryInteger>(_ lhs: Self, rhs: T) -> Self`)
which works with all `BinaryIntegers`, including `BigInt`s instead of
just `Int`s or a single integer type.

Finally, protocol support allows simplified extensions to the `BigDecimal`
package available [here](https://github.com/mgriebling/BigDecimal.git).
It contains a complete arbitrary precision Decimal number implementation.

Its functionality falls in the following categories:
- Arithmetic: addition, subtraction, multiplication, division, remainder and 
  exponentiation
- Added arbitrary complex decimal number support with the `CBDecimal` type using
  `swift-numerics`.
- Compliant with `DecimalFloatingPoint` and `Real` protocols.
- Constants: `pi`, `zero`, `one`, `ten`
- Functions: exp, log, log10, log2, pow, sqrt, root, factorial, gamma, 
             trig + inverse, hyperbolic + inverse
- Rounding and scaling according to one of the rounding modes:
    - awayFromZero
    - down
    - towardZero
    - toNearestOrEven
    - toNearestOrAwayFromZero
    - up

- Comparison: the six standard operators `==`, `!=`, `<`, `<=`, `>`, and `>=`
- Conversion: to String, to Double, to Decimal (the Swift Foundation type), to 
  Decimal32 / Decimal64 / Decimal128
- Support for Decimal32, Decimal64 and Decimal128 values stored as UInt32, 
  UInt64 and UInt128 values respectively, using Densely Packed Decimal (DPD) 
  encoding or Binary Integer Decimal (BID) encoding
- Support for Decimal32, Decimal64 and Decimal128 mathematical operations
- Supports the IEEE 754 concepts of Infinity and NaN (Not a Number) with the
  latter having a `signaling` option.
