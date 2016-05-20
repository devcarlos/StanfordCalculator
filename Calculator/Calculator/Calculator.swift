//
//  Calculator.swift
//  Calculator
//
//  Created by Carlos Alcala on 5/19/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import Foundation

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
        "∏": Operation.Constant(M_PI),
        "e": Operation.Constant(M_E),
        "√": Operation.Unary(sqrt),
        "cos": Operation.Unary(cos),
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