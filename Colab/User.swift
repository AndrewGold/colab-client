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
    
    class func deserialize(users:NSDictionary) -> User {
        let usr = User(id: "nil")
    
        return usr
    }
}
