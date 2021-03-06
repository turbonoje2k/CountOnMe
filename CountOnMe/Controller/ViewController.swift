//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    var calculator = CalculatorModel()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator.delegate = self
    }

    // MARK: Actions
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

    @IBAction func tappedResetButton(_ sender: UIButton) {
        calculator.tappedReset()
    }
}

// MARK: Extensions
extension ViewController: CalculatorDelegate {
    func displayAlert(message: String) {
        let alertVC = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    func didReceiveData(data: String) {
        textView.text = calculator.textView
        let point = CGPoint(x: 0.0, y: (textView.contentSize.height - textView.bounds.height))
        textView.setContentOffset(point, animated: false)
    }
}
