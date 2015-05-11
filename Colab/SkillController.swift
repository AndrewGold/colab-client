//
//  SkillController.swift
//  Colab
//
//  Created by Andrew Gold on 5/10/15.
//  Copyright (c) 2015 goldreddyfishkin. All rights reserved.
//

class SkillController: NSObject {
    
    class func getSkill(id: String, callback: (String) -> Void) {
        
        var parameters = [String:String]()
        parameters["skill"] = id
        
        QueryManager.sharedInstance.POST(parameters, url: Constants.URLsuffix.getSkill) { (responseObject) -> Void in
            var skill = responseObject["skill"] as! NSDictionary
            callback(skill["title"] as! String)
        }
    }

}
