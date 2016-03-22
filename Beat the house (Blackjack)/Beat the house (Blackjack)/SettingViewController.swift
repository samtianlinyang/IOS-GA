//
//  SettingViewController.swift
//  Beat the house (Blackjack)
//
//  Created by Tianlin Yang on 3/15/16.
//  Copyright © 2016 Tianlin Yang. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var deckPicker: UIPickerView!
    @IBOutlet weak var noteLabel: UILabel!
    
    let pickerData = ["1 deck poker","2 decks poker","4 or more decks poker"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deckPicker.delegate = self
        deckPicker.dataSource = self
        soft17Selection = .dealerStands
        deckPicker.selectRow(2, inComponent: 0, animated: true)
        decksSelection = .fourOrMore
    }
    
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if row == 0 {
            decksSelection = .one
        } else if row == 1 {
            decksSelection = .two
        } else {
            decksSelection = .fourOrMore
        }
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blueColor()])
        return myTitle
    }
    
    /* less conservative memory version
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
    let pickerLabel = UILabel()
    let titleData = pickerData[row]
    let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
    pickerLabel.attributedText = myTitle
    //color  and center the label's background
    let hue = CGFloat(row)/CGFloat(pickerData.count)
    pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness:1.0, alpha: 1.0)
    pickerLabel.textAlignment = .Center
    return pickerLabel
    }
    */
    
    /* better memory management version */
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        var pickerLabel = view as! UILabel!
        if view == nil {  //if no label there yet
            pickerLabel = UILabel()
            //color the label's background
            let hue = CGFloat(row)/CGFloat(pickerData.count)
            pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        }
        let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel!.attributedText = myTitle
        pickerLabel!.textAlignment = .Center
        
        return pickerLabel
        
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 80.0
    }
    // for best use with multitasking , dont use a constant here.
//
//    //this is for demonstration purposes only.
//    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        return 200
//    }
    
    
    @IBOutlet weak var soft17Control: UISegmentedControl!
    @IBAction func soft17Control(sender: AnyObject) {
        
        if(soft17Control.selectedSegmentIndex == 0)
        {
            soft17Selection = .dealerStands
        }
        else if(soft17Control.selectedSegmentIndex == 1)
        {
            soft17Selection = .dealerHits
        }
        
    }
    
    
    @IBAction func startButtonPushed(sender: AnyObject) {
        if decksSelection != nil && soft17Selection != nil {
        performSegueWithIdentifier("showApp", sender: nil)
        } else {
            noteLabel.text = "Please select settings before continuing."
        }
        
    }
    
    
    
    
    
    
}