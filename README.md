[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmgriebling%2FBigInt%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/mgriebling/BigInt)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmgriebling%2FBigInt%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/mgriebling/BigInt)

## BigInt

The BigInt package provides arbitrary-precision integer arithmetic in Swift.
Its functionality falls in the following categories:

* **Arithmetic:** addition, subtraction, multiplication, division, exponentiation, remainder and modulus, gcd and lcm
* **Comparison:** the six standard operations `==` `!=` `<` `<=` `>` `>=`
* **Shifting:** logical left shift and rigth shift
* **Logical:** bitwise and, or, xor, and not
* **Modulo:** normal modulus, inverse modulus, and modular exponentiation
* **Conversion:** to double, to integer, to string, to magnitude byte array, and to 2's complement byte array
* **Primes:** prime number testing, probable prime number generation and primorial
* **Miscellaneous:** random number generation, n-th root, square root modulo an odd prime,
Jacobi symbol, Kronecker symbol, Factorial function, Binomial function, Fibonacci numbers, Lucas numbers and Bernoulli numbers
* **Fractions:** Standard arithmetic on fractions whose numerators and denominators are of unbounded size
* **Chinese Remainder Theorem:** Compute the CRT value from given residues and moduli

`BigInt` requires Swift 5.0. It also requires that the Int and UInt types be 64 bit types.
It needs to run on macOS 13.3+, iOS 16.4+, tvOS 16.4+, watchOS 9.4+.
BigInt has been updated to include Leif Ibsen `BigInt` changes up to v1.19.0.

Its documentation is built with the DocC plugin and published on GitHub Pages at this location:

https://mgriebling.github.io/BigInt/documentation/bigint

The documentation is also available in the BigInt.doccarchive file.

From now on, I'll mirror his changes (more or less) and have addendum files
like `BigInt-Extensions.swift` to implement the Apple-centric protocol compliance.
Only one change was required in the original source supporting `BinaryInteger`
compliance and that was to rename  `mantissa` to `_mantissa` to avoid conflict
with the protocol-required `mantissa`variable. Supporting these protocols
greatly simplifies the `BigDecimal` additions.


