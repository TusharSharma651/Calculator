//
//  ViewController.swift
//  Calculator
//
//  Created by Tushar on 20/05/18.
//  Copyright © 2018 Tushar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak private var display: UILabel!
    private var userISInMiddleOfTyping = false
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        let textCurrentlyInDisplay = display.text!
        if userISInMiddleOfTyping {
            display.text = textCurrentlyInDisplay + digit
        }
        else            
        {
            display.text = digit
        }
        userISInMiddleOfTyping = true
        
        
    }
   private var  displayValue : Double {
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    private var  brain = CalculatorBrain()
    var savedProgram: CalculatorBrain.propertyList?
    @IBAction func save() {
        savedProgram = brain.program
    }
    @IBAction func restore() {
        if savedProgram != nil{
            brain.program = savedProgram!
        }
    }
    @IBAction private func performOpertaion(_ sender: UIButton) {
        if userISInMiddleOfTyping
        {
            brain.setOperand(operand: displayValue)
            userISInMiddleOfTyping = false
        }
        
       if let mathematicalSymbol = sender.currentTitle
       {
       brain.performOperation(symbol: mathematicalSymbol)
        
    }
    displayValue = brain.result

}

}
