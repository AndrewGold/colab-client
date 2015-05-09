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
    
    class func getUser(id: String!, callback: (User?) -> Void) {
        
        var parameters = [String:String]()
        parameters["user"] = id
        
        QueryManager.sharedInstance.POST(parameters, url: Constants.URLsuffix.getUser) { (responseObject) -> Void in
            if let userDict = responseObject["user"] as? NSDictionary {
                callback(User.deserialize(userDict))
            } else {
                callback(nil)
            }
        }
    }
    
    class func storeLoginInformation(email: String, id: String) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(email, forKey: "email")
        defaults.setObject(id, forKey: "_id")
        defaults.synchronize()
        
    }
    
    class func checkIfLoggedIn() -> Bool {
        let defaults = NSUserDefaults.standardUserDefaults()
        userID = defaults.objectForKey("_id") as? String
        return (defaults.objectForKey("email") != nil && userID != nil)
    }
    
    class func logOutUser() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(nil, forKey: "_id")
        defaults.synchronize()
    }


}
