//
//  EditProfileViewController.swift
//  Colab
//
//  Created by Matthew Fishkin on 5/3/15.
//  Copyright (c) 2015 goldreddyfishkin. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var _firstName: UITextField!
    @IBOutlet weak var _lastName: UITextField!
    @IBOutlet weak var _tagLine: UITextField!
    @IBOutlet weak var _description: UITextView!
    
    // Used to store variables before view loads
    var firstName:String?
    var lastName:String?
    var tagLine:String?
    var usrDescription:String?
    
    var firstTimeUser = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _description.layer.borderWidth = 1.0
        _description.layer.borderColor = UIColor.grayColor().CGColor
        _description.textColor = UIColor.blackColor()
        
        if(!firstTimeUser) {
            loadUserInfo()
        } else { // remove back button, HAVE to save info
            self.navigationItem.leftBarButtonItem = nil
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        let saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "saveInformation"  )
        
        self.navigationItem.rightBarButtonItem = saveButton
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveInformation() {
        
        var user = User(id: UserController.currentUser)
        user._firstName = _firstName.text
        user._lastName = _lastName.text
        user._tagline = _tagLine.text
        user._description = _description.text
        
        if(_lastName.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "" ||
            _firstName.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "" ||
            _tagLine.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "" ||
            _description.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == ""
        ) {
                self.showAlert("Please fill out all entries")
        } else {
            
            var params = [String:AnyObject]()
            params["user"] = user.serialize()
            
            QueryManager.sharedInstance.POST(params, url: Constants.URLsuffix.updateUserInfo) { (responseObject) -> Void in
                print(responseObject)
                
                self.performSegueWithIdentifier("unwindToProfile", sender: self)
            }
        }
    }
    
    @IBAction func unwindToProfile(segue:UIStoryboardSegue) {
        
    }
    
    private func loadUserInfo() {
        _firstName.text = firstName!
        _lastName.text = lastName!
        _description.text = usrDescription!
        _tagLine.text = tagLine!
    }
    
    private func showAlert(message: String) {
        var alert = UIAlertView(title: "Oops!", message: message, delegate: self, cancelButtonTitle: "Okay");
        alert.show()
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
