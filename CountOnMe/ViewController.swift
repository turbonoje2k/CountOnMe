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
    
    var calculator = CalculatorModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        calculator.delegate = self
    }
    
    func warnigRepeatOperator() {
        let alertVC = UIAlertController(title: "Zéro!", message: "Operator already exist !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {

        guard let titleButton = sender.title(for: .normal) else { return }
        calculator.addStringNumber(number: titleButton)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calculator.tappedAddition()
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {

        calculator.tappedSubstraction()
    }
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        calculator.tappedMultiplication()
    }
    @IBAction func tappedDivisionButton(_ sender: UIButton) {

        calculator.tappedDivision()
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculator.tappedEqual()
    }
}

//EXTENSION
extension ViewController: CalculatorDelegate {
    func displayAlert(message: String) {
        print("alert")
    }
    
    func didReceiveData(data: String) {
        textView.text = calculator.textView
    }
    
    
}
