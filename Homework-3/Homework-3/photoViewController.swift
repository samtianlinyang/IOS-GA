//
//  photoViewController.swift
//  Homework-3
//
//  Created by Tianlin Yang on 2/17/16.
//  Copyright © 2016 Tianlin Yang. All rights reserved.
//

import UIKit

class photoViewController: UIViewController {

    @IBAction func dismissButtonPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }

}
