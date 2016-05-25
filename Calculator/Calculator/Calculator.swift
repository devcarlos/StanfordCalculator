//
//  Calculator.swift
//  Calculator
//
//  Created by Carlos Alcala on 5/19/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import Foundation

//Factorial Function (for small numbers)

func factorial(n: Double) -> Double {
    if n >= 0 {
        return n == 0 ? 1 : n * factorial(n - 1)
    } else {
        return 0 / 0
    }
}

class Calculator {
    
    private var accumulator = 0.0
    
    enum Operation {
        case Constant(Double)
        case Unary((Double) -> Double)
        case Binary((Double, Double) -> Double)
        case Equal
    }
    
    var result: Double {
        get{
            return accumulator
        }
    }
    
    var operations: Dictionary<String, Operation> = [
        "AC": Operation.Constant(0),
        "∏": Operation.Constant(M_PI),
        "∏/2": Operation.Constant(M_PI_2),
        "∏/4": Operation.Constant(M_PI_4),
        "e": Operation.Constant(M_E),
        "e^x": Operation.Unary({ pow(M_E, $0) }),
        "±": Operation.Unary({-$0}),
        "%": Operation.Unary({$0/100}),
        "√": Operation.Unary(sqrt),
        "sin": Operation.Unary(sin),
        "cos": Operation.Unary(cos),
        "tan": Operation.Unary(tan),
        "sinh": Operation.Unary(sinh),
        "cosh": Operation.Unary(cosh),
        "tanh": Operation.Unary(tanh),
        "1/x": Operation.Unary({1/$0}),
        "x!": Operation.Unary(tgamma),
        "x^2": Operation.Unary({ pow($0, 2.0) }),
        "x^3": Operation.Unary({ pow($0, 3.0) }),
        "x^10": Operation.Unary({ pow($0, 10.0) }),
        "10^x": Operation.Unary({ pow(10.0, $0) }),
        "x^y": Operation.Binary({ pow($0, $1) }),
        "ln": Operation.Unary(log),
        "×": Operation.Binary({$0 * $1}),
        "÷": Operation.Binary({$0 / $1}),
        "-": Operation.Binary({$0 - $1}),
        "+": Operation.Binary({$0 + $1}),
        "=": Operation.Equal
    ]
    
    struct PendingBinaryOperation {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var pending: PendingBinaryOperation?
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    func executeBinaryOperation(){
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    func performOperand(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant (let value):
                accumulator = value
            case .Unary (let function):
                accumulator = function(accumulator)
            case .Binary (let function):
                executeBinaryOperation()
                pending = PendingBinaryOperation(binaryFunction: function, firstOperand: accumulator)
            case .Equal:
                executeBinaryOperation()
            }
        }
    }
}