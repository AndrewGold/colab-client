//
//  AddProjectViewController.swift
//  Colab
//
//  Created by Navneet Reddy on 4/30/15.
//  Copyright (c) 2015 goldreddyfishkin. All rights reserved.
//

import UIKit

class AddProjectViewController: UIViewController, UITextViewDelegate {
    // Outlets
    @IBOutlet weak var _projectName: UITextField!
    @IBOutlet weak var _projectDescription: UITextView!
    
    @IBOutlet weak var _bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var _projectSkill1: UILabel!
    @IBOutlet weak var _projectSkill2: UILabel!
    @IBOutlet weak var _projectSkill3: UILabel!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _projectDescription.text = "Project Description"
        _projectDescription.textColor = UIColor.lightGrayColor()
        
        _projectDescription.layer.borderWidth = 1.0
        _projectDescription.layer.borderColor = UIColor.grayColor().CGColor
        
    }
    
    @IBAction func AddNewSkill(sender: UIButton) {
        if (_projectAddNewSkill.hasText()) {
            switch skillIndex {
            case 1:
                _projectSkill1.text = _projectAddNewSkill.text
                _projectSkill1.sizeToFit()
                skills += [_projectAddNewSkill.text]
                _projectAddNewSkill.text = ""
                skillIndex++
            case 2:
                _projectSkill2.text = _projectAddNewSkill.text
                _projectSkill2.sizeToFit()
                skills += [_projectAddNewSkill.text]
                _projectAddNewSkill.text = ""
                skillIndex++
            case 3:
                _projectSkill3.text = _projectAddNewSkill.text
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
    
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        
        if( _projectName.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "" ||
            _projectDescription.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "" ||
            _projectSkill1.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == ""
            ) {
                self.showAlert("Please enter a title, description, and at least one skill!")
        } else {
            
            let project = Project(title: _projectName.text);
            
            project._description = _projectDescription.text;
            project._owner = UserController.currentUser;
            project._users = collaborators;
            
            var params = [String:AnyObject]()
            params["project"] = project.serialize()
            params["user"] = UserController.currentUser
            params["skills"] = skills
            
            QueryManager.sharedInstance.POST(params, url: Constants.URLsuffix.addProject) {
                (responseObject) -> Void in
                
                let notification = NSNotification(name: Constants.notifications.kNewProjectNotification, object: project, userInfo: nil)
                NSNotificationCenter.defaultCenter().postNotification(notification)
                
                self.performSegueWithIdentifier("unwindToProfile", sender: self)
            }
        }
    }
    
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue) {
        print("unwind")
    }
    
    // MARK: - TextView Delegate
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if ((textView.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())) == "") {
            textView.text = "Project Description"
            textView.textColor = UIColor.lightGrayColor()
        }
    }
    
    private func showAlert(message: String) {
        var alert = UIAlertView(title: "Oops!", message: message, delegate: self, cancelButtonTitle: "Okay");
        alert.show()
    }
    
};