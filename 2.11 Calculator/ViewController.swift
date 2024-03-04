//
//  ViewController.swift
//  2.11 Calculator
//
//  Created by Cesar Fernandez on 1/26/24.
//

import UIKit

class ViewController: UIViewController {
    
    enum Operators: Int {
        case equals = 0
        case plus = 1
        case minus = 2
        case multiply = 3
        case divide = 4
    }

    @IBOutlet weak var resultLabel: UILabel!
    
    private var result: Double = 0
    private var previousOperator: Operators?
    private var newNumber = true

    var currentInput: String = "" {
        didSet {
            resultLabel.text = currentInput
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func allClearButton(_ sender: UIButton) {
        result = 0
        currentInput = "0"
        previousOperator = nil
        newNumber = true
    }
    
    @IBAction func plusOrMinusButton(_ sender: UIButton) {
        let value = Double(currentInput)!
        currentInput = "\(value * -1)"
    }
    
    @IBAction func percentButton(_ sender: UIButton) {
        var length = currentInput.count
        
        if !currentInput.contains(".") {
            length += 1
        }
        
        let value = Double(currentInput)! * 0.01
        
        if value < 1 {
            length += 2
        }
        
        currentInput = String("\(value)".prefix(length))
    }
    
    @IBAction func operatorButton(_ sender: UIButton) {
        let action = Operators(rawValue: sender.tag)!
        let currentValue = Double(currentInput)!

        if let previousOperator, !self.newNumber {
            switch previousOperator {
            case .equals:
                break
            case .plus:
                result += currentValue
            case .minus:
                result -= currentValue
            case .multiply:
                result *= currentValue
            case .divide:
                result /= currentValue
            }
        } else {
            result = currentValue
        }
        
        self.currentInput = String("\(result)")
        self.previousOperator = action
        self.newNumber = true
    }
    
    @IBAction func decimalButton(_ sender: UIButton) {
        if !currentInput.contains(".") {
            currentInput.append(".")
        }
   }
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        appendToInput(sender.tag)
    }
    
    func appendToInput(_ number: Int) {
        appendToInput("\(number)")
    }

    func appendToInput(_ number: String) {
        if newNumber {
            currentInput = number
            newNumber = false
        } else {
            currentInput.append(number)
        }
    }
}

