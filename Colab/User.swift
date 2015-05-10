//
//  User.swift
//  Co-Llab
//
//  Created by Matthew Fishkin on 3/15/15.
//  Copyright (c) 2015 Fishkin. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var _id:String?
    var _firstName:String?
    var _lastName:String?
    var _email:String?
    var _hashedPassword:String?
    var _tagline:String?
    var _description:String?
    var _location:String?
    var _image:String?
    
    // used for search
    var _fullName:String?
    
    var _skills:[Skill]?
    var _projects:[Project:[Skill]]?
    
    init(id:String!) {
        _id = id
        super.init()
    }
    
    func serialize() -> [String:String] {
        
        var dictionary = [String:String]()
        
        if _id != nil {dictionary[Constants.userKeys.ID] = _id}
        if _firstName != nil {dictionary[Constants.userKeys.firstName] = _firstName}
        if _lastName != nil {dictionary[Constants.userKeys.lastName] = _lastName}
        if _email != nil {dictionary[Constants.userKeys.email] = _email}
        if _hashedPassword != nil {dictionary[Constants.userKeys.hashedPassword] = _hashedPassword}
        if _tagline != nil {dictionary[Constants.userKeys.tagline] = _tagline}
        if _description != nil {dictionary[Constants.userKeys.description] = _description}
        if _location != nil {dictionary[Constants.userKeys.location] = _location}
        
        return dictionary
    }
    
    class func deserialize(user:NSDictionary) -> User {
        print(user)
        
        let usr = User(id: user[Constants.userKeys.ID] as! String)
    
        usr._email = user[Constants.userKeys.email] as? String
        usr._firstName = user[Constants.userKeys.firstName] as? String
        usr._lastName = user[Constants.userKeys.lastName] as? String
        usr._description = user[Constants.userKeys.description] as? String
        usr._id = user[Constants.userKeys.ID] as? String
        usr._location = user[Constants.userKeys.location] as? String
        usr._image = user[Constants.userKeys.image] as? String
        usr._tagline = user[Constants.userKeys.tagline] as? String
        
        usr._fullName = usr._firstName! + " " + usr._lastName!
        
        let skills = user[Constants.userKeys.skills] as? NSArray
        usr._skills = (user[Constants.userKeys.skills] as? NSArray) as? [Skill]
        
        return usr
    
    }
}
