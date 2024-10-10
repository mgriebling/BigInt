[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmgriebling%2FBigInt%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/mgriebling/BigInt)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmgriebling%2FBigInt%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/mgriebling/BigInt)

## BigInt

The BigInt package provides arbitrary-precision integer arithmetic in Swift.
Its functionality falls in the following categories:

* **Arithmetic:** addition, subtraction, multiplication, division, exponentiation, remainder and modulus, gcd and lcm
* **Comparison:** the six standard operations `==`, `!=`, `<`, `<=`, `>`, and `>=`
* **Shifting:** logical left shift and rigth shift
* **Logical:** bitwise and, or, xor, and not
* **Modulo:** normal modulus, inverse modulus, and modular exponentiation
* **Conversion:** to/from double, to/from integer, to/from string, to/from a magnitude 
    byte array, and to/from a 2's complement byte array
* **Primes:** prime number testing, probable prime number generation and primorial
* **Miscellaneous:** random number generation, n-th root, square root modulo and odd prime,
Jacobi symbol, Kronecker symbol, Factorial function, Binomial function, Fibonacci numbers, Lucas numbers and Bernoulli numbers
* **Fractions:** Standard arithmetic on fractions whose numerators and denominators are of unbounded size
* **Chinese Remainder Theorem:** Compute the CRT value from given residues and moduli

BigInt requires Swift 5.0. It also requires that the Int and UInt types be 64 bit types.
BigInt has been updated to include Leif Ibsen's changes up to v1.19.0.

Its documentation is built with the DocC plugin and published on GitHub Pages at this location:

https://mgriebling.github.io/BigInt/documentation/bigint

The documentation is also available in the *BigInt.doccarchive* file.

**Please note:** Due to a bug in the DocC plugin, clicking on certain `BInt` and `BFraction` operators
in GitHub Pages (e.g., `<` and `|` ) will show the message

    The page you're looking for can't be found.
    
The *BigInt.doccarchive* file contains the correct documentation.

It is emphasized that it is only the documentation that's in error.
The operators themselves work correctly.

From now on, this BigInt will mirror Ibsen's BigInt changes (more or less) and have addendum files
like *BigInt-Extensions.swift* to implement the Apple-centric protocol compliance.

Two changes were required in the original source to support BinaryInteger
compliance:

1) Renamed  `mantissa` to `_mantissa` to avoid conflict with the protocol-required 
`mantissa`variable.
2) Added the Codable protocol to the BigInt struct definition. This is a *free*
addition that doesn't require any additional code. Benefits include being able
to read and write JSON files containing BigInts.

Supporting these protocols greatly simplifies the BigDecimal additions and
makes BigInt a first-class citizen that can interoperate with all the other 
integer types.


