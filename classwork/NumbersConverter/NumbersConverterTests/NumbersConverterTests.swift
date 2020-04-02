//
//  NumbersConverterTests.swift
//  NumbersConverterTests
//
//  Created by Macbook Pro 15 on 3/31/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import XCTest
@testable import NumbersConverter

class NumbersConverterTests: XCTestCase {
    var controller: ViewController = ViewController()
//    var decode: ((String) -> String)?
    
    override func setUp() {
    }
    
    func test_decode_binary() {
        XCTAssertEqual(controller.decodeNumbers(digits: "0", base: 2), 0)
        XCTAssertEqual(controller.decodeNumbers(digits: "1", base: 2), 1)
        XCTAssertEqual(controller.decodeNumbers(digits: "10", base: 2), 2)
        XCTAssertEqual(controller.decodeNumbers(digits: "11", base: 2), 3)
        XCTAssertEqual(controller.decodeNumbers(digits: "100", base: 2), 4)
        XCTAssertEqual(controller.decodeNumbers(digits: "101", base: 2), 5)
        XCTAssertEqual(controller.decodeNumbers(digits: "110", base: 2), 6)
        XCTAssertEqual(controller.decodeNumbers(digits: "111", base: 2), 7)
        XCTAssertEqual(controller.decodeNumbers(digits: "1000", base: 2), 8)
        XCTAssertEqual(controller.decodeNumbers(digits: "1001", base: 2), 9)
        XCTAssertEqual(controller.decodeNumbers(digits: "1010", base: 2), 10)
        XCTAssertEqual(controller.decodeNumbers(digits: "1011", base: 2), 11)
        XCTAssertEqual(controller.decodeNumbers(digits: "1100", base: 2), 12)
        XCTAssertEqual(controller.decodeNumbers(digits: "1101", base: 2), 13)
        XCTAssertEqual(controller.decodeNumbers(digits: "1110", base: 2), 14)
        XCTAssertEqual(controller.decodeNumbers(digits: "1111", base: 2), 15)
    }

    func test_decode_decimal() {
        XCTAssertEqual(controller.decodeNumbers(digits: "5", base: 10), 5)
        XCTAssertEqual(controller.decodeNumbers(digits: "9", base: 10), 9)
        XCTAssertEqual(controller.decodeNumbers(digits: "10", base: 10), 10)
        XCTAssertEqual(controller.decodeNumbers(digits: "25", base: 10), 25)
        XCTAssertEqual(controller.decodeNumbers(digits: "64", base: 10), 64)
        XCTAssertEqual(controller.decodeNumbers(digits: "99", base: 10), 99)
        XCTAssertEqual(controller.decodeNumbers(digits: "123", base: 10), 123)
        XCTAssertEqual(controller.decodeNumbers(digits: "789", base: 10), 789)
        XCTAssertEqual(controller.decodeNumbers(digits: "2345", base: 10), 2345)
        XCTAssertEqual(controller.decodeNumbers(digits: "6789", base: 10), 6789)
        XCTAssertEqual(controller.decodeNumbers(digits: "13579", base: 10), 13579)
        XCTAssertEqual(controller.decodeNumbers(digits: "24680", base: 10), 24680)
    }

    func test_decode_hexadecimal() {
        XCTAssertEqual(controller.decodeNumbers(digits: "a", base: 16), 10)
        XCTAssertEqual(controller.decodeNumbers(digits: "f", base: 16), 15)
        XCTAssertEqual(controller.decodeNumbers(digits: "99", base: 16), 153)
        XCTAssertEqual(controller.decodeNumbers(digits: "ff", base: 16), 255)
        XCTAssertEqual(controller.decodeNumbers(digits: "ace", base: 16), 2766)
        XCTAssertEqual(controller.decodeNumbers(digits: "cab", base: 16), 3243)
        XCTAssertEqual(controller.decodeNumbers(digits: "bead", base: 16), 48813)
        XCTAssertEqual(controller.decodeNumbers(digits: "face", base: 16), 64206)
        XCTAssertEqual(controller.decodeNumbers(digits: "c0ffee", base: 16), 12648430)
        XCTAssertEqual(controller.decodeNumbers(digits: "facade", base: 16), 16435934)
        XCTAssertEqual(controller.decodeNumbers(digits: "deadbeef", base: 16), 3735928559)
        XCTAssertEqual(controller.decodeNumbers(digits: "f007ba11", base: 16), 4027038225)
    }

    func test_decode_10() {
        XCTAssertEqual(controller.decodeNumbers(digits: "10", base: 2), 2)
        XCTAssertEqual(controller.decodeNumbers(digits: "10", base: 4), 4)
        XCTAssertEqual(controller.decodeNumbers(digits: "10", base: 8), 8)
        XCTAssertEqual(controller.decodeNumbers(digits: "10", base: 10), 10)
        XCTAssertEqual(controller.decodeNumbers(digits: "10", base: 16), 16)
        XCTAssertEqual(controller.decodeNumbers(digits: "10", base: 25), 25)
        XCTAssertEqual(controller.decodeNumbers(digits: "10", base: 32), 32)
        XCTAssertEqual(controller.decodeNumbers(digits: "10", base: 36), 36)
    }

    func test_decode_1010() {
        XCTAssertEqual(controller.decodeNumbers(digits: "1010", base: 2), 10)
        XCTAssertEqual(controller.decodeNumbers(digits: "1010", base: 4), 68)
        XCTAssertEqual(controller.decodeNumbers(digits: "1010", base: 8), 520)
        XCTAssertEqual(controller.decodeNumbers(digits: "1010", base: 10), 1010)
        XCTAssertEqual(controller.decodeNumbers(digits: "1010", base: 16), 4112)
        XCTAssertEqual(controller.decodeNumbers(digits: "1010", base: 25), 15650)
        XCTAssertEqual(controller.decodeNumbers(digits: "1010", base: 32), 32800)
        XCTAssertEqual(controller.decodeNumbers(digits: "1010", base: 36), 46692)
    }

    func test_decode_101101() {
        XCTAssertEqual(controller.decodeNumbers(digits: "101101", base: 2), 45)
        XCTAssertEqual(controller.decodeNumbers(digits: "101101", base: 4), 1105)
        XCTAssertEqual(controller.decodeNumbers(digits: "101101", base: 8), 33345)
        XCTAssertEqual(controller.decodeNumbers(digits: "101101", base: 10), 101101)
        XCTAssertEqual(controller.decodeNumbers(digits: "101101", base: 16), 1052929)
        XCTAssertEqual(controller.decodeNumbers(digits: "101101", base: 25), 9781876)
        XCTAssertEqual(controller.decodeNumbers(digits: "101101", base: 32), 33588225)
        XCTAssertEqual(controller.decodeNumbers(digits: "101101", base: 36), 60514129)
    }

    func test_encode_binary() {
        //assert encode(0, 2), "0"  # Should "" be valid?
        XCTAssertEqual(controller.encodeNumbers(number: 1, base: 2), "1")
        XCTAssertEqual(controller.encodeNumbers(number: 2, base: 2), "10")
        XCTAssertEqual(controller.encodeNumbers(number: 3, base: 2), "11")
        XCTAssertEqual(controller.encodeNumbers(number: 4, base: 2), "100")
        XCTAssertEqual(controller.encodeNumbers(number: 5, base: 2), "101")
        XCTAssertEqual(controller.encodeNumbers(number: 6, base: 2), "110")
        XCTAssertEqual(controller.encodeNumbers(number: 7, base: 2), "111")
        XCTAssertEqual(controller.encodeNumbers(number: 8, base: 2), "1000")
        XCTAssertEqual(controller.encodeNumbers(number: 9, base: 2), "1001")
        XCTAssertEqual(controller.encodeNumbers(number: 10, base: 2), "1010")
        XCTAssertEqual(controller.encodeNumbers(number: 11, base: 2), "1011")
        XCTAssertEqual(controller.encodeNumbers(number: 12, base: 2), "1100")
        XCTAssertEqual(controller.encodeNumbers(number: 13, base: 2), "1101")
        XCTAssertEqual(controller.encodeNumbers(number: 14, base: 2), "1110")
        XCTAssertEqual(controller.encodeNumbers(number: 15, base: 2), "1111")
    }

    func test_encode_decimal() {
        //    XCTAssertEqual(controller.encodeNumbers(number: 0, 10), "0"  # Should "" be valid?
        XCTAssertEqual(controller.encodeNumbers(number: 5, base: 10), "5")
        XCTAssertEqual(controller.encodeNumbers(number: 10, base: 10), "10")
        XCTAssertEqual(controller.encodeNumbers(number: 25, base: 10), "25")
        XCTAssertEqual(controller.encodeNumbers(number: 64, base: 10), "64")
        XCTAssertEqual(controller.encodeNumbers(number: 99, base: 10), "99")
        XCTAssertEqual(controller.encodeNumbers(number: 123, base: 10), "123")
        XCTAssertEqual(controller.encodeNumbers(number: 789, base: 10), "789")
        XCTAssertEqual(controller.encodeNumbers(number: 2345, base: 10), "2345")
        XCTAssertEqual(controller.encodeNumbers(number: 6789, base: 10), "6789")
        XCTAssertEqual(controller.encodeNumbers(number: 13579, base: 10), "13579")
        XCTAssertEqual(controller.encodeNumbers(number: 24680, base: 10), "24680")
    }

    func test_encode_hexadecimal() {
        XCTAssertEqual(controller.encodeNumbers(number: 10, base: 16), "a")
        XCTAssertEqual(controller.encodeNumbers(number: 15, base: 16), "f")
        XCTAssertEqual(controller.encodeNumbers(number: 153, base: 16), "99")
        XCTAssertEqual(controller.encodeNumbers(number: 255, base: 16), "ff")
        XCTAssertEqual(controller.encodeNumbers(number: 2766, base: 16), "ace")
        XCTAssertEqual(controller.encodeNumbers(number: 3243, base: 16), "cab")
        XCTAssertEqual(controller.encodeNumbers(number: 48813, base: 16), "bead")
        XCTAssertEqual(controller.encodeNumbers(number: 64206, base: 16), "face")
        XCTAssertEqual(controller.encodeNumbers(number: 12648430, base: 16), "c0ffee")
        XCTAssertEqual(controller.encodeNumbers(number: 16435934, base: 16), "facade")
        XCTAssertEqual(controller.encodeNumbers(number: 3735928559, base: 16), "deadbeef")
        XCTAssertEqual(controller.encodeNumbers(number: 4027038225, base: 16), "f007ba11")
    }

    func test_encode_1234() {
        XCTAssertEqual(controller.encodeNumbers(number: 1234, base: 2), "10011010010")
        XCTAssertEqual(controller.encodeNumbers(number: 1234, base: 3), "1200201")
        XCTAssertEqual(controller.encodeNumbers(number: 1234, base: 4), "103102")
        XCTAssertEqual(controller.encodeNumbers(number: 1234, base: 5), "14414")
        XCTAssertEqual(controller.encodeNumbers(number: 1234, base: 8), "2322")
        XCTAssertEqual(controller.encodeNumbers(number: 1234, base: 10), "1234")
        XCTAssertEqual(controller.encodeNumbers(number: 1234, base: 16), "4d2")
        XCTAssertEqual(controller.encodeNumbers(number: 1234, base: 32), "16i")
    }

    func test_encode_248975() {
        XCTAssertEqual(controller.encodeNumbers(number: 248975, base: 2), "111100110010001111")
        XCTAssertEqual(controller.encodeNumbers(number: 248975, base: 4), "330302033")
        XCTAssertEqual(controller.encodeNumbers(number: 248975, base: 8), "746217")
        XCTAssertEqual(controller.encodeNumbers(number: 248975, base: 10), "248975")
        XCTAssertEqual(controller.encodeNumbers(number: 248975, base: 16), "3cc8f")
        XCTAssertEqual(controller.encodeNumbers(number: 248975, base: 25), "fn90")
        XCTAssertEqual(controller.encodeNumbers(number: 248975, base: 32), "7j4f")
        XCTAssertEqual(controller.encodeNumbers(number: 248975, base: 36), "5c3z")
    }

    func test_encode_into_10() {
        XCTAssertEqual(controller.encodeNumbers(number: 2, base: 2), "10")
        XCTAssertEqual(controller.encodeNumbers(number: 4, base: 4), "10")
        XCTAssertEqual(controller.encodeNumbers(number: 8, base: 8), "10")
        XCTAssertEqual(controller.encodeNumbers(number: 10, base: 10), "10")
        XCTAssertEqual(controller.encodeNumbers(number: 16, base: 16), "10")
        XCTAssertEqual(controller.encodeNumbers(number: 25, base: 25), "10")
        XCTAssertEqual(controller.encodeNumbers(number: 32, base: 32), "10")
        XCTAssertEqual(controller.encodeNumbers(number: 36, base: 36), "10")
    }

    func test_encode_into_1010() {
        XCTAssertEqual(controller.encodeNumbers(number: 10, base: 2), "1010")
        XCTAssertEqual(controller.encodeNumbers(number: 68, base: 4), "1010")
        XCTAssertEqual(controller.encodeNumbers(number: 520, base: 8), "1010")
        XCTAssertEqual(controller.encodeNumbers(number: 1010, base: 10), "1010")
        XCTAssertEqual(controller.encodeNumbers(number: 4112, base: 16), "1010")
        XCTAssertEqual(controller.encodeNumbers(number: 15650, base: 25), "1010")
        XCTAssertEqual(controller.encodeNumbers(number: 32800, base: 32), "1010")
        XCTAssertEqual(controller.encodeNumbers(number: 46692, base: 36), "1010")
    }

    func test_encode_into_101101() {
        XCTAssertEqual(controller.encodeNumbers(number: 45, base: 2), "101101")
        XCTAssertEqual(controller.encodeNumbers(number: 1105, base: 4), "101101")
        XCTAssertEqual(controller.encodeNumbers(number: 33345, base: 8), "101101")
        XCTAssertEqual(controller.encodeNumbers(number: 101101, base: 10), "101101")
        XCTAssertEqual(controller.encodeNumbers(number: 1052929, base: 16), "101101")
        XCTAssertEqual(controller.encodeNumbers(number: 9781876, base: 25), "101101")
        XCTAssertEqual(controller.encodeNumbers(number: 33588225, base: 32), "101101")
        XCTAssertEqual(controller.encodeNumbers(number: 60514129, base: 36), "101101")
    }

    func test_convert_from_binary() {
//        func convertNumbers(digits: String, base1: Int, base2: Int) -> String {
        XCTAssertEqual(controller.convertNumbers(digits: "", base1: -1, base2: -1), "")
        XCTAssertEqual(controller.convertNumbers(digits: "1101", base1: 2, base2: 3), "111")
        XCTAssertEqual(controller.convertNumbers(digits: "1101", base1: 2, base2: 4), "31")
        XCTAssertEqual(controller.convertNumbers(digits: "1101", base1: 2, base2: 8), "15")
        XCTAssertEqual(controller.convertNumbers(digits: "1101", base1: 2, base2: 10), "13")
        XCTAssertEqual(controller.convertNumbers(digits: "101010", base1: 2, base2: 3), "1120")
        XCTAssertEqual(controller.convertNumbers(digits: "101010", base1: 2, base2: 4), "222")
        XCTAssertEqual(controller.convertNumbers(digits: "101010", base1: 2, base2: 8), "52")
        XCTAssertEqual(controller.convertNumbers(digits: "101010", base1: 2, base2: 10), "42")
        XCTAssertEqual(controller.convertNumbers(digits: "101010", base1: 2, base2: 16), "2a")
        XCTAssertEqual(controller.convertNumbers(digits: "101010", base1: 2, base2: 25), "1h")
        XCTAssertEqual(controller.convertNumbers(digits: "101010", base1: 2, base2: 32), "1a")
        XCTAssertEqual(controller.convertNumbers(digits: "101010", base1: 2, base2: 36), "16")
    }

    func test_convert_to_binary() {
        XCTAssertEqual(controller.convertNumbers(digits: "111", base1: 3, base2: 2), "1101")
        XCTAssertEqual(controller.convertNumbers(digits: "31", base1: 4, base2: 2), "1101")
        XCTAssertEqual(controller.convertNumbers(digits: "15", base1: 8, base2: 2), "1101")
        XCTAssertEqual(controller.convertNumbers(digits: "13", base1: 10, base2: 2), "1101")
        XCTAssertEqual(controller.convertNumbers(digits: "101", base1: 3, base2: 2), "1010")
        XCTAssertEqual(controller.convertNumbers(digits: "101", base1: 4, base2: 2), "10001")
        XCTAssertEqual(controller.convertNumbers(digits: "101", base1: 8, base2: 2), "1000001")
        XCTAssertEqual(controller.convertNumbers(digits: "101", base1: 10, base2: 2), "1100101")
        XCTAssertEqual(controller.convertNumbers(digits: "101", base1: 16, base2: 2), "100000001")
        XCTAssertEqual(controller.convertNumbers(digits: "101", base1: 25, base2: 2), "1001110010")
        XCTAssertEqual(controller.convertNumbers(digits: "101", base1: 32, base2: 2), "10000000001")
        XCTAssertEqual(controller.convertNumbers(digits: "101", base1: 36, base2: 2), "10100010001")
    }

    func test_convert_hexadecimal_to_decimal() {
        XCTAssertEqual(controller.convertNumbers(digits: "a", base1: 16, base2: 10), "10")
        XCTAssertEqual(controller.convertNumbers(digits: "f", base1: 16, base2: 10), "15")
        XCTAssertEqual(controller.convertNumbers(digits: "99", base1: 16, base2: 10), "153")
        XCTAssertEqual(controller.convertNumbers(digits: "ff", base1: 16, base2: 10), "255")
        XCTAssertEqual(controller.convertNumbers(digits: "ace", base1: 16, base2: 10), "2766")
        XCTAssertEqual(controller.convertNumbers(digits: "cab", base1: 16, base2: 10), "3243")
        XCTAssertEqual(controller.convertNumbers(digits: "bead", base1: 16, base2: 10), "48813")
        XCTAssertEqual(controller.convertNumbers(digits: "face", base1: 16, base2: 10), "64206")
        XCTAssertEqual(controller.convertNumbers(digits: "c0ffee", base1: 16, base2: 10), "12648430")
        XCTAssertEqual(controller.convertNumbers(digits: "facade", base1: 16, base2: 10), "16435934")
        XCTAssertEqual(controller.convertNumbers(digits: "deadbeef", base1: 16, base2: 10), "3735928559")
        XCTAssertEqual(controller.convertNumbers(digits: "f007ba11", base1: 16, base2: 10), "4027038225")
    }

    func test_convert_decimal_to_hexadecimal() {
        XCTAssertEqual(controller.convertNumbers(digits: "10", base1: 10, base2: 16), "a")
        XCTAssertEqual(controller.convertNumbers(digits: "15", base1: 10, base2: 16), "f")
        XCTAssertEqual(controller.convertNumbers(digits: "153", base1: 10, base2: 16), "99")
        XCTAssertEqual(controller.convertNumbers(digits: "255", base1: 10, base2: 16), "ff")
        XCTAssertEqual(controller.convertNumbers(digits: "2766", base1: 10, base2: 16), "ace")
        XCTAssertEqual(controller.convertNumbers(digits: "3243", base1: 10, base2: 16), "cab")
        XCTAssertEqual(controller.convertNumbers(digits: "48813", base1: 10, base2: 16), "bead")
        XCTAssertEqual(controller.convertNumbers(digits: "64206", base1: 10, base2: 16), "face")
        XCTAssertEqual(controller.convertNumbers(digits: "12648430", base1: 10, base2: 16), "c0ffee")
        XCTAssertEqual(controller.convertNumbers(digits: "16435934", base1: 10, base2: 16), "facade")
        XCTAssertEqual(controller.convertNumbers(digits: "3735928559", base1: 10, base2: 16), "deadbeef")
        XCTAssertEqual(controller.convertNumbers(digits: "4027038225", base1: 10, base2: 16), "f007ba11")
    }

    func test_convert_hexadecimal_to_binary() {
        XCTAssertEqual(controller.convertNumbers(digits: "a", base1: 16, base2: 2), "1010")
        XCTAssertEqual(controller.convertNumbers(digits: "b", base1: 16, base2: 2), "1011")
        XCTAssertEqual(controller.convertNumbers(digits: "c", base1: 16, base2: 2), "1100")
        XCTAssertEqual(controller.convertNumbers(digits: "d", base1: 16, base2: 2), "1101")
        XCTAssertEqual(controller.convertNumbers(digits: "e", base1: 16, base2: 2), "1110")
        XCTAssertEqual(controller.convertNumbers(digits: "f", base1: 16, base2: 2), "1111")
        XCTAssertEqual(controller.convertNumbers(digits: "c840", base1: 16, base2: 2), "1100100001000000")
        XCTAssertEqual(controller.convertNumbers(digits: "d951", base1: 16, base2: 2), "1101100101010001")
        XCTAssertEqual(controller.convertNumbers(digits: "ea62", base1: 16, base2: 2), "1110101001100010")
        XCTAssertEqual(controller.convertNumbers(digits: "fb73", base1: 16, base2: 2), "1111101101110011")
    }

    func test_convert_binary_to_hexadecimal() {
        XCTAssertEqual(controller.convertNumbers(digits: "1010", base1: 2, base2: 16), "a")
        XCTAssertEqual(controller.convertNumbers(digits: "1011", base1: 2, base2: 16), "b")
        XCTAssertEqual(controller.convertNumbers(digits: "1100", base1: 2, base2: 16), "c")
        XCTAssertEqual(controller.convertNumbers(digits: "1101", base1: 2, base2: 16), "d")
        XCTAssertEqual(controller.convertNumbers(digits: "1110", base1: 2, base2: 16), "e")
        XCTAssertEqual(controller.convertNumbers(digits: "1111", base1: 2, base2: 16), "f")
        XCTAssertEqual(controller.convertNumbers(digits: "1100100001000000", base1: 2, base2: 16), "c840")
        XCTAssertEqual(controller.convertNumbers(digits: "1101100101010001", base1: 2, base2: 16), "d951")
        XCTAssertEqual(controller.convertNumbers(digits: "1110101001100010", base1: 2, base2: 16), "ea62")
        XCTAssertEqual(controller.convertNumbers(digits: "1111101101110011", base1: 2, base2: 16), "fb73")
    }
}
