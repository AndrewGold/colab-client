//
//  User.swift
//  Co-Llab
//
//  Created by Matthew Fishkin on 3/15/15.
//  Copyright (c) 2015 Fishkin. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var _firstName:String!
    var _lastName:String!
    var _email:String!
    var _hashedPassword:String!
    var _tagLine:String!
    var _description:String!
    var _location:String!
    var _image:String!
    
    var _skills:[Skill]!
    var _projects:[Project:[Skill]]!
    
    init(email:String!) {
        _email = email
        super.init()
    }
}
