//
//  QuestionResponseModel.swift
//  Magic 8 Ball
//
//  Created by Pamela Needle on 8/24/15.
//  Copyright (c) 2015 Pamela Needle. All rights reserved.
//

import Foundation
import UIKit


//QuestionResponseModel.ArchiveURL.path!

class QuestionResponseModel: NSObject{
   
    //Properties
    var question: String
    var response: String
    var user: String
    var imageURL: String
    
    static let DocumentsDirectory: AnyObject = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("questionresponses")
    
    
    init(question: String, response: String, user: String, imageURL: String){
        self.question = question
        self.response = response
        self.user = user
        self.imageURL = imageURL
        
        super.init()
    }
    
//    struct PropertyKey{
//        static let quesKey = "question"
//        static let respKey = "response"
//    }
//
//    
//    func encodeWithCoder(aCoder: NSCoder){
//        aCoder.encodeObject(question, forKey: PropertyKey.quesKey)
//        aCoder.encodeObject(response, forKey: PropertyKey.respKey)
//    }
//    
//    required convenience init?(coder aDecoder: NSCoder){
//        let question = aDecoder.decodeObjectForKey(PropertyKey.quesKey) as! String
//        let response = aDecoder.decodeObjectForKey(PropertyKey.respKey) as! String
//        self.init(question: question, response: response, user: user, imageURL: imageURL)
//    }
}
