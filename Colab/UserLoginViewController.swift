//
//  UserLoginViewController.swift
//  Colab
//
//  Created by Matthew Fishkin on 4/19/15.
//  Copyright (c) 2015 goldreddyfishkin. All rights reserved.
//

import UIKit

class UserLoginViewController: UIViewController {
    // Outlets
    @IBOutlet weak var _userEmail: UITextField!
    @IBOutlet weak var _userPassword: UITextField!
    @IBOutlet weak var _userConfirmPassword: UITextField!
    
    // Submit button text dependent on state (login vs signup)
    @IBOutlet weak var _submitButton: UIButton!
    @IBOutlet weak var _newUserButton: UIButton!
    
    // Holds whether or not user is in signup or login
    var newUser = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if (UserController.checkIfLoggedIn()) {
            self.segueToApp()
        } else {
            updateView()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func submitButtonPressed(sender: AnyObject) {
        
        var URLsuffix:String!
        
        if (newUser == true) {
            URLsuffix = Constants.URLsuffix.signup
        } else {
            URLsuffix = Constants.URLsuffix.login
        }
    
        /* This line is for debugging*/
        checkSignUpFields()
        
        /*Uncomment when working*/
        //if (newUser == false || checkSignUpFields() == true) {
            QueryManager.sharedInstance.POST(["email": _userEmail.text, "password": _userPassword.text], url: URLsuffix) { (responseObject) -> Void in
                print(responseObject)
                if let status: AnyObject? = responseObject["status"] {
                    if (self._userEmail.text == "" || self._userEmail.text == nil ||
                        self._userPassword.text == "" || self._userPassword.text == nil) {
                            self.showAlert("Incorrect username or password. Please try again.")
                    } else if (Int(status as! NSNumber) == 0) {
                        UserController.setUserID(responseObject["userId"] as! String)
                        UserController.storeLoginInformation(self._userEmail.text, id: responseObject["userId"] as! String)
                        
                        self.segueToApp()
                    } else {
                        self.showAlert("Incorrect username or password. Please try again.")
                        //
                        //                     // TODO: take out only for testing
                        //                     self.segueToApp()
                    }
                } else {
                    self.showAlert("Network error. Please make sure you are connected to the internet and try again.")
                    //
                    //                 // TODO: take out only for testing
                    //                 self.segueToApp()
                }
            }
        //}
    }
    
    func checkSignUpFields() -> Bool {
        if (_userEmail.text == "" || _userEmail.text == nil) {
            self.showAlert("Please enter a valid email.")
            _userEmail.text = ""
            _userPassword.text = ""
            _userConfirmPassword.text = ""
            return false
        } else if (_userEmail.text.hasSuffix(".edu") == false) {
            self.showAlert("Please enter a '.edu' email.")
            _userEmail.text = ""
            _userPassword.text = ""
            _userConfirmPassword.text = ""
            return false
        } else if (_userPassword.text == "" || _userPassword.text == nil) {
            self.showAlert("Please enter a password.")
            _userPassword.text = ""
            _userConfirmPassword.text = ""
            return false
        } else if (_userConfirmPassword.text == "" || _userConfirmPassword.text == nil) {
            self.showAlert("Please enter a password.")
            _userPassword.text = ""
            _userConfirmPassword.text = ""
            return false
        } else if (_userPassword.text != _userConfirmPassword.text) {
            self.showAlert("Passwords don't match. Please try again.")
            _userPassword.text = ""
            _userConfirmPassword.text = ""
            return false
        }
        
        return true
    }
    
    @IBAction func newUserButtonPressed(sender: AnyObject) {
        newUser = !newUser
        updateView()
    }
    
    private func updateView() {
        if !newUser { // IF returning user
            _userConfirmPassword.enabled = false
            _userConfirmPassword.hidden = true
            _submitButton.setTitle("Log In", forState: .Normal);
            _newUserButton.setTitle("New User? Sign Up!", forState: UIControlState.Normal)
        } else { // IF new user
            _userConfirmPassword.enabled = true
            _userConfirmPassword.hidden = false
            _submitButton.setTitle("Sign Up", forState: .Normal);
            _newUserButton.setTitle("Returning user? Sign In!", forState: UIControlState.Normal)
        }
    }
    
    
    
    // MARK: - Navigation
    private func segueToApp() {
        performSegueWithIdentifier("logInSegue", sender: self)
    }
    
    private func showAlert(message: String) {
        var alert = UIAlertView(title: "Oops!", message: message, delegate: self, cancelButtonTitle: "Okay");
        alert.show()
    }
    
    func unwindToLogInView(segue:UIStoryboardSegue) {
        UserController.logOutUser()
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "logInSegue") {
            if let destination = segue.destinationViewController as? UITabBarController {
                if let navCont = destination.viewControllers?[0] as? UINavigationController {
                    if let profCont = navCont.viewControllers?[0] as? ProfileViewController {
                        profCont.isSelf = true
                        
                        profCont.firstTimeUser = newUser
                    }
                }
            }
        }
        
    }

}
