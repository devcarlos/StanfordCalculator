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
            self.display.text = String(newValue)
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
            self.display.text = text + digit
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

