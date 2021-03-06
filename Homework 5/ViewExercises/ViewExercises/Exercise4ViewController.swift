//
//  Exercise4ViewController.swift
//  ViewExercises
//
//  Created by William Martin on 1/22/16.
//  Copyright © 2016 Anomalus. All rights reserved.
//

import UIKit

class Exercise4ViewController: UIViewController {

    @IBOutlet var button: UIButton!
    @IBAction func buttonClicked(sender: AnyObject) {
        if button.backgroundColor == UIColor.greenColor() {
            button.backgroundColor = UIColor.redColor()
        } else {
            button.backgroundColor = UIColor.greenColor()
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = 2;
        button.layer.borderWidth = 1;
        button.layer.borderColor = UIColor.redColor().CGColor

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
