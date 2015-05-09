//
//  Project.swift
//  Colab
//
//  Created by Andrew Gold on 4/19/15.
//  Copyright (c) 2015 goldreddyfishkin. All rights reserved.
//

class Project: NSObject {
    
    var _title:String?
    var _description:String?
    var _owner:String?
    var _users:[String]?
    
    init(title:String!) {
        _title = title
        super.init()
    }
    
    func serialize() -> [String:AnyObject] {
        
        var result = [String:AnyObject]()
        
        result[Constants.projectKeys.title] = _title
        result[Constants.projectKeys.description] = _description
        result[Constants.projectKeys.owner] = _owner
        result[Constants.projectKeys.users] = _users
        
        return result
    }
    
    class func deserialize(project:NSDictionary) -> Project {
        let projDict = project.valueForKey("project") as! NSDictionary
        var proj:Project?
        
        if(projDict[Constants.projectKeys.title] != nil) {
            proj = Project(title: projDict[Constants.projectKeys.title] as? String)
        } else {
            proj = Project(title: "No Title")
        }
        
        if(projDict[Constants.projectKeys.description] != nil) {
            proj!._description = projDict[Constants.projectKeys.description] as? String
        }
        if(projDict[Constants.projectKeys.owner] != nil) {
            proj!._owner = projDict[Constants.projectKeys.owner] as? String
        }
        if(projDict[Constants.projectKeys.users] != nil) {
            proj!._users = projDict[Constants.projectKeys.users] as? [String]
        }
        
        return proj!
        
    }


}
