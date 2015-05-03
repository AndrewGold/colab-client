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
    
    var skill1IsSelected:Bool = false;
    var skill2IsSelected:Bool = false;
    var skill3IsSelected:Bool = false;
    var skills = [String]();
    
    @IBAction func AddNewSkill(sender: UIButton) {
        QueryManager.sharedInstance.POST(["skills": _projectAddNewSkill.text], url: Constants.URLsuffix.updateUserInfo) {
            (responseObject) -> Void in
            
        }
        
    }
    
    func Skill1Touched(sender: UIButton) {
        if skill1IsSelected == false{
            sender.highlighted = true;
            skill1IsSelected = true
            //skills.append(skill1);        /* skill1 needs to be changed to the skill coming in */
        }else{
            sender.highlighted = false;
            skill1IsSelected = false
            //skills.removeAtIndex(find skill1 in array)`        /* Find skill in array */
        }
        
    }
    
    func Skill2Touched(sender: UIButton) {
        if skill2IsSelected == false{
            sender.highlighted = true;
            skill2IsSelected = true
            //skills.append(skill3);        /* skill1 needs to be changed to the skill coming in */
        }else{
            sender.highlighted = false;
            skill2IsSelected = false
            //skills.removeAtIndex(find skill3 in array)`        /* Find skill in array */
        }
        
    }
    
    func Skill3Touched(sender: UIButton) {
        
        if skill3IsSelected == false{
            sender.highlighted = true;
            skill3IsSelected = true
            //skills.append(skill3);        /* skill1 needs to be changed to the skill coming in */
        }else{
            sender.highlighted = false;
            skill3IsSelected = false
            //skills.removeAtIndex(find skill3 in array)`        /* Find skill in array */
        }
    }
    
    func getCollaborators() -> [String]! {
        // Parse users from _projectCollaborators and get userIDs of the users.
        
        return [];
    }
    
    
    func submitButtonPressed(sender: AnyObject) {
        
        let project = Project();
        
        project._title = _projectName.text;
        project._description = _projectDescription.text;
        project._owner = UserController.currentUser;
        project._users = getCollaborators();
        
        project.serialize();
        
        QueryManager.sharedInstance.POST(["projects": _projectName.text], url: Constants.URLsuffix.updateUserInfo) {
            (responseObject) -> Void in
            
            let notification = NSNotification(name: Constants.notifications.kNewProjectNotification, object: project, userInfo: nil)
            NSNotificationCenter.defaultCenter().postNotification(notification)
        }
    }
    
};