//
//  Project.swift
//  Colab
//
//  Created by Andrew Gold on 4/19/15.
//  Copyright (c) 2015 goldreddyfishkin. All rights reserved.
//

class Project: NSObject {
    
    var _title:String!
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
        let proj = Project(title: project[Constants.projectKeys.title] as! String)
        
        proj._description = project[Constants.projectKeys.description] as? String
        proj._owner = project[Constants.projectKeys.owner] as? String
        proj._users = project[Constants.projectKeys.users] as? [String]
        
        return proj
        
    }


}
