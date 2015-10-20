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
    

//    var audiosounds = [NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("mayes", ofType: "mp3")!), NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("mano", ofType: "mp3")!),NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("manotachance", ofType: "mp3")!), NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("maperhaps", ofType: "mp3")!),NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("mamostdefinitely", ofType: "mp3")!),NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("mamaybe", ofType: "mp3")!),NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("maforsure", ofType: "mp3")!),NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("mayeahright", ofType: "mp3")!)];
    
    let model = EightBallModel(extraResponseArray:[NSLocalizedString("Not a chance!", comment:"notachance"), NSLocalizedString("Perhaps!",comment:"perhaps"), NSLocalizedString("Most definitely", comment:"mostdef"), NSLocalizedString("Maybe",comment:"maybe"), NSLocalizedString("For sure", comment: "forsure"), NSLocalizedString("Yeah right!", comment:"yeahright")])
    var audioPlayer = AVAudioPlayer()
    let postURL =  "http://li859-75.members.linode.com/addEntry.php"
    let user = "pgn342"
    
    var questionresponses: [QuestionResponseModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ques.delegate = self
//        if let arr = loadQuesResp(){
//            questionresponses = arr
//        }
//        ConnectivityManager connMgr = (ConnectivityManager) getSystemService(this.CONNECTIVITY_SERVICE);
//        NetworkInfo networkInfo = connMgr.getActiveNetworkInfo();
//        
//        if( networkInfo != null && networkInfo.isConnected()) {
//            newDownloadTask().execute("http://li859-75.members.linode.com/retrieveAllEntries.php");
//        } else {
//            Log.e("Error","networking not avail");
//        }
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
        postQuesResp()
        
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
//                        self.questionresponses.append(QuestionResponseModel(question: self.ques.text!, response: self.answer.text!))
                        self.postQuesResp()
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
       // self.performSegueWithIdentifier("NextScreen", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let vC = segue.destinationViewController as! UINavigationController
        //let historyVC = segue.destinationViewController as! HistoryViewController
        let historyVC = vC.viewControllers.first as! HistoryViewController
        
        historyVC.historyArray = questionresponses
    }
    
    func postQuesResp(){

        
        var url: NSURL = NSURL(string: postURL)!
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        let postString = "question=\(ques.text!)&answer=\(answer.text!)&username=\(self.user)"
        request.HTTPMethod = "POST"
        request.setValue("application/x-www=form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }

        }
        task.resume()
      
    }
    
//    func loadQuesResp() -> [QuestionResponseModel]?{
//        return NSKeyedUnarchiver.unarchiveObjectWithFile(QuestionResponseModel.ArchiveURL.path!) as? [QuestionResponseModel]
//    }
    
}

