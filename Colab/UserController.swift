//
//  UserController.swift
//  Colab
//
//  Created by Andrew Gold on 4/19/15.
//  Copyright (c) 2015 goldreddyfishkin. All rights reserved.
//

private var userID:String?

class UserController: NSObject {
    
    class var currentUser: String? {
        if (userID != nil) {
            return userID!
        } else {
            return nil
        }
    }
    
    class func setUserID(id: String!) {
        userID = id
    }
    
    func updateUserInfo(user:User!, tagline:String!, description:String!, location:String!) {
        
        QueryManager.sharedInstance.POST((["user":user.serialize] as! AnyObject), url: Constants.URLsuffix.updateUserInfo) { (responseObject) -> Void in
            print(responseObject)
        }
        
    }
    
    func getAllUsers 


}
