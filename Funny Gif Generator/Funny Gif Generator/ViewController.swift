import UIKit
import GIFGenerator
import SwiftyGif
import MobileCoreServices
import SCRecorder
import AVKit
import AVFoundation
import Regift

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {


    var imagesArray = [UIImage]()
    var imagePicker: UIImagePickerController! = UIImagePickerController()
    
    let gifGenerator = GifGenerator()
    
    let videoFileName = "/test.mp4"
    let gifFileName = "/test.gif"
    
    var currentPreviewGifURL : NSURL?
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }

    lazy var documentsDirectory: NSURL = {
        let fileMgr = NSFileManager.defaultManager()
        let urls = fileMgr.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls.first!
    }()
    
    func getUrlForDocument(documentName: String) -> NSURL {
        return self.documentsDirectory.URLByAppendingPathComponent(documentName, isDirectory: false)
    }
    
    
    
    func generateAnimatedImage(imageArray: [UIImage]) {
        
        let url = getUrlForDocument(gifFileName)
        
        gifGenerator.generateGifFromImages(imagesArray: imageArray, frameDelay: 0.3, destinationURL: url, callback: { (data, error) -> () in
            
            if let data = data {
                self.currentPreviewGifURL = url
                print("image generated")
            }
            }
        )
    }
    

    
    func generateAnimatedGifFromVideo() {
        
        let videoURL = getUrlForDocument(videoFileName)
        let frameCount = 16
        let delayTime  = Float(0.2)
        let loopCount  = 0    // 0 means loop forever
        
        let regift = Regift(sourceFileURL: videoURL, frameCount: frameCount, delayTime: delayTime, loopCount: loopCount)
        if let pickedGif:NSURL = (regift.createGif()! as NSURL) {
            let gifData = NSData(contentsOfURL: pickedGif)
            let paths = NSSearchPathForDirectoriesInDomains(
                NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            let documentsDirectory: AnyObject = paths[0]
            let dataPath = documentsDirectory.stringByAppendingPathComponent(gifFileName)
            gifData?.writeToFile(dataPath, atomically: false)
            currentPreviewGifURL = getUrlForDocument(gifFileName)
            print("video generated")
        }
        
//
//        let startTime = Float(30)
//        let duration  = Float(15)
//        let frameRate = 15
//        
//        let trimmedRegift = Regift(sourceFileURL: URL, startTime: startTime, duration: duration, frameRate: frameRate, loopCount: loopCount)
//        print("Gif saved to \(trimmedRegift.createGif())")
    
    }
    
    
    @IBAction func takePicturePressed(sender: UIButton) {
        takeImage()
    }
    
    @IBAction func takeVideoPressed(sender: UIButton) {
        recordVideo()
    }
    
    
    @IBAction func chooseExistingImagePressed(sender: UIButton) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func previewGifPressed(sender: UIButton) {
        
        self.imageView.animationImages = imagesArray
        self.imageView.animationDuration = 1.0
        self.imageView.startAnimating()

           }
    
    @IBAction func previewGIFfromVideoPressed(sender: UIButton) {
        
        let gifmanager = SwiftyGifManager(memoryLimit:20)
        if let currentPreviewGif = currentPreviewGifURL {
            let data = NSData(contentsOfURL: currentPreviewGif)
            let gif = UIImage(gifData: data!)
            imageView.setGifImage(gif, manager: gifmanager, loopTime: -1)
        }

        
    }
    
    
    @IBAction func saveGifPressed(sender: UIButton) {
        generateAnimatedImage(imagesArray)
    }
    
    @IBAction func videoGifPressed(sender: UIButton) {
        generateAnimatedGifFromVideo()
    }
    
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if imagePicker.mediaTypes == [kUTTypeImage as String] {
            
            print("Got an image")
            let image = info[UIImagePickerControllerOriginalImage] as? UIImage
            imageView.image = image
            imagesArray.append(image!)
            imagePicker.dismissViewControllerAnimated(true, completion: nil)
        }
        
        if imagePicker.mediaTypes == [kUTTypeMovie as String] {
            
            print("Got a video")
            
            if let pickedVideo:NSURL = (info[UIImagePickerControllerMediaURL] as? NSURL) {
                
                // Save video to the main photo album
                let selectorToCall = #selector(ViewController.videoWasSavedSuccessfully(_:didFinishSavingWithError:context:))
                UISaveVideoAtPathToSavedPhotosAlbum(pickedVideo.relativePath!, self, selectorToCall, nil)
                
                // Save the video to the app directory so we can play it later
                let videoData = NSData(contentsOfURL: pickedVideo)
                let paths = NSSearchPathForDirectoriesInDomains(
                    NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                let documentsDirectory: AnyObject = paths[0]
                let dataPath = documentsDirectory.stringByAppendingPathComponent(videoFileName)
                videoData?.writeToFile(dataPath, atomically: false)
            }
            
            imagePicker.dismissViewControllerAnimated(true, completion: {
                // Anything you want to happen when the user saves an video
            })
        }
    }
    
    func recordVideo() {
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                
                imagePicker.sourceType = .Camera
                imagePicker.mediaTypes = [kUTTypeMovie as String]
                imagePicker.allowsEditing = false
                
                
                presentViewController(imagePicker, animated: true, completion: {})
            } else {
                postAlert("Rear camera doesn't exist", message: "Application cannot access the camera.")
            }
        } else {
            postAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
    }
    
    func takeImage() {
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                
                imagePicker.sourceType = .Camera
                imagePicker.mediaTypes = [kUTTypeImage as String]
                imagePicker.allowsEditing = false
                
                
                presentViewController(imagePicker, animated: true, completion: {})
            } else {
                postAlert("Rear camera doesn't exist", message: "Application cannot access the camera.")
            }
        } else {
            postAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
    }
    
    // Any tasks you want to perform after recording a video
    func videoWasSavedSuccessfully(video: String, didFinishSavingWithError error: NSError!, context: UnsafeMutablePointer<()>){
        print("Video saved")
        if let theError = error {
            print("An error happened while saving the video = \(theError)")
        } else {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                print("success")
            })
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("User canceled image")
        dismissViewControllerAnimated(true, completion: {
            // Anything you want to happen when the user selects cancel
        })
    }
    
    func postAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}


