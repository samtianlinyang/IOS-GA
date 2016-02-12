//
//  ViewController.swift
//  Homework-2
//
//  Created by Tianlin Yang on 2/11/16.
//  Copyright © 2016 Tianlin Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var nameText: UITextField!
    
    @IBOutlet var ageText: UITextField!
    
    @IBAction func buttonPressed(sender: AnyObject) {
        changeText()
        greetings()
        commmet()
        combineComment()
        
    }
    
    @IBOutlet var outputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeText() {
        outputLabel.text = "Hello World!"
        
    }
    
    func greetings() {
        outputLabel.text = "Hello " + nameText.text! + " you are " + ageText.text! + " years old!"
    }
    
    func commmet() {
        let age = (ageText.text! as NSString).integerValue
        
        if age >= 21 {
            outputLabel.text = "you can drink"
        } else if age >= 18 {
            outputLabel.text = "you can vote"
        } else if age >= 16 {
            outputLabel.text = "You can drive"
        }
    }
    
    func combineComment() {
        let age = (ageText.text! as NSString).integerValue
        
        if age >= 21 {
            outputLabel.text = "You can vote, drive, and drink (but not at the same time!)."
        } else if age >= 18 && age < 21 {
            outputLabel.text = "You can drive and vote"
        } else if age == 16 || age == 17 {
            outputLabel.text = "You can drive."
        }
    }

}

