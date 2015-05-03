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
    
    class func storeLoginInformation(email: String, password: String) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(email, forKey: "email")
        defaults.setObject(password, forKey: "password")
        defaults.synchronize()
        
    }
    
    class func checkIfLoggedIn() -> Bool {
        let defaults = NSUserDefaults.standardUserDefaults()
        return (defaults.objectForKey("email") != nil && defaults.objectForKey("password") != nil)
    }


}
