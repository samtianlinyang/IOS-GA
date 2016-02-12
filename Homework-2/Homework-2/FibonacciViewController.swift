//
//  FibonacciViewController.swift
//  Homework-2
//
//  Created by Tianlin Yang on 2/11/16.
//  Copyright © 2016 Tianlin Yang. All rights reserved.
//

import UIKit

class FibonacciViewController: UIViewController {

    @IBOutlet var input: UITextField!
    
    
    
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        let number = (input.text! as NSString).integerValue
        output.text = "\(fibonacciNumberAtIndex(number))"
    
    }
    
    func fibonacciNumberAtIndex(indexOfFibonacciNumber:Int) -> Int {
        var output: Int = 0
        var previousnumberMinus1:Int = 1
        var previousnumberMinus2:Int = 0
        if indexOfFibonacciNumber == 1 {
            return 0
        } else if indexOfFibonacciNumber == 2 {
            return 1
            } else {
            print("\(indexOfFibonacciNumber)")
        for _ in 1...indexOfFibonacciNumber-2 {
            output = previousnumberMinus1 + previousnumberMinus2
            previousnumberMinus2 = previousnumberMinus1
            previousnumberMinus1 = output
        }
        return output
        }
    }
    
    
    @IBOutlet var output: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
