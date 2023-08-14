# BigInt

The BigInt package provides arbitrary-precision integer arithmetic in Swift.
Its functionality falls in the following categories:

 - Performance: 
    - Division 2x AttaSwift
    - Multiplication 7x AttaSwift
    - Logic functions 2x AttaSwift
    - Convert to String 3x AttaSwift
    - Shifts up to 16x AttaSwift
 - Arithmetic: add, subtract, multiply, divide, remainder and exponentiation
 - Comparison: the six standard operations == != < <= > >=
 - Shifting: logical left shift and rigth shift
 - Logical: bitwise and, or, xor, and not
 - Modulo: normal modulus, inverse modulus, and modular exponentiation
 - Conversion: to double, to integer, to string, to magnitude byte array, and to 2's complement byte array
 - Primes: prime number testing, probable prime number generation and primorial
 - Miscellaneous: random number generation, greatest common divisor, least common multiple, n-th root, square root modulo an odd prime, Jacobi symbol, Kronecker symbol, Factorial function, Binomial function, Fibonacci numbers, Lucas numbers and Bernoulli numbers
 - Fractions: Standard arithmetic on fractions whose numerators and denominators are of unbounded size
 
 ## Protocol support
 
 - Added `SignedInteger`, `BinaryInteger`, and `Numeric` protocol compliance.
 - Optional support for `StaticBigInt` to allow `BigInt` number initialization
   from very large integer literals. Uncomment the `BigInt-Extensions` 
   `StaticBigInt` support.
 
 Why support protocols? By supporting them you have the ability to
 formulate generic algorithms and make use of algorithms from others
 that use the protocol type(s) you support. For example, `Strideable`
 compliance is free (with `BinaryInteger`) and lets you do things like
 
 ```swift
 for i in BInt(1)...10 {
    print(i.words)
 }
 ```
 
 In addition, if a third party defines extensions for the supported protocols,
 these can be easily adapted by just conforming to that protocol.

BigInt requires Swift 5.0. It also requires that the Int and UInt types be 64 bit types.

## Usage
In your projects Package.swift file add a dependency like

```
dependencies: [
    .package(url: "https://github.com/mgriebling/BigInt.git", from: "2.0.0"),
]
```

## Examples
### Creating BInt's

```swift
  // From an integer
  let a = BInt(27)
  
  // From a decimal value
  let x = BInt(1.12345e30) // x = 1123450000000000064996914495488
  
  // From string literals
  let b = BInt("123456789012345678901234567890")!
  let c = BInt("1234567890abcdef1234567890abcdef", radix: 16)!
  
  // From magnitude and sign
  let m: Limbs = [1, 2, 3]
  let d = BInt(m) // d = 1020847100762815390427017310442723737601
  let e = BInt(m, true) // e = -1020847100762815390427017310442723737601
  
  // From a big-endian 2's complement byte array
  let f = BInt(signed: [255, 255, 127]) // f = -129
  
  // From a big-endian magnitude byte array
  let g = BInt(magnitude: [255, 255, 127]) // g = 16777087
  
  // Random value with specified bitwidth
  let h = BInt(bitWidth: 43) // For example h = 3965245974702 (=0b111001101100111011000100111110100010101110)
  
  // Random value less than a given value
  let i = h.randomLessThan() // For example i = 583464003284
```
	  
### Converting BInt's

```swift
  let x = BInt(16777087)
  
  // To double
  let d = x.asDouble() // d = 16777087.0
  
  // To strings
  let s1 = x.asString() // s1 = "16777087"
  let s2 = x.asString(radix: 16) // s2 = "ffff7f"
  
  // To big-endian magnitude byte array
  let b1 = x.asMagnitudeBytes() // b1 = [255, 255, 127]
  
  // To big-endian 2's complement byte array
  let b2 = x.asSignedBytes() // b2 = [0, 255, 255, 127]
```

## Performance

To assess the performance of BigInt, the execution times for a number of common operations were measured on an iMac 2021, Apple M1 chip.
The results are in the table below. It shows the operation being measured and the time it took (in microseconds or milliseconds).

Four large numbers 'a1000', 'b1000', 'c2000' and 'p1000' were used throughout the measurements. Their actual values are shown under the table.

| Operation | Swift code | Time |
| --------- | ---------- | ---- |
| As string | c2000.asString() | 13 uSec |
| As signed bytes | c2000.asSignedBytes() | 0.30 uSec |
| Bitwise and | a1000 & b1000 | 0.083 uSec |
| Bitwise or | a1000 \| b1000 | 0.083 uSec |
| Bitwise xor | a1000 ^ b1000 | 0.082 uSec |
| Bitwise not | ~c2000 | 0.087 uSec |
| Test bit | c2000.testBit(701) | 0.017 uSec |
| Flip bit | c2000.flipBit(701) | 0.018 uSec |
| Set bit | c2000.setBit(701) | 0.018 uSec |
| Clear bit | c2000.clearBit(701) | 0.018 uSec |
| Addition | a1000 + b1000 | 0.07 uSec |
| Subtraction | a1000 - b1000 | 0.08 uSec |
| Multiplication | a1000 \* b1000 | 0.32 uSec |
| Division | c2000 / a1000 | 2.2 uSec |
| Modulus | c2000.mod(a1000) | 2.2 uSec |
| Inverse modulus | c2000.modInverse(p1000) | 83 uSec |
| Modular exponentiation | a1000.expMod(b1000, c2000) | 3.5 mSec |
| Equal | c2000 + 1 == c2000 | 0.017 uSec |
| Less than | b1000 + 1 \< b1000 | 0.021 uSec |
| Shift 1 left | c2000 \<\<= 1 | 0.05 uSec |
| Shift 1 right | c2000 >>= 1 | 0.06 uSec |
| Shift 100 left | c2000 \<\<= 100 | 0.14 uSec |
| Shift 100 right | c2000 >>= 100 | 0.11 uSec |
| Is probably prime | p1000.isProbablyPrime() | 5.8 mSec |
| Make probable 1000 bit prime | BInt.probablePrime(1000) | 60 mSec |
| Next probable prime | c2000.nextPrime() | 730 mSec |
| Primorial | BInt.primorial(100000) | 8.5 mSec |
| Binomial | BInt.binomial(100000, 10000) | 22 mSec |
| Factorial | BInt.factorial(100000) | 57 mSec |
| Fibonacci | BInt.fibonacci(100000) | 0.22 mSec |
| Greatest common divisor | a1000.gcd(b1000) | 29 uSec |
| Extended gcd | a1000.gcdExtended(b1000) | 81 uSec |
| Least common multiple | a1000.lcm(b1000) | 32 uSec |
| Make random number | c2000.randomLessThan() | 1.2 uSec |
| Square | c2000 \*\* 2 | 0.68 uSec |
| Square root | c2000.sqrt() | 13 uSec |
| Square root and remainder | c2000.sqrtRemainder() | 13 uSec |
| Is perfect square | (c2000 \* c2000).isPerfectSquare() | 16 uSec |
| Square root modulo | b1000.sqrtMod(p1000) | 1.6 mSec |
| Power | c2000 \*\* 111 | 1.9 mSec |
| Root | c2000.root(111) | 15 uSec |
| Root and remainder | c2000.rootRemainder(111) | 17 uSec |
| Is perfect root | c2000.isPerfectRoot() | 13 mSec |
| Jacobi symbol | c2000.jacobiSymbol(p1000) | 0.15 mSec |
| Kronecker symbol | c2000.kroneckerSymbol(p1000) | 0.15 mSec |
| Bernoulli number | BFraction.bernoulli(1000) | 83 mSec |


```
a1000 = 3187705437890850041662973758105262878153514794996698172406519277876060364087986868049465132757493318066301987043192958841748826350731448419937544810921786918975580180410200630645469411588934094075222404396990984350815153163569041641732160380739556436955287671287935796642478260435292021117614349253825
b1000 = 9159373012373110951130589007821321098436345855865428979299172149373720601254669552044211236974571462005332583657082428026625366060511329189733296464187785766230514564038057370938741745651937465362625449921195096442684523511715110908407508139315000469851121118117438147266381183636498494901233452870695
c2000 = 1190583332681083129323588684910845359379915367459759242106618067261956856381281184752008892106576666833853411939711280970145570546868549934865719229538926506588929417873149597614787608112658086250354719939407543740242931571462165384138560315454455247539461818779966171917173966217706187439870264672508450210272481951994459523586160979759782950984370978171111340529321052541588344733968902238813379990628157732181128074253104347868153860527298911917508606081710893794973605227829729403843750412766366804402629686458092685235454222856584200220355212623917637542398554907364450159627359316156463617143173
p1000 (probably a prime) = 7662841304438384296568220077355872003841475576593385710590818274399706072141018649398767137142090308734613594718593893634649122767374115742644499040193270857876678047220373151142747088797516044505739487695946446362769947024029728822155570722524629197074319602110260674029276185098937139753025851896997
```

## Fractions
Fractions are represented as BFraction values consisting of a numerator BInt value and a denominator BInt value. The representation is normalized:

 - The numerator and denominator have no common factors except 1
 - The denominator is always positive
 - Zero is represented as 0/1

### Creating BFraction's
Fractions are created by

 - Specifying the numerator and denominator explicitly f.ex. BFraction(17, 4)
 - Specifying the decimal value explictly f.ex. BFraction(4.25)
 - Using a string representation f.ex. BFraction("4.25")! or equivalently BFraction("425E-2")!

Defining a fraction by giving its decimal value (like 4.25) might lead to surprises,
because not all decimal values can be represented exactly as a floating point number.
For example, one might think that BFraction(0.1) would equal 1/10,
but in fact it equals 3602879701896397 / 36028797018963968 = 0.1000000000000000055511151231257827021181583404541015625

### Converting BFraction's
BFraction values can be converted to String values, to decimal String values and to Double values.

```swift
  let x = BFraction(1000, 7)
  
  // To String
  let s1 = x.asString() // s1 = "1000 / 7"
  
  // To decimal String
  let s1 = x.asDecimalString(precision: 8, exponential: false) // s1 = "142.85714"
  let s2 = x.asDecimalString(precision: 8, exponential: true) // s2 = "1.4285714E+2"
  
  // To Double
  let d = x.asDouble() // d = 142.8571428571429
```
	  
### Operations
The operations available to fractions are:

 - Arithmetic

	 - addition
	 - subtraction
	 - multiplication
	 - division
	 - modulo an integer
	 - exponentiation


 - Rounding to an integer

	 - round - to nearest integer
	 - truncate - towards 0
	 - ceil - towards +infinity
	 - floor - towards -infinity


 - Comparison - the six standard operations `==` `!=` `<` `<=` `>` `>=`

### Bernoulli Numbers
The static function

```swift
  let bn = BFraction.bernoulli(n)
```

computes the n'th (n >= 0) Bernoulli number, which is a rational number.
For example

```swift
  print(BFraction.bernoulli(60))
  print(BFraction.bernoulli(60).asDecimalString(precision: 20, exponential: true))
```   

would print

```
  -1215233140483755572040304994079820246041491 / 56786730
  -2.1399949257225333665E+34
```

The static function

```swift
  let x = BFraction.bernoulliSequence(n)
```

computes the n even numbered Bernoulli numbers B(0), B(2) ... B(2 \* n - 2).

## Chinese Remainder Theorem
The CRT structure implements the Chinese Remainder Theorem. Construct a CRT instance from a given set of moduli,
and then use the *compute* method to compute the CRT value for a given set of residues. The same instance can be reused
for any set of input data, as long as the moduli are the same.
This is relevant because it takes longer to create the CRT instance than to compute the CRT value.
For example:

```swift
  let moduli = [3, 5, 7]
  let residues = [2, 2, 6]
  let crt = CRT(moduli)!
  print("CRT value:", crt.compute(residues))
```

would print

```
  CRT value: 62
```

## Algorithms
Some of the algorithms used in BigInt are described below.

### Multiplication

 - Schonhage-Strassen FFT based algorithm for numbers above 384000 bits
 - ToomCook-3 algorithm for numbers above 12800 bits
 - Karatsuba algorithm for numbers above 6400 bits
 - Basecase - Knuth algorithm M

### Division and Remainder

 - Burnikel-Ziegler algorithm for divisors above 3840 bits provided the dividend has at least 3840 bits more than the divisor
 - Basecase - Knuth algorithm D
 - Exact Division - Jebelean's exact division algorithm

### Greatest Common Divisor and Extended Greatest Common Divisor
Lehmer's algorithm [KNUTH] chapter 4.5.2, with binary GCD basecase.

### Modular Exponentiation
Sliding window algorithm 14.85 from [HANDBOOK] using Barrett reduction for exponents with fewer than 2048 bits
and Montgomery reduction for larger exponents.

### Inverse Modulus
If the modulus is a (not too large) power of 2, the algorithm from [KOC] section 7.
Else, it is computed via the extended GCD algorithm.

### Square Root
Algorithm 1.12 (SqrtRem) from [BRENT] with algorithm 9.2.11 from [CRANDALL] as basecase.

### Square Root Modulo a Prime Number<
Algorithm 2.3.8 from [CRANDALL].

### Prime Number Test
Miller-Rabin test.

### Prime Number Generation
The algorithm from Java BigInteger translated to Swift.

### Factorial
The 'SplitRecursive' algorithm from Peter Luschny: https://www.luschny.de

### Fibonacci
The 'fastDoubling' algorithm from Project Nayuki: https://www.nayuki.io

### Jacobi and Kronecker symbols
Algorithm 2.3.5 from [CRANDALL].

### Bernoulli Numbers
Computed via Tangent numbers which is fast because it only involves integer arithmetic
but no fractional arithmetic.

### Chinese Remainder Theorem
The Garner algorithm 2.1.7 from [CRANDALL].

## References

Algorithms from the following books and papers have been used in the implementation.
There are references in the source code where appropriate.

  1. [BRENT]: Brent and Zimmermann: Modern Computer Arithmetic, 2010
  2. [BURNIKEL]: Burnikel and Ziegler: Fast Recursive Division, October 1998
  3. [CRANDALL]: Crandall and Pomerance: Prime Numbers - A Computational Perspective. Second Edition, Springer 2005
  3. [GRANLUND]: Moller and Granlund: Improved Division by Invariant Integers, 2011
  3. [HACKER]: Henry S. Warren, Jr.: Hacker's Delight. Second Edition, Addison-Wesley
  3. [HANDBOOK]: Menezes, Oorschot, Vanstone: Handbook of Applied Cryptography. CRC Press 1996
  3. [JEBELEAN]: Tudor Jebelean: An Algorithm for Exact Division. Journal of Symbolic Computation, volume 15, 1993
  3. [KNUTH]: Donald E. Knuth: Seminumerical Algorithms, Third Edition
  3. [KOC]: Cetin Kaya Koc: A New Algorithm for Inversion mod p^k
