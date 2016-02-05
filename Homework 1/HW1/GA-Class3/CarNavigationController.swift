//
//  CarNavigationController.swift
//  GA-Class3
//
//  Created by Tianlin Yang on 2/2/16.
//  Copyright © 2016 Tianlin Yang. All rights reserved.
//

import UIKit

class CarNavigationController: UINavigationController {

    @IBOutlet var carNavigationButton: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        carNavigationButton.badgeValue = nil
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
