//
//  EightBallModel.swift
//  Magic 8 Ball
//
//  Created by Pamela Needle on 8/11/15.
//  Copyright (c) 2015 Pamela Needle. All rights reserved.
//

import Foundation

class EightBallModel : CustomStringConvertible, CustomDebugStringConvertible{
    let initialResponseArray : Array<String>
    var responseArray : [String]?

    init() {
        initialResponseArray = [NSLocalizedString("Yes",comment: "yes"), NSLocalizedString("No",comment:"no")]
        responseArray = initialResponseArray
    }

    init(extraResponseArray : Array<String>){
        initialResponseArray = [NSLocalizedString("Yes",comment: "yes"), NSLocalizedString("No",comment:"no")]
        responseArray = initialResponseArray
        for str in extraResponseArray {
            responseArray!.append(str)
        }
       
        }
    
    func generateResponse() -> String {
        let numOfResponses = UInt32(responseArray!.count)
        let randomIndex = arc4random_uniform(numOfResponses)
        let ranInt = Int(randomIndex)
        return responseArray![ranInt]
    }
    
//    func getSoundIndex() -> Int {
//        let numOfResponses = UInt32(responseArray!.count)
//        let randomIndex = arc4random_uniform(numOfResponses)
//        let ranInt = Int(randomIndex)
//        return ranInt
//    }
  


var description : String {
    //Use a for loop to create a string based on the elements inside of response array
    var responseStrings = ""
    for resp in responseArray! {
        responseStrings += resp
    }
    return responseStrings
}

var debugDescription : String {
    //Use a for loop to create a string based on the elements inside of response array
    //Make sure the string starts with the word "Debug:"
    var debugStrings = "Debug:"
    for resp in responseArray!{
        debugStrings += resp
    }
    return debugStrings
}
}
