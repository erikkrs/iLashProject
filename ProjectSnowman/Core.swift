//
//  Core.swift
//  communifime
//
//  Created by Michael Litman on 3/26/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import Firebase

class Core: NSObject
{
    static var storyboard : UIStoryboard!
    static var userProfileDictionary : [String: String]! = nil
    static var providerCut = 0.8
    
    static var fireBaseRef = Firebase(url: "https://project-snowman.firebaseio.com/")
    
    static func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
}
