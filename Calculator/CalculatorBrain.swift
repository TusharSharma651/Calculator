//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Tushar on 28/05/18.
//  Copyright © 2018 Tushar. All rights reserved.
//

import Foundation
class CalculatorBrain
{
    private var accumulator = 0.0
    private var internalProgram = [AnyObject]()
    func setOperand(operand : Double){
        accumulator = operand
        internalProgram.append(operand as AnyObject)
    }
   private var operations : Dictionary<String,Operation> = [
        "pi" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "×" : Operation.BinaryOperation({ $0 * $1
            }),
        "÷" : Operation.BinaryOperation({ $0 / $1
            
        }),
        "+" : Operation.BinaryOperation({ $0 + $1
            
        }),
        "−" : Operation.BinaryOperation({ $0 - $1
            
        }),
        "=" : Operation.Equals
        ]
   
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double)->(Double))
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
    func performOperation(symbol: String){
        internalProgram.append(symbol as AnyObject)
        if let operation = operations[symbol] {
            switch operation{
            case .Constant(let value):
                accumulator = value //case Operation.Constant
            case .UnaryOperation(let foo):
                accumulator = foo(accumulator)
            case .BinaryOperation(let function) :
                if pending != nil{
                    accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
                }
                pending = pendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals: executePendingBinaryOperation()
               
            }
        }
    }
    private func executePendingBinaryOperation(){
        if pending != nil{
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
        }
    }
    private var pending:  pendingBinaryOperationInfo?
    typealias propertyList = AnyObject
    var program : propertyList{
        get {
            return internalProgram as CalculatorBrain.propertyList
        }
        set {
            clear()
            if let arrayOfOps = newValue as? [AnyObject]{
                for op in arrayOfOps{
                    if let operand = op as? Double{
                        setOperand(operand: operand)
                    }else if let operation  = op as? String{
                        performOperation(symbol: operation)
                    }
                }
            }
            
        }
    }
    func clear()
    {
        accumulator = 0.0
        pending = nil
        internalProgram.removeAll()
    }
    
    
    private struct pendingBinaryOperationInfo{
        var binaryFunction: (Double,Double) -> Double
        var firstOperand: Double
    }
    var result : Double{
        get {
            return accumulator
        }
    }
    
}
