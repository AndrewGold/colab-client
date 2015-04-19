//
//  UserController.swift
//  Colab
//
//  Created by Andrew Gold on 4/19/15.
//  Copyright (c) 2015 goldreddyfishkin. All rights reserved.
//

class UserController: NSObject {
    
    func updateUserInfo(user:User!, tagline:String!, description:String!, location:String!) {
        
        QueryManager.sharedInstance.POST((["user":user.serialize] as! AnyObject), url: Constants.URLsuffix.updateUserInfo) { (responseObject) -> Void in
            print(responseObject)
        }
        
    }

}
