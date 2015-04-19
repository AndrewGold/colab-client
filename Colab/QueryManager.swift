//
//  QueryManager.swift
//  Colab
//
//  Created by Andrew Gold on 4/19/15.
//  Copyright (c) 2015 goldreddyfishkin. All rights reserved.
//

private let _managerSharedInstance = QueryManager()

class QueryManager: NSObject {
    
    let _requestManager = AFHTTPRequestOperationManager()
    let _URL = "http://127.0.0.1:8080"
    
    class var sharedInstance: QueryManager {
        return _managerSharedInstance
    }
    
    override init() {
        _requestManager.requestSerializer = AFJSONRequestSerializer(writingOptions: nil)
        _requestManager.requestSerializer.setValue("Application/JSON", forHTTPHeaderField:"Content-Type")
        _requestManager.requestSerializer.setValue("Application/JSON", forHTTPHeaderField:"Accept")
    }
    
    func POST(params:AnyObject!, url:String!, callback: (AnyObject) -> Void) {
        
        var URL = _URL + url
    
        _requestManager.POST(URL,
            parameters: params,
            success: { (operation, obj) in
                callback(obj)
            }, failure: { (operation, err) in
                callback(err)
        });
        
    }
    
    func GET(params:AnyObject!, url:String!, callback: (AnyObject) -> Void) {
        
        
    }

}
