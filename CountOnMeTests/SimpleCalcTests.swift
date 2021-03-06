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

    func testGivenNoResult_WhenTappedAddition_ThenResultShouldBeGood() {
        simpleCalc.addStringNumber(number: "3")
        simpleCalc.tappedAddition()
        simpleCalc.addStringNumber(number: "4")
        simpleCalc.tappedEqual()

        XCTAssert(simpleCalc.result == 7)
    }

    func testGivenNoResult_WhenTappedSubstraction_ThenTheResultShouldBeGood() {
        simpleCalc.addStringNumber(number: "2")
        simpleCalc.tappedSubstraction()
        simpleCalc.addStringNumber(number: "1")
        simpleCalc.calculate()

        XCTAssert(simpleCalc.result == 1)
    }

    func testGivenNoResult_WhenTappedMultiplication_ThenResultShouldBeGood() {
        simpleCalc.addStringNumber(number: "2")
        simpleCalc.tappedMultiplication()
        simpleCalc.addStringNumber(number: "2")
        simpleCalc.calculate()

        XCTAssert(simpleCalc.result == 4)
    }

    func testGivenNoResult_WhenTappedDivision_ThenResultShouldBeGood() {
        simpleCalc.addStringNumber(number: "4")
        simpleCalc.tappedDivision()
        simpleCalc.addStringNumber(number: "2")
        simpleCalc.calculate()

        XCTAssert(simpleCalc.result == 2)
    }

    func testGivenResultOnScreen_WhenTappedReset_ThenResultShouldBeErase() {
        simpleCalc.tappedReset()

        XCTAssertEqual(simpleCalc.result == 0.0, simpleCalc.displayAlertInController(message: "") ==
                        simpleCalc.displayAlertInController(message: ""))
    }

    func testGivenMultiplicationAndAddition_WhenTappedCalculate_ThenResultPriorityToMultiplication() {
        simpleCalc.addStringNumber(number: "3")
        simpleCalc.tappedAddition()
        simpleCalc.addStringNumber(number: "4")
        simpleCalc.tappedDivision()
        simpleCalc.addStringNumber(number: "2")
        simpleCalc.calculate()

        XCTAssert(simpleCalc.result == 5)
    }

    func testGivenDivisionNotEnoughtElement_WhenTappedCalculate_ThenErrorMsgAppear() {
        simpleCalc.addStringNumber(number: "2")
        simpleCalc.tappedDivision()
        simpleCalc.tappedEqual()

        XCTAssertEqual(simpleCalc.textView == "2 / ",
                       simpleCalc.displayAlertInController(message: "Not enought elements") ==
                       simpleCalc.displayAlertInController(message: "Not enought elements"))
    }

    func testGivenTappedTwoSubstratctionOperande_WhenTappedEqual_ThenErrorMsgAppear() {
        simpleCalc.addStringNumber(number: "2")
        simpleCalc.tappedSubstraction()
        simpleCalc.tappedSubstraction()

        XCTAssertEqual(simpleCalc.textView == "2 - ",
                       simpleCalc.displayAlertInController(message: "error: operand already exist") ==
                       simpleCalc.displayAlertInController(message: "error: operand already exist"))
    }

    func testGivenTappedTwodivisionOperande_WhenTappedEqual_ThenErrorMsgAppear() {
        simpleCalc.addStringNumber(number: "2")
        simpleCalc.tappedDivision()
        simpleCalc.tappedDivision()

        XCTAssertEqual(simpleCalc.textView == "2 / ",
                       simpleCalc.displayAlertInController(message: "error: operand already exist") ==
                       simpleCalc.displayAlertInController(message: "error: operand already exist"))
    }

    func testGivenTappedTwoMultiplicationOperande_WhenTappedEqual_ThenErrorMsgAppear() {
        simpleCalc.addStringNumber(number: "2")
        simpleCalc.tappedMultiplication()
        simpleCalc.tappedMultiplication()

        XCTAssertEqual(simpleCalc.textView == "2 * ",
                       simpleCalc.displayAlertInController(message: "error: operand already exist") ==
                       simpleCalc.displayAlertInController(message: "error: operand already exist"))
    }

    func testGivenAddStringNumber_WhenTappedNumber_ThenNumberIs() {
        simpleCalc.addStringNumber(number: "3")

        XCTAssert(simpleCalc.textView == "3")
    }

    func testGivenTappedEqual_WhenTappedEqual_thenEmptyString() {
        simpleCalc.tappedEqual()

        XCTAssert(simpleCalc.textView == "")
    }

    func testGiventExpressionIsNotCorrect_WhenTappedEqualWithNoStringNumber_ThenErrorAppear() {
        simpleCalc.addStringNumber(number: "3")
        simpleCalc.tappedAddition()
        simpleCalc.tappedEqual()

        XCTAssertEqual(simpleCalc.textView == "3 + ",
                       simpleCalc.displayAlertInController(message: "Expression not correct") ==
                       simpleCalc.displayAlertInController(message: "Expression not correct"))
    }

    func testGivenDivisionPerZero_WhenTappedDivisionPerZero_ThenMsgErrorAppear() {
        simpleCalc.addStringNumber(number: "4")
        simpleCalc.tappedDivision()
        simpleCalc.addStringNumber(number: "0")
        simpleCalc.calculate()

        XCTAssertEqual(simpleCalc.result == 0.0,
                       simpleCalc.displayAlertInController(message: "You can't divise per 0 !") ==
                       simpleCalc.displayAlertInController(message: "You can't divise per 0 !"))
    }

    func testGivenTappedEqualWithout_whenForgetToAddaSecondNumberToCalc_ThenPopUpAppear() {
        simpleCalc.addStringNumber(number: "3")
        simpleCalc.tappedEqual()

        XCTAssert(simpleCalc.textView == "3")
    }

    func testGivenTappedDoubleOperande_WhenTappedAdditionTwice_ThenMsgOperandeAlreadyExistAppear() {
        simpleCalc.addStringNumber(number: "3")
        simpleCalc.tappedAddition()
        simpleCalc.tappedAddition()

        XCTAssertEqual(simpleCalc.textView == "3 + ",
                       simpleCalc.displayAlertInController(message: "operand already exist") ==
                       simpleCalc.displayAlertInController(message: "operand already exist"))
    }

    func testGivenOperandeberforeCalc_WhenTappedMultiplicationOperandeBeforeNumber_ThenCrash() {
        simpleCalc.tappedSubstraction()
        simpleCalc.addStringNumber(number: "2")
        simpleCalc.tappedMultiplication()
        simpleCalc.addStringNumber(number: "2")
        simpleCalc.calculate()

        //TODO: A FINIR
    }

    func testGivenAllOperandeCalc_WhenTheCalcGetAllOperande_ThenThePriorityOfOperandeIsRespected() {
        simpleCalc.addStringNumber(number: "2")
        simpleCalc.tappedAddition()
        simpleCalc.addStringNumber(number: "3")
        simpleCalc.tappedSubstraction()
        simpleCalc.addStringNumber(number: "3")
        simpleCalc.tappedDivision()
        simpleCalc.addStringNumber(number: "1")
        simpleCalc.tappedMultiplication()
        simpleCalc.addStringNumber(number: "2")
        simpleCalc.calculate()

        XCTAssert(simpleCalc.result == -1.0)
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
