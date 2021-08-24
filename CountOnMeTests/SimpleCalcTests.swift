//
//  SimpleCalcTests.swift
//  CountOnMeTests
//
//  Created by noje on 19/08/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {
    var simpleCalc: CalculatorModel!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        simpleCalc = CalculatorModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        simpleCalc = nil
    }

    func testAddition() {
        simpleCalc.addStringNumber(number: "3")
        simpleCalc.tappedAddition()
        simpleCalc.addStringNumber(number: "4")
        simpleCalc.calculate()

        XCTAssert(simpleCalc.result == 7)
    }

    func testSubstraction() {
        simpleCalc.addStringNumber(number: "2")
        simpleCalc.tappedSubstraction()
        simpleCalc.addStringNumber(number: "1")
        simpleCalc.calculate()

        XCTAssert(simpleCalc.result == 1)
    }

    func testMultiplication() {
        simpleCalc.addStringNumber(number: "2")
        simpleCalc.tappedMultiplication()
        simpleCalc.addStringNumber(number: "2")
        simpleCalc.calculate()

        XCTAssert(simpleCalc.result == 4)
    }

    func testDivision() {
        simpleCalc.addStringNumber(number: "4")
        simpleCalc.tappedDivision()
        simpleCalc.addStringNumber(number: "2")
        simpleCalc.calculate()

        XCTAssert(simpleCalc.result == 2)
    }

    func testReset() {

    }

    func testPriorityOperande() {

    }

    func testErrorMsg() {

    }

    func divisionPerZero() {

    }

    func testDoubleOperande() {

    }

    func testOperandeberforeCalc() {

    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
