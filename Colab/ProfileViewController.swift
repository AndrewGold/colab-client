//
//  ProfileViewController.swift
//  Colab
//
//  Created by Matthew Fishkin on 4/14/15.
//  Copyright (c) 2015 goldreddyfishkin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var _userImage: UIImageView!
    @IBOutlet weak var _userName: UITextField!
    @IBOutlet weak var _userTagLine: UITextField!
    @IBOutlet weak var _userScore: UILabel!
    @IBOutlet weak var _userSkill1: UILabel!
    @IBOutlet weak var _userSkill2: UILabel!
    @IBOutlet weak var _userSkill3: UILabel!
    
    // Mark: - Private Variables
    private var userImage:UIImage?
    private var userName:String! = "Default"
    private var userTagLine:String! = "Default"
    private var userScore:String! = "0"
    private var userSkill1 = "Default"
    private var userSkill2 = "Default"
    private var userSkill3 = "Default"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _userImage.image = userImage!
        _userName.text = userName
        _userTagLine.text = userTagLine
        _userScore.text = userScore
        _userSkill1.text = userSkill1
        _userSkill2.text = userSkill2
        _userSkill3.text = userSkill3
        
        saveProfile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadUserFromCell(cell: CustomUserTableViewCell) {
        userImage = cell._userImage.image
        userName = cell._userName.text!
        userTagLine = cell._userTagline.text!
        userScore = cell._userScore.text!
        
        if cell._userSkill1.text != nil {
            userSkill1 = cell._userSkill1.text!
        }
        
        if cell._userSkill2.text != nil {
            userSkill2 = cell._userSkill2.text!
        }
        
        if cell._userSkill3.text != nil {
            userSkill3 = cell._userSkill3.text!
        }
    }
    
    func editProfile() {
        _userName.enabled = true
        _userTagLine.enabled = true
        
        let editButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "saveProfile"  )
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    func saveProfile () {
        _userName.enabled = false
        _userTagLine.enabled = false
        
        let editButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "editProfile"  )
        self.navigationItem.rightBarButtonItem = editButton
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
