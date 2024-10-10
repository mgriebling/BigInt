//
//  BigInt-Extensions.swift
//
//  Created by Mike Griebling on 13.07.2023.
//

extension BInt : SignedInteger {
    public static var isSigned: Bool { true }
    
    public init<T>(_ source: T) where T : BinaryInteger {
        if let int = BInt(exactly: source) {
            self = int
        } else {
            self.init(0)
        }
    }
    
    public init<T>(clamping source: T) where T : BinaryInteger {
        self.init(source)
    }
    
    public init<T>(truncatingIfNeeded source: T) where T : BinaryInteger {
        self.init(source)
    }
    
    public init?<T>(exactly source: T) where T : BinaryInteger {
        var isNegative = false
        if source.signum() < 0 {
            isNegative = true
        }
        let words = source.words
        var bwords = Limbs()
        for word in words {
            if isNegative { bwords.append(UInt64(~word)) }
            else { bwords.append(UInt64(word)) }
        }
        self.init(bwords, false)
        if isNegative { self += 1; self.negate() }
    }
    
    public init?<T>(exactly source: T) where T : BinaryFloatingPoint {
        guard source.isFinite else { return nil }
        if source.rounded() != source { return nil }
        if source.isZero { self.init(0); return }
        self.init(source)
    }
    
    public init<T>(_ source: T) where T : BinaryFloatingPoint {
        // FIXME: - Support other types of BinaryFloatingPoint
        if let bint = BInt(Double(source)) {
            self = bint
        } else {
            self.init(0)
        }
    }
}

extension BInt : Numeric {
    public var magnitude: BInt { BInt(_magnitude) }
}

extension BInt : BinaryInteger {
    public var words: [UInt] {
        _magnitude.map { UInt($0) }
    }
    
    public static func <<= <RHS:BinaryInteger>(lhs: inout BInt, rhs: RHS) {
        lhs = lhs << Int(rhs)
    }
    
    public static func >>= <RHS:BinaryInteger>(lhs: inout BInt, rhs: RHS) {
        lhs = lhs >> Int(rhs)
    }
}

extension BInt {
    
    /// Constructs a BInt from a StaticBigInt
    ///
    /// - Parameters:
    ///   - value: extended-precision integer literal
    public init(integerLiteral value: StaticBigInt) {
        let isNegative = value.signum() < 0
        let bitWidth = value.bitWidth
        if bitWidth < Int.bitWidth {
            self.init(Int(bitPattern: value[0]))
        } else {
            precondition(value[0].bitWidth == 64, "Requires 64-bit Ints!")
            let noOfWords = (bitWidth / 64) + 1 // must be 64-bit system
            var words = Limbs()
            for index in 0..<noOfWords {
                // StaticBigInt words are 2's complement so negative
                // values needed to be inverted and have one added
                if isNegative { words.append(UInt64(~value[index])) }
                else { words.append(UInt64(value[index])) }
            }
            self.init(words, false)
            if isNegative { self += 1; self.negate() }
        }
    }
}
