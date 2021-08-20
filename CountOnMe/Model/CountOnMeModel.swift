//
//  CountOnMeModel.swift
//  CountOnMe
//
//  Created by noje on 30/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol CalculatorDelegate {
    func displayAlert(message: String)
    func didReceiveData(data: String)
    
}

class CalculatorModel {
    
    var delegate: CalculatorDelegate?
    func sendToControler(data: String) {
        delegate?.didReceiveData(data: data)
    }
    var textView = ""
    var elements: [String] {
        return textView.split(separator: " ").map { "\($0)" }
    }
    var result: Double = 0.00
    
    func expressionIsCorrect(elements: [String]) ->  Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    func expressionHaveEnoughElement(elements: [String])-> Bool {
        return elements.count >= 3
    }
    
    func canAddOperator(elements: [String]) -> Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
    }
    
    func expressionHaveResult(elements: String) ->  Bool {
        return textView.firstIndex(of: "=") != nil
    }
    
    func tappedAddition() {
        if canAddOperator(elements: elements) {
            textView += " + "
        } else {
            print("error: operand already exist")
        }
        return sendToControler(data: "+")
    }
    
    func tappedSubstraction() {
        if canAddOperator(elements: elements) {
            textView += " - "
        } else {
            print("error: operand already exist")
        }
        return sendToControler(data: "-")
    }
    
    func tappedMultiplication() {
        if canAddOperator(elements: elements) {
            textView += " * "
        } else {
            print("error: operand already exist")
        }
        return sendToControler(data: "*")
    }
    
    func tappedDivision() {
        if canAddOperator(elements: elements) {
            textView += " / "
        } else {
            print("error: operand already exist")
        }
        return sendToControler(data: "/")
    }
    
    func addStringNumber(number: String) {
        if expressionHaveResult(elements: textView) {
            textView = ""
        }
        textView += number
        sendToControler(data: number)
    }
    
    func tappedEqual()  {
        guard expressionIsCorrect(elements: elements) else {
            delegate?.displayAlert(message: "Expression not correct")
            return
        }
        guard expressionHaveEnoughElement(elements: elements) else {
            delegate?.displayAlert(message: "not Enought elements")
            return
        }
        calculate()
    }
    
    func calculate() {
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            var place = 0
            // priority for * or / operator
            if let index = operationsToReduce.firstIndex(where: { $0 == "*" || $0 == "/" }) {
                // to force priority to left operator, index -1
                place = index - 1
            }
            guard let left = Double(operationsToReduce[place]) else { return }
            let operand = operationsToReduce[place + 1]
            guard let right = Double(operationsToReduce[place + 2]) else { return }
            
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "*": result = left * right
            case "/": result = division(left: left, right: right)
            default: fatalError("Unknown operator !")
            }
            
            //operationsToReduce = Array(operationsToReduce(3))
            for _ in 1...3 {
                operationsToReduce.remove(at: place)
            }
            operationsToReduce.insert("\(result)", at: place)
        }
        
//textView.append(" = \(operationsToReduce.first!)")
        textView += " = \(operationsToReduce.first ?? "Error")"
        sendToControler(data: textView)
    }
    
    func tappedReset() {
        textView = ""
        return sendToControler(data: textView)
    }
    
    func division(left: Double, right: Double) -> Double {
        //        guard right == 0 else { return -1 }
        if right == 0 {
            textView = "Error"
            delegate?.displayAlert(message: "You can't divise per 0 !")
            return 0.0
        } else {
            let result = left / right
            return result
        }
    }
}



