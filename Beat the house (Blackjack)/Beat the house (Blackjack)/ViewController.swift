//
//  ViewController.swift
//  Beat the house (Blackjack)
//
//  Created by Tianlin Yang on 3/8/16.
//  Copyright © 2016 Tianlin Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollView2: UIScrollView!
    @IBOutlet weak var scrollView3: UIScrollView!
    @IBOutlet weak var scrollView4: UIScrollView!
    @IBOutlet weak var scrollView5: UIScrollView!
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackView2: UIStackView!
    @IBOutlet weak var stackView3: UIStackView!
    @IBOutlet weak var stackView4: UIStackView!
    @IBOutlet weak var stackView5: UIStackView!
    
    @IBAction func buttonStrategy(sender: AnyObject) {
        analyzeCard()
    }
    
    @IBOutlet weak var outputLabel: UILabel!
    
    var dealerCard: Int?
    var playerCard1: Int?
    var playerCard2: Int?
    var playerCard3: Int = 0
    var playerCard4: Int = 0
    
        
    @IBAction func buttonA1(sender: AnyObject) {
        dealerCard = 11
        analyzeCard()
        highlightButton(sender)
        
    }
    @IBAction func buttonA2(sender: AnyObject) {
        dealerCard = 2
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonA3(sender: AnyObject) {
        dealerCard = 3
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonA4(sender: AnyObject) {
        dealerCard = 4
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonA5(sender: AnyObject) {
        dealerCard = 5
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonA6(sender: AnyObject) {
        dealerCard = 6
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonA7(sender: AnyObject) {
        dealerCard = 7
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonA8(sender: AnyObject) {
        dealerCard = 8
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonA9(sender: AnyObject) {
        dealerCard = 9
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonA10(sender: AnyObject) {
        dealerCard = 10
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonA11(sender: AnyObject) {
        dealerCard = 10
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonA12(sender: AnyObject) {
        dealerCard = 10
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonA13(sender: AnyObject) {
        dealerCard = 10
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonB1(sender: AnyObject) {
        playerCard1 = 11
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonB2(sender: AnyObject) {
        playerCard1 = 2
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonB3(sender: AnyObject) {
        playerCard1 = 3
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonB4(sender: AnyObject) {
        playerCard1 = 4
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonB5(sender: AnyObject) {
        playerCard1 = 5
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonB6(sender: AnyObject) {
        playerCard1 = 6
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonB7(sender: AnyObject) {
        playerCard1 = 7
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonB8(sender: AnyObject) {
        playerCard1 = 8
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonB9(sender: AnyObject) {
        playerCard1 = 9
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonB10(sender: AnyObject) {
        playerCard1 = 10
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonB11(sender: AnyObject) {
        playerCard1 = 10
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonB12(sender: AnyObject) {
        playerCard1 = 10
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonB13(sender: AnyObject) {
        playerCard1 = 10
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonC1(sender: AnyObject) {
        playerCard2 = 11
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonC2(sender: AnyObject) {
        playerCard2 = 2
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonC3(sender: AnyObject) {
        playerCard2 = 3
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonC4(sender: AnyObject) {
        playerCard2 = 4
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonC5(sender: AnyObject) {
        playerCard2 = 5
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonC6(sender: AnyObject) {
        playerCard2 = 6
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonC7(sender: AnyObject) {
        playerCard2 = 7
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonC8(sender: AnyObject) {
        playerCard2 = 8
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonC9(sender: AnyObject) {
        playerCard2 = 9
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonC10(sender: AnyObject) {
        playerCard2 = 10
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonC11(sender: AnyObject) {
        playerCard2 = 10
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonC12(sender: AnyObject) {
        playerCard2 = 10
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonC13(sender: AnyObject) {
        playerCard2 = 10
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonD1(sender: AnyObject) {
        playerCard3 = 11
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonD2(sender: AnyObject) {
        playerCard3 = 2
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonD3(sender: AnyObject) {
        playerCard3 = 3
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonD4(sender: AnyObject) {
        playerCard3 = 4
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonD5(sender: AnyObject) {
        playerCard3 = 5
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonD6(sender: AnyObject) {
        playerCard3 = 6
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonD7(sender: AnyObject) {
        playerCard3 = 7
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonD8(sender: AnyObject) {
        playerCard3 = 8
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonD9(sender: AnyObject) {
        playerCard3 = 9
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonD10(sender: AnyObject) {
        playerCard3 = 10
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonD11(sender: AnyObject) {
        playerCard3 = 10
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonD12(sender: AnyObject) {
        playerCard3 = 10
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonD13(sender: AnyObject) {
        playerCard3 = 10
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonE1(sender: AnyObject) {
        playerCard4 = 11
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonE2(sender: AnyObject) {
        playerCard4 = 2
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonE3(sender: AnyObject) {
        playerCard4 = 3
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonE4(sender: AnyObject) {
        playerCard4 = 4
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonE5(sender: AnyObject) {
        playerCard4 = 5
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonE6(sender: AnyObject) {
        playerCard4 = 6
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonE7(sender: AnyObject) {
        playerCard4 = 7
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonE8(sender: AnyObject) {
        playerCard4 = 8
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonE9(sender: AnyObject) {
        playerCard4 = 9
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonE10(sender: AnyObject) {
        playerCard4 = 10
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonE11(sender: AnyObject) {
        playerCard4 = 10
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonE12(sender: AnyObject) {
        playerCard4 = 10
        analyzeCard()
        highlightButton(sender)
    }
    @IBAction func buttonE13(sender: AnyObject) {
        playerCard4 = 10
        analyzeCard()
        highlightButton(sender)
    }
    
    
    
    
    func analyzeCard() {
        if soft17Selection != nil && decksSelection != nil && dealerCard != nil && playerCard1 != nil && playerCard2 != nil {
            let currentState = StateOfCard(soft17: soft17Selection!, decks: decksSelection!, doubleAfterSplit: doubleAfterSplitSelection, surrender: surrenderSelection, daelerPeek: dealerPeekSelection, dealerCard: dealerCard!, myFirstCard: playerCard1!, mySecondCard: playerCard2!, myThirdCard: playerCard3, myFourthCard: playerCard4)
            outputLabel.text = currentState.strategyCalculator().getAction()
            self.view.backgroundColor = currentState.strategyCalculator().getActionBackgroundColor()
        } else {
            outputLabel.text = "Please select card"
        }
        showScrollView()
    }
    
    
    
    
    
    func showScrollView() {
        if dealerCard != nil && playerCard1 != nil && playerCard2 != nil {
            scrollView4.alpha = 1
            if dealerCard != nil && playerCard1 != nil && playerCard2 != nil && playerCard3 != 0 {
                scrollView5.alpha = 1
            }
        }
        else {
            scrollView4.alpha = 0
            scrollView5.alpha = 0
        }
    }
    
    func highlightButton(sender: AnyObject) {
        
        if sender.tag < 14 {
            for i in 1...13 {
                if let button = self.view.viewWithTag(i) as? UIButton
                {
                    button.backgroundColor = UIColor.clearColor()
                    button.layer.cornerRadius = 0
                    button.layer.borderWidth = 0
                    button.layer.borderColor = UIColor.clearColor().CGColor
                }
            }
        }
        
        if sender.tag > 13 && sender.tag < 27 {
            for i in 14...26 {
                if let button = self.view.viewWithTag(i) as? UIButton
                {
                    button.backgroundColor = UIColor.clearColor()
                    button.layer.cornerRadius = 0
                    button.layer.borderWidth = 0
                    button.layer.borderColor = UIColor.clearColor().CGColor
                }
            }
        }
        
        if sender.tag > 26 && sender.tag < 40 {
            for i in 27...39 {
                if let button = self.view.viewWithTag(i) as? UIButton
                {
                    button.backgroundColor = UIColor.clearColor()
                    button.layer.cornerRadius = 0
                    button.layer.borderWidth = 0
                    button.layer.borderColor = UIColor.clearColor().CGColor
                }
            }
        }
        
        if sender.tag > 39 && sender.tag < 53 {
            for i in 38...52 {
                if let button = self.view.viewWithTag(i) as? UIButton
                {
                    button.backgroundColor = UIColor.clearColor()
                    button.layer.cornerRadius = 0
                    button.layer.borderWidth = 0
                    button.layer.borderColor = UIColor.clearColor().CGColor
                }
            }
        }
        
        
        if sender.tag > 52 && sender.tag < 66 {
            for i in 53...65 {
                if let button = self.view.viewWithTag(i) as? UIButton
                {
                    button.backgroundColor = UIColor.clearColor()
                    button.layer.cornerRadius = 0
                    button.layer.borderWidth = 0
                    button.layer.borderColor = UIColor.clearColor().CGColor
                }
            }
        }
        
        if let button = self.view.viewWithTag(sender.tag) as? UIButton
        {
            button.backgroundColor = UIColor.clearColor()
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 3
            button.layer.borderColor = UIColor.blueColor().CGColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: stackView.frame.width, height: stackView.frame.height)
        scrollView2.contentSize = CGSize(width: stackView2.frame.width, height: stackView2.frame.height)
        scrollView3.contentSize = CGSize(width: stackView3.frame.width, height: stackView3.frame.height)
        scrollView4.contentSize = CGSize(width: stackView4.frame.width, height: stackView4.frame.height)
        scrollView5.contentSize = CGSize(width: stackView5.frame.width, height: stackView4.frame.height)
        showScrollView()
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            
            for i in 1...65 {
                if let button = self.view.viewWithTag(i) as? UIButton
                {
                    button.backgroundColor = UIColor.clearColor()
                    button.layer.cornerRadius = 0
                    button.layer.borderWidth = 0
                    button.layer.borderColor = UIColor.clearColor().CGColor
                }
            }
            
            dealerCard = nil
            playerCard1 = nil
            playerCard2 = nil
            playerCard3 = 0
            playerCard4 = 0
            
            
            self.view.backgroundColor = UIColor.whiteColor()
            
            outputLabel.text = "Please select cards ☺ "
            
            scrollView4.alpha = 0
            scrollView5.alpha = 0
            
        }
    }
    
    @IBAction func returnToSetting(sender: AnyObject) {
        decksSelection = nil
        soft17Selection = nil
        
        for i in 1...65 {
            if let button = self.view.viewWithTag(i) as? UIButton
            {
                button.backgroundColor = UIColor.clearColor()
                button.layer.cornerRadius = 0
                button.layer.borderWidth = 0
                button.layer.borderColor = UIColor.clearColor().CGColor
            }
        }
        
        dealerCard = nil
        playerCard1 = nil
        playerCard2 = nil
        playerCard3 = 0
        playerCard4 = 0
        
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        outputLabel.text = "Please select cards ☺ "
        
        scrollView4.alpha = 0
        scrollView5.alpha = 0
        
        performSegueWithIdentifier("returnToSetting", sender: nil)
        
    }


}

