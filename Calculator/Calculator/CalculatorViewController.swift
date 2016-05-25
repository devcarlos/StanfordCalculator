//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Carlos Alcala on 5/19/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    // MARK : Outlets
    
    @IBOutlet weak var display: UILabel!
    
    // MARK : Properties
    
    var isTyping = false
    
    var calculator = Calculator()
    
    var displayValue: Double {
        get {
            return Double(self.display.text!)!
        }
        set {
            var value = String(newValue)
            let s = value as NSString
            let zero = s.substringFromIndex(s.length-2)
            if zero == ".0" {
                value = value.stringByReplacingOccurrencesOfString(".0", withString: "")
            }
            
            self.display.text = value
        }
    }
    
    
    // MARK : Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK : Actions
    
    @IBAction func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if self.isTyping {
            let text = self.display.text!
            let number = text + digit
            
            if digit == "." {
                if !text.containsString(".") {
                    self.display.text = number
                }
            } else {
                self.display.text = number
            }
        } else {
            self.display.text = digit
        }
        self.isTyping = true
    }
    
    
    @IBAction func performOperation(sender: UIButton) {
        if self.isTyping {
            self.calculator.setOperand(self.displayValue)
            self.isTyping = false
        }
        if let symbol = sender.currentTitle {
            self.calculator.performOperand(symbol)
        }
        self.displayValue = self.calculator.result
    }
}

