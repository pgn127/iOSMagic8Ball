//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Pamela Needle on 8/11/15.
//  Copyright (c) 2015 Pamela Needle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        println("Pamela Needle")
        var age = 20.00
        println("My age is \(age)")
        var name = "Pamela Needle"
        println(name)
        let responses = ["Not a chance!","Perhaps","Most definetely","Maybe","For sure","Yeah right!"]
        let model = EightBallModel(extraResponseArray:responses)
        println("Will I get full marks for this lab?")
        println(model.generateResponse())
        println("Will the Cronulla sharks receive a premiership this year?")
        println(model.generateResponse())
        println("Will I end up becoming a cat person when I get old?")
        println(model.generateResponse())
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

