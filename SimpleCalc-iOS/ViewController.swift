//
//  ViewController.swift
//  SimpleCalc-iOS
//
//  Created by Ryan Liang on 10/23/17.
//  Copyright © 2017 Ryan Liang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var history:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! HistoryViewController
        destination.history = self.history
    }
    
    @IBOutlet weak var display: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var numbers :[Double] = []
    var operation : String = ""
    var userIsInTheMiddleOfTyping = false
    @IBAction func numberButtons(_ sender: UIButton) {
        let number = sender.currentTitle!
        let textInCurrentDisplay = display.text!
        
        if userIsInTheMiddleOfTyping {
            display.text = textInCurrentDisplay + number
            
        }else{
            display.text = number
            userIsInTheMiddleOfTyping = true
        }
        
    }
    @IBAction func zeroButton(_ sender: UIButton) {
        if(display.text != "0"){
            display.text! += "0"
        }
    }
    @IBAction func dotButton(_ sender: UIButton) {
        if display.text!.range(of: ".") == nil {
            display.text = display.text! + "."
        }
    }
    @IBAction func operationButtons(_ sender: UIButton) {
        if sender.currentTitle != nil {
            if userIsInTheMiddleOfTyping {
                userIsInTheMiddleOfTyping = false
                operation = sender.currentTitle!
            numbers.append(Double(display.text!)!)
            }
            
        }
    }
    @IBAction func clearButton(_ sender: UIButton) {
        numbers = []
        operation = ""
        display.text = "0"
        userIsInTheMiddleOfTyping = false
    }
    @IBAction func equalsPressed(_ sender: UIButton) {
        numbers.append(Double(display.text!)!)
        display.text = performOperation(numbers: numbers, operation: operation)
        //add history
        if numbers.count > 0{
            var historyResult = ""
            for n in 0...numbers.count-2{
                historyResult += String(numbers[n]) + " " + operation + " "
            }
            historyResult += String(numbers[numbers.count - 1])
            historyResult += " = " + display.text!
            history.append(historyResult)
        }
        reset()
    }
    @IBAction func factButton(_ sender: UIButton) {
        if numbers.count == 0{
            numbers.append(Double(display.text!)!)
        }
        if numbers[0] > 0 {
            var i = 1
            var n = Int(numbers[0])
            while (n > 1) {
                i *= n
                n = n-1
            }
            display.text = String(i)
            
            history.append("\(numbers[0])! = \(display.text!)")
            reset()
            
        }
    }
    
    func reset() {
        numbers = []
        operation = ""
        userIsInTheMiddleOfTyping = false
    }
    func performOperation(numbers:[Double],operation:String) -> String {
        
        var result = "";

        switch operation{
        case "count":
            result = String(numbers.count)
        case "avg":
            var sum = 0.0
            for n in numbers {
                sum += n
            }
            result = String(sum/Double(numbers.count))
        case "+":
            result = String(numbers[0] + numbers[1])
        case "-":
            result = String(numbers[0] - numbers[1])
        case "×":
            result = String(numbers[0] * numbers[1])
        case "÷":
            result = String(numbers[0] / numbers[1])
        case "%" :
            result = String(Int(numbers[0]) % Int(numbers[1]))
        default:
            result = "0"
            reset()
        }
        var split = result.split(separator: ".")
        if split.count > 1 {
            if split[1] == "0" {
                result = String(split[0])
            }
        }
        return result
    }
    


}

