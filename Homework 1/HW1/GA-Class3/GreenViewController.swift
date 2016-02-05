//
//  ViewController.swift
//  GA-Class3
//
//  Created by Tianlin Yang on 2/2/16.
//  Copyright © 2016 Tianlin Yang. All rights reserved.
//

import UIKit

class GreenViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {

    var imagePicker: UIImagePickerController!
    
    @IBOutlet var textInput: UITextField!
    
    @IBOutlet var textOutput: UITextView!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func textEditingChanged(sender: AnyObject) {
        sayHello()
    }
    
    @IBAction func sayHelloButtonPressed(sender: AnyObject) {
        sayHello()
    }
    
    func sayHello() {
        textOutput.text = "Hello " + textInput.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.textInput.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        print("Go back to main (green) screen")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("prepare for next screen")
    }
    
    
    @IBAction func choosePhoto(sender: UIButton) {
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func takePicture(sender: UIButton) {
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            imagePicker.dismissViewControllerAnimated(true, completion: nil)
                imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }


}

