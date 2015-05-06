//
//  Constants.swift
//  Colab
//
//  Created by Andrew Gold on 4/19/15.
//  Copyright (c) 2015 goldreddyfishkin. All rights reserved.
//

class Constants: NSObject {
    
    struct URLsuffix {
        static let login = "/login"
        static let signup = "/signup"
        static let updateUserInfo = "/updateUserInfo"
        static let getAllUsers = "/getAllUsers"
        static let getUser = "/getUser"
        static let addProject = "/addProject"
    }
    
    struct responseStatus {
        static let statusKey = "status"
        static let success = 0
        static let error = 1
    }
    
    struct userKeys {
        static let ID = "_id"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let email = "email"
        static let hashedPassword = "hashedPassword"
        static let tagline = "tagline"
        static let description = "description"
        static let location = "location"
        static let image = "image"
        static let skills = "skills"
        static let projects = "projects"
    }
    
    struct projectKeys {
        static let title = "title"
        static let description = "description"
        static let owner = "owner"
        static let users = "users"
    }
    
    struct notifications {
        static let kNewProjectNotification = "kNewProjectNotification"
    }

}
