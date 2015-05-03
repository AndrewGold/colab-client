//
//  AddProjectViewController.swift
//  Colab
//
//  Created by Navneet Reddy on 4/30/15.
//  Copyright (c) 2015 goldreddyfishkin. All rights reserved.
//

import UIKit

class AddProjectViewController: UIViewController {
    // Outlets
    @IBOutlet weak var _projectName: UITextField!
    @IBOutlet weak var _projectDescription: UITextField!
    
    @IBOutlet weak var _projectSkill1: UIButton!
    @IBOutlet weak var _projectSkill2: UIButton!
    @IBOutlet weak var _projectSkill3: UIButton!
    @IBOutlet weak var _projectAddNewSkill: UITextField!
    
    @IBOutlet weak var _projectContributors: UITextField?
    
    @IBOutlet weak var _submit: UIButton!
    
    
    /*Not sure if needed *//*
    //Edot Project Name
    @IBAction func projectNameEdited(sender: AnyObject) {
        
        
    }
    
    //Edit Project Description
    @IBAction func projectDescriptionEdited(sender: AnyObject) {
        
        
    }
    
    //Add new skills to the project
    @IBAction func projectAddSkills(sender: AnyObject) {
    }
    
    //Edit Project Contributors
    @IBAction func projectAddCollaborators(sender: AnyObject) {
    }
    */
    
    func getCollaborators() -> [String]! {
        // Parse users from _projectCollaborators and get userIDs of the users.
        
        return [];
    }
    
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        
        let project = Project();
        
        project._title = _projectName.text;
        project._description = _projectDescription.text;
        project._owner = UserController.currentUser;
        project._users = getCollaborators();
        
        var params = [String:AnyObject]()
        params["user"] = ([Constants.userKeys.ID:UserController.currentUser] as! AnyObject)
        params["project"] = project.serialize()
        
        QueryManager.sharedInstance.POST(params, url: Constants.URLsuffix.updateUserInfo) {
            (responseObject) -> Void in
            
            let notification = NSNotification(name: Constants.notifications.kNewProjectNotification, object: project, userInfo: nil)
            NSNotificationCenter.defaultCenter().postNotification(notification)
        }
    }
    

    
    
    
    

}