//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Pamela Needle on 8/11/15.
//  Copyright (c) 2015 Pamela Needle. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var circle: UIImageView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var ques: UITextField!
    @IBOutlet weak var history: UIButton!
    
//    let responseSound0 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("mayes", ofType: "m4a")!)
//    let responseSound1 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("mano", ofType: "m4a")!)
//    let responseSound2 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("manotachance", ofType: "m4a")!)
//    let responseSound3 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("maperhaps", ofType: "m4a")!)
//    let responseSound4 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("mamostdefinitely", ofType: "m4a")!)
//    let responseSound5 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("mamaybe", ofType: "m4a")!)
//    let responseSound6 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("maforsure", ofType: "m4a")!)
//    let responseSound7 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("mayeahright", ofType: "m4a")!)
    var audiosounds = [NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("mayes", ofType: "mp3")!), NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("mano", ofType: "mp3")!),NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("manotachance", ofType: "mp3")!), NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("maperhaps", ofType: "mp3")!),NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("mamostdefinitely", ofType: "mp3")!),NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("mamaybe", ofType: "mp3")!),NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("maforsure", ofType: "mp3")!),NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("mayeahright", ofType: "mp3")!)];
    
    let model = EightBallModel(extraResponseArray:[NSLocalizedString("Not a chance!", comment:"notachance"), NSLocalizedString("Perhaps!",comment:"perhaps"), NSLocalizedString("Most definitely", comment:"mostdef"), NSLocalizedString("Maybe",comment:"maybe"), NSLocalizedString("For sure", comment: "forsure"), NSLocalizedString("Yeah right!", comment:"yeahright")])
    var audioPlayer = AVAudioPlayer()
    
    var questionresponses: [QuestionResponseModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ques.delegate = self
        if let arr = loadQuesResp(){
            questionresponses = arr
        }
        //var audioPlayer = AVAudioPlayer()
        
        debugPrint(model)
        print(model)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func gatherResponse(){
//        let soundindex = self.model.getRandomResponse()
////        let currentsound = audiosounds[soundindex]
//        do{
//        audioPlayer = try AVAudioPlayer(contentsOfURL: currentsound)
//        audioPlayer.prepareToPlay()
//        audioPlayer.play()
//        self.answer.text = self.model.generateResponse(soundindex)
//        }catch {
//            print(error)
//        }
        let newresponse = self.model.generateResponse()
        let utterance = AVSpeechUtterance(string: newresponse)
        //utterance.voice = AVSpeechSynthesisVoice(language:
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speakUtterance(utterance)
        self.answer.text = newresponse
        
    }
    
    func newResponse() {
        
        UIView.animateWithDuration(0.75, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.answer.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in
                //change the text
                self.gatherResponse()
                //self.answer.text = self.model.generateResponse()
                UIView.animateWithDuration(0.75, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    self.answer.alpha = 1.0
                    }, completion: {finished in
                        self.questionresponses.append(QuestionResponseModel(question: self.ques.text!, response: self.answer.text!))
                        self.saveQuesResp()
                    }
                )
                
        })
        
        
        
        
        let color = arc4random_uniform(7)
        let colorInt = Int(color)
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
        newResponse()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField){
        //newResponse()
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
            print("Failed to save Question and Response")
        }
    }
    
    func loadQuesResp() -> [QuestionResponseModel]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(QuestionResponseModel.ArchiveURL.path!) as? [QuestionResponseModel]
    }
    
}

