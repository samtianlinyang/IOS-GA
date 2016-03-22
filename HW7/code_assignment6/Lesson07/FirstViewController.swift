import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      let storedString = NSUserDefaults.standardUserDefaults().stringForKey("test_string")
        
      let storedNumber = NSUserDefaults.standardUserDefaults().valueForKey("test_number")
        
        if storedString != nil && storedNumber != nil {
        textView.text = "\(storedString!) / \(storedNumber!)"
        }
        
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