//
//  ViewController.swift
//  Lesson04
//
//  Created by Rudd Taylor on 9/28/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class ArrayViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {

    var array: [String] = []
    
    @IBOutlet var arrayTable: UITableView!
    @IBOutlet var arrayInputTextField: UITextField!
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        array.append(arrayInputTextField.text!)
        arrayTable.reloadData()
        print(array)
        self.view.endEditing(true)
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.dismissViewControllerAnimated(false, completion: nil)
        self.dismissViewControllerAnimated(false, completion: { () -> Void in
            self.view.backgroundColor = UIColor.blueColor()
        })
        self.view.backgroundColor = UIColor.blueColor()
        self.arrayInputTextField.delegate = self
        arrayTable.dataSource = self
        self.arrayTable.delegate = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Array", forIndexPath: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        cell.contentView.backgroundColor = UIColor.redColor()
        cell.backgroundColor = UIColor.redColor()
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        if tableView.cellForRowAtIndexPath(indexPath)?.accessoryType == UITableViewCellAccessoryType.None {
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
//            tableView.cellForRowAtIndexPath(indexPath)?.backgroundColor = UIColor.greenColor()
            tableView.cellForRowAtIndexPath(indexPath)?.contentView.backgroundColor = UIColor.greenColor()
        } else {
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
//            tableView.cellForRowAtIndexPath(indexPath)?.backgroundColor = UIColor.redColor()
            tableView.cellForRowAtIndexPath(indexPath)?.contentView.backgroundColor = UIColor.redColor()
        }
        
        
        // Standard options
        //        cell.accessoryType = UITableViewCellAccessoryType.None
        //        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        //        cell.accessoryType = UITableViewCellAccessoryType.DetailDisclosureButton
        //        cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        //        cell.accessoryType = UITableViewCellAccessoryType.DetailButton
        
        //        // Custom view options
        //        cell.accessoryType = UITableViewCellAccessoryType.None
        //        cell.accessoryView = UIView(frame: CGRectMake(0, 0, 20, 20))
        //        cell.accessoryView!.backgroundColor = UIColor.blueColor()
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print("You deselected cell #\(indexPath.row)!")
        if tableView.cellForRowAtIndexPath(indexPath)?.accessoryType == UITableViewCellAccessoryType.None {
            tableView.cellForRowAtIndexPath(indexPath)?.contentView.backgroundColor = UIColor.redColor()
            tableView.cellForRowAtIndexPath(indexPath)?.backgroundColor = UIColor.redColor()
        } else {
            tableView.cellForRowAtIndexPath(indexPath)?.contentView.backgroundColor = UIColor.greenColor()
            tableView.cellForRowAtIndexPath(indexPath)?.backgroundColor = UIColor.greenColor()
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            array.removeAtIndex(indexPath.row)
            arrayTable.reloadData()
        }
    }

    
}

