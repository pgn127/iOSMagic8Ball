//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Pamela Needle on 8/11/15.
//  Copyright (c) 2015 Pamela Needle. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var circle: UIImageView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var shake: UIButton!
    @IBOutlet weak var ques: UITextField!
    
     let model = EightBallModel(extraResponseArray:["Not a chance!","Perhaps","Most definetely","Maybe","For sure","Yeah right!", "😳"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("Pamela Needle")
        var age = 20.00
        println("My age is \(age)")
        var name = "Pamela Needle"
        println(name)
        ques.delegate = self
        println("Will I get full marks for this lab?")
        println(model.generateResponse())
        println("Will the Cronulla sharks receive a premiership this year?")
        println(model.generateResponse())
        println("Will I end up becoming a cat person when I get old?")
        println(model.generateResponse())
        
        debugPrintln(model)
        println(model)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newResponse() {
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.answer.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in
                //change the text
                self.answer.text = self.model.generateResponse()
                UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    self.answer.alpha = 1.0
                }, completion: nil)
                
                })
        
    
    
        var color = arc4random_uniform(7)
        var colorInt = Int(color)
        switch colorInt{
        case 1:
            circle.image = UIImage(named: "circle1")
        case 2:
            circle.image = UIImage(named: "circle2")
        case 3:
            circle.image = UIImage(named: "circle3")
        case 4:
            circle.image = UIImage(named: "circle4")
        case 5:
            circle.image = UIImage(named: "circle5")
        case 6:
            circle.image = UIImage(named: "circle6")
        default:
            break
            
        }
    
       /* var fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.fromValue = 0.0
        fadeAnimation.toValue = 1.0
        fadeAnimation.duration = 3.0
        ques.layer.addAnimation(fadeAnimation)*/
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //hides keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField){
        newResponse()
    }

    @IBAction func questionEntered(sender: AnyObject) {
        ques.resignFirstResponder()
    }

    @IBAction func shakeButtonPressed(sender: AnyObject) {
        newResponse()
    }
}

