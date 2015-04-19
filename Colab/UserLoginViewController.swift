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
        
        // Do any additional setup after loading the view.
        updateView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func submitButtonPressed(sender: AnyObject) {
        
    }
    
    @IBAction func newUserButtonPressed(sender: AnyObject) {
        newUser = !newUser
        updateView()
    }
    
    private func updateView() {
        if !newUser { // IF returning user
            _userConfirmPassword.enabled = false
            _userConfirmPassword.hidden = true
            _newUserButton.setTitle("New User? Sign Up!", forState: UIControlState.Normal)
        } else { // IF new user
            _userConfirmPassword.enabled = true
            _userConfirmPassword.hidden = false
            _newUserButton.setTitle("Returning user? Sign In!", forState: UIControlState.Normal)
        }
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
