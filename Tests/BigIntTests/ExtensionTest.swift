//
//  Test.swift
//  BigInt
//
//  Created by Mike Griebling on 11.10.2024.
//

import XCTest
@testable import BigInt

class ExtensionTest: XCTestCase {
    
    func test1() {
        let x = BInt(12345678901234567890123456789)
        let l = BInt(integerLiteral: 12345678901234567890123456789)
        let s = BInt("12345678901234567890123456789")
        XCTAssertTrue(BInt.isSigned)
        XCTAssertEqual(BInt(clamping: 12345), BInt(12345))
        XCTAssertEqual(l, s)
        XCTAssertEqual(l, x)
        XCTAssertTrue(BInt.zero.words == [0])
        XCTAssertTrue(x.words == [5097733592125636885, 669260594])
        XCTAssertEqual(BInt(-123_890), BInt("-123890"))
        let x1 = x << BInt(5)
        var y1 = x; y1 <<= 5
        XCTAssertEqual(x1, y1)
        let x2 = x >> BInt(5)
        var y2 = x; y2 >>= 5
        XCTAssertEqual(x2, y2)
        var x3 = x; x3 >>= BInt(1000)
        XCTAssertEqual(x3, BInt.zero)
        XCTAssertNil(BInt(exactly: 123.45))
        XCTAssertEqual(BInt(123.45), BInt(123))
        XCTAssertEqual(BInt(exactly: 123), BInt(123))
        XCTAssertEqual(BInt(truncatingIfNeeded: 1234567890), BInt(1234567890))
        XCTAssertEqual(x.magnitude, x)
    }
    
}
