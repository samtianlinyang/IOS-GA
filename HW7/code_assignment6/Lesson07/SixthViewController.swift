//
//  SixthViewController.swift
//  Lesson07
//
//  Created by William Martin on 1/19/16.
//  Copyright © 2016 General Assembly. All rights reserved.
//

import UIKit

class SixthViewController: UIViewController {

    @IBOutlet weak var textView6: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            let output = try NSArray(contentsOfURL: getUrlForDocument("stuffToSave.plist"))
            
            let outputArray = output as! Array<String>
            let stringRepresentation = outputArray.joinWithSeparator(" ")
            textView6.text = stringRepresentation
            
            
        } catch {
            print("something went wrong")
        }
    }
        
        
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func getUrlForDocument(documentName: String) -> NSURL {
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let directory = urls.first!
        return directory.URLByAppendingPathComponent(documentName, isDirectory: false)
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


