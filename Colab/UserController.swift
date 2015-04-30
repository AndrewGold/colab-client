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
    
    class func updateUserInfo(user:User!, tagline:String!, description:String!, location:String!) {
        
        QueryManager.sharedInstance.POST((["user":user.serialize] as! AnyObject), url: Constants.URLsuffix.updateUserInfo) { (responseObject) -> Void in
            print(responseObject)
        }
        
    }
    
    class func getAllUsers(callback: (NSArray) -> Void) {
        
        QueryManager.sharedInstance.GET(nil, url: Constants.URLsuffix.getAllUsers) { (responseObject) -> Void in
            var result = [User]()
            if let userArray = responseObject["users"] as? NSArray {
                for (var i = 0; i < userArray.count; i++) {
                    var user = User.deserialize(userArray[i] as! NSDictionary)
                    result += [user]
                }
                
            }
            callback(result)
        }
    }


}
