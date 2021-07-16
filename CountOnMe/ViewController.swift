//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
    }
    
    
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func warnigRepeatOperator() {
        let alertVC = UIAlertController(title: "Zéro!", message: "Operator already exist !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if expressionHaveResult {
            textView.text = ""
        }
        
        textView.text.append(numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" + ")
        } else {
            warnigRepeatOperator()
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" - ")
        } else {
            warnigRepeatOperator()
        }
    }
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" * ")
        } else {
            warnigRepeatOperator()
        }
    }
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" / ")
        } else {
            warnigRepeatOperator()
        }
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard expressionIsCorrect else {
            return warnigRepeatOperator()
        }
        
        guard expressionHaveEnoughElement else {
            return warnigRepeatOperator()
        }
        
        // Create local copy of operations
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
            
            let result: Double
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "*": result = left * right
            case "/": result = division(left: left, right: right)
            default: fatalError("Unknown operator !")
            }
            
            //            operationsToReduce = Array(operationsToReduce(3))
            for _ in 1...3 {
                operationsToReduce.remove(at: place)
            }
            operationsToReduce.insert("\(result)", at: place)
        }
        
        textView.text.append(" = \(operationsToReduce.first!)")
    }
    
    
    func division(left: Double, right: Double) -> Double {
        //        guard right == 0 else { return -1 }
            if right == 0 {
                textView.text.append("not void ")
            }
            let result = left / right
            return result
        }

}

