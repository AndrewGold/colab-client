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
    @IBOutlet weak var _addSkillButton: UIButton!
    
    @IBOutlet weak var _collaboratorList: UILabel!
    @IBOutlet weak var _projectContributors: UITextField?
    
    @IBOutlet weak var _submit: UIButton!
    
    var skill1IsSelected:Bool = false;
    var skill2IsSelected:Bool = false;
    var skill3IsSelected:Bool = false;
    var skills = [String]();
    var collaborators = [String]();
    
    var skillIndex = 1;
    
    @IBAction func AddNewSkill(sender: UIButton) {
        if (_projectAddNewSkill.hasText()) {
            switch skillIndex {
            case 1:
                _projectSkill1.setTitle(_projectAddNewSkill.text, forState: UIControlState.Normal)
                _projectSkill1.sizeToFit()
                skills += [_projectAddNewSkill.text]
                _projectAddNewSkill.text = ""
                skillIndex++
            case 2:
                _projectSkill2.setTitle(_projectAddNewSkill.text, forState: UIControlState.Normal)
                _projectSkill2.sizeToFit()
                skills += [_projectAddNewSkill.text]
                _projectAddNewSkill.text = ""
                skillIndex++
            case 3:
                _projectSkill3.setTitle(_projectAddNewSkill.text, forState: UIControlState.Normal)
                _projectSkill3.sizeToFit()
                skills += [_projectAddNewSkill.text]
                _projectAddNewSkill.text = ""
                skillIndex++
            default:
                let alert = UIAlertView(title: "Oops!", message: "You can only add up to 3 skills", delegate: self, cancelButtonTitle: "Okay")
                alert.show()
            }
        }
        
    }
    
    /* TODO: be able to remove skills once added. */
    
    @IBAction func Skill1Touched(sender: UIButton) {
        if skill1IsSelected == false {
            sender.highlighted = true;
            skill1IsSelected = true
        } else {
            sender.highlighted = false;
            skill1IsSelected = false
        }
    }
    
    @IBAction func Skill2Touched(sender: UIButton) {
        if skill2IsSelected == false{
            sender.highlighted = true;
            skill2IsSelected = true
        } else {
            sender.highlighted = false;
            skill2IsSelected = false
        }
        
    }
    
    @IBAction func Skill3Touched(sender: UIButton) {
        
        if skill3IsSelected == false{
            sender.highlighted = true;
            skill3IsSelected = true;
        } else {
            sender.highlighted = false;
            skill3IsSelected = false;
        }
    }
    
    func AddCollaboratorTouched(sender: UIButton) {
        _collaboratorList.text! = "";
        
        if ((_projectContributors?.hasText()) != nil) {
            collaborators.append(_projectContributors!.text);
            
            _collaboratorList.text = "Collaborators: ";
            
            for _projectContributors in collaborators {
                _collaboratorList.text! += _projectContributors;
                _collaboratorList.text! += ", ";
            }
            
            _projectContributors!.text = nil;
        }
    }
    
    func submitButtonPressed(sender: AnyObject) {
        
        let project = Project();
        
        project._title = _projectName.text;
        project._description = _projectDescription.text;
        project._owner = UserController.currentUser;
        project._users = collaborators;
        
        project.serialize();
        
        QueryManager.sharedInstance.POST(["projects": _projectName.text], url: Constants.URLsuffix.updateUserInfo) {
            (responseObject) -> Void in
            
            let notification = NSNotification(name: Constants.notifications.kNewProjectNotification, object: project, userInfo: nil)
            NSNotificationCenter.defaultCenter().postNotification(notification)
        }
    }
    
};