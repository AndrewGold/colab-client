//
//  Collections.swift
//  Co-Llab
//
//  Created by Matthew Fishkin on 3/15/15.
//  Copyright (c) 2015 Fishkin. All rights reserved.
//

import UIKit

class Collections: NSObject {
    var users:[User] = []
    
    override init() {
        
        let usr1 = User(email: "test@test.com")
        let usr2 = User(email: "test@test.com")
        let usr3 = User(email: "test@test.com")
        
        
        users.append(usr1)
        users.append(usr2)
        users.append(usr3)
    }
}
