//
//  SearchHelper.swift
//  Co-Llab
//
//  Created by Matthew Fishkin on 3/15/15.
//  Copyright (c) 2015 Fishkin. All rights reserved.
//

import UIKit

class SearchHelper: NSObject {
    
    func returnSearchResults(searchTerm:String!, allUsers:[User]) -> [User]{
        
        if searchTerm == "" {
            return allUsers
        }
        
        let rtrnUsers = allUsers.filter( { $0._fullName!.lowercaseString.rangeOfString(searchTerm.lowercaseString) != nil } )
        return rtrnUsers
 
    }
}
