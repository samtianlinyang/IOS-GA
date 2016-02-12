//
//  EvenOddViewController.swift
//  Homework-2
//
//  Created by Tianlin Yang on 2/11/16.
//  Copyright © 2016 Tianlin Yang. All rights reserved.
//

import UIKit

class EvenOddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var numberInput: UITextField!
    
    @IBOutlet var label: UILabel!
    
    
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        let number = (numberInput.text! as NSString).integerValue
        if number%2 == 0 {
            label.text = "even"
        } else {
            label.text = "odd"
        }
        
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
