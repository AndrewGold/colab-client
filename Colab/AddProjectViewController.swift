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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardNotification:", name: UIKeyboardWillChangeFrameNotification, object: nil)
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
    
    func keyboardNotification(notif:NSNotification) {
        if let userInfo = notif.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue()
            let duration:NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.unsignedLongValue ?? UIViewAnimationOptions.CurveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            self._bottomConstraint?.constant = endFrame?.size.height ?? 0.0
            UIView.animateWithDuration(duration,
                delay: NSTimeInterval(0),
                options: animationCurve,
                animations: { self.view.layoutIfNeeded() },
                completion: nil)
        }
    }
    
};