//
//  MapViewController.swift
//  Lesson04
//
//  Created by Rudd Taylor on 9/28/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource {

    @IBOutlet var keyTextField: UITextField!
    
    @IBOutlet var valueTextField: UITextField!
    
    @IBOutlet var dictionaryTable: UITableView!
    
    var dictionaryForTable:[String:String] = [:]
    
    var dictionaryKey:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blueColor()
        
        self.keyTextField.delegate = self
        self.valueTextField.delegate = self
        dictionaryTable.dataSource = self
        
        keyTextField.tag = 1
        valueTextField.tag = 2
        
    }
    
    override func viewDidAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillAppear"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter().removeObserver(self)
    }
    
    func keyboardWillAppear() {
        self.view.backgroundColor = UIColor.redColor()
    }
    
    func keyboardWillHide() {
        self.view.backgroundColor = UIColor.greenColor()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let nextTag: NSInteger = textField.tag + 1;
        // Try to find next responder
        if let nextResponder: UIResponder! = textField.superview!.viewWithTag(nextTag){
            nextResponder.becomeFirstResponder()
        }
        else {
            // Not found, so remove keyboard.
            let text = self.view.viewWithTag(1) as! UITextField
            if text.text == "" {
                textField.superview!.viewWithTag(1)?.becomeFirstResponder()
            } else {
                // All fields are filled
                textField.resignFirstResponder()
                dictionaryForTable[keyTextField.text!] = valueTextField.text!
                dictionaryKey = Array(dictionaryForTable.keys)
                dictionaryTable.reloadData()
            }
        }
        return false // We do not want UITextField to insert line-breaks.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.backgroundColor = UIColor.yellowColor()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.backgroundColor = UIColor.whiteColor()
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Dictionary", forIndexPath: indexPath)
        cell.textLabel?.text = "\(dictionaryKey[indexPath.row]) - \(dictionaryForTable[dictionaryKey[indexPath.row]]!)"
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictionaryKey.count
    }
    
}
