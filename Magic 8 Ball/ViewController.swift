//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Pamela Needle on 8/11/15.
//  Copyright (c) 2015 Pamela Needle. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var circle: UIImageView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var ques: UITextField!
    @IBOutlet weak var history: UIButton!
    
     let model = EightBallModel(extraResponseArray:["Not a chance!","Perhaps","Most definetely","Maybe","For sure","Yeah right!", "😳"])
    var questionresponses: [QuestionResponseModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("Pamela Needle")
        var age = 20.00
        println("My age is \(age)")
        var name = "Pamela Needle"
        println(name)
        ques.delegate = self
        if let arr = loadQuesResp(){
            questionresponses = arr
        }
        
        debugPrintln(model)
        println(model)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    func gatherResponse(){
//        self.answer.text = self.model.generateResponse()
//        self.questionresponses.append(QuestionResponseModel(question: self.ques.text, response: self.answer.text!))
//        self.saveQuesResp()
//    }
    
    func newResponse() {
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.answer.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in
                //change the text
                self.answer.text = self.model.generateResponse()
                //self.answer.text = self.model.generateResponse()
                UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    self.answer.alpha = 1.0
                    }, completion: {finished in
                        self.questionresponses.append(QuestionResponseModel(question: self.ques.text, response: self.answer.text!))
                        self.saveQuesResp()
                    }
                )
                
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
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //hides keyboard
        ques.resignFirstResponder()
        //newResponse()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField){
        newResponse()
    }

    @IBAction func questionEntered(sender: AnyObject) {
        ques.resignFirstResponder()
    }
    

   
//    @IBAction func historyButtonPressed(sender: UIStoryboardSegue) {
////        if let sourceViewController = sender.sourceViewController as? ViewController, questionresponses = sourceViewController.questionresponses {
////            let newIndexPath = NSIndexPath(forRow: questionresponses.count, inSection: 0)
////            //questionresponses.append(QuestionResponseModel(question: self.ques.text, response: self.answer.text))
////        }
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        
//        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("nextScreen") as! HistoryViewController
//        self.presentViewController(nextViewController, animated:true, completion:nil)
//    }
    
    //MARK: NScoding
    
    @IBAction func loadData(sender: AnyObject) {
        self.performSegueWithIdentifier("NextScreen", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let vC = segue.destinationViewController as! UINavigationController
        //let historyVC = segue.destinationViewController as! HistoryViewController
        let historyVC = vC.viewControllers.first as! HistoryViewController
        
        historyVC.historyArray = questionresponses
    }
    
    func saveQuesResp(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(questionresponses, toFile: QuestionResponseModel.ArchiveURL.path!)
        
        if !isSuccessfulSave{
            println("Failed to save Question and Response")
        }
    }
    
    func loadQuesResp() -> [QuestionResponseModel]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(QuestionResponseModel.ArchiveURL.path!) as? [QuestionResponseModel]
    }
    
}

