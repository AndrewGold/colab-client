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
        
        var rtrnUsers:[User] = []
        
        for usr in allUsers {
            let containsName = usr._fullName!.lowercaseString.rangeOfString(searchTerm.lowercaseString) != nil
            let containsSkill = usr._skills?.filter( { $0._title.lowercaseString == searchTerm.lowercaseString} ).count > 0
            
            if (containsName || containsSkill) {
                rtrnUsers += [usr]
            }
        }
        
        return rtrnUsers
 
    }
}
