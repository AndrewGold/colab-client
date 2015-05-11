//
//  ProfileViewController.swift
//  Colab
//
//  Created by Matthew Fishkin on 4/14/15.
//  Copyright (c) 2015 goldreddyfishkin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Outlets
    @IBOutlet weak var _userImage: UIImageView!
    @IBOutlet weak var _userName: UITextField!
    @IBOutlet weak var _userTagLine: UITextField!
    @IBOutlet weak var _userScore: UILabel!
    @IBOutlet weak var _userSkill1: UILabel!
    @IBOutlet weak var _userSkill2: UILabel!
    @IBOutlet weak var _userSkill3: UILabel!
    @IBOutlet weak var _userDescription: UITextView!
    
    @IBOutlet weak var _projectTable: UITableView!
    
    @IBOutlet weak var addProjectButton: UIButton!
    
    // Boolean - is this your profile or someone else's?
    internal var isSelf = false
    internal var firstTimeUser = true
    internal var curUsr:String?
    
    internal var usrProjects:[Project]?
    
    // Mark: - Private Variables
    private var userImage:UIImage?
    private var userName:String! = "Default"
    private var firstName:String! = "Defualt"
    private var lastName:String! = "Defualt"
    private var userTagLine:String! = "Default"
    private var userSkill1 = "Default"
    private var userSkill2 = "Default"
    private var userSkill3 = "Default"
    private var userDescription = "Default"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(isSelf) {
            curUsr = UserController.currentUser
        } else {
            addProjectButton.enabled = false
            addProjectButton.hidden = true
        }
        
        UserController.getUser(curUsr, callback: { (user) -> Void in
            self.setUpProfileWithUser(user)
            self.updateProfileFields()
        })
        
        
        if(userImage != nil) {
            _userImage.image = userImage!
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "newProjectAdded:", name:Constants.notifications.kNewProjectNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "skillsFinished:", name:Constants.notifications.kNewProjectNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        if(isSelf) {
            curUsr = UserController.currentUser
            
            let logoutButton = UIBarButtonItem(title: "Log Out", style: UIBarButtonItemStyle.Plain, target: self, action: "logOutUser")
            
            self.navigationItem.leftBarButtonItem = logoutButton
        }
        
        UserController.getUser(curUsr, callback: { (user) -> Void in
            self.setUpProfileWithUser(user)
            self.updateProfileFields()
        })
        
        UserController.getUsersProjects(curUsr!, callback: { (project) -> Void in
            print(project)
            
            self.usrProjects = project as? [Project]
            self._projectTable.reloadData()
        })
        
    }
    
    func setUpProfileWithUser(usr:User!) {
        userImage = UIImage(named: "placeholder.png")
        firstName = usr._firstName!
        lastName = usr._lastName!
        userName = firstName + " " + lastName
        userTagLine = usr._tagline!
        userDescription = usr._description!
        
        let maxIndex = min(3, usr._skills!.count)
        var curSkillIndex = 0
        for(var i = 0; i < maxIndex; i++) {
            SkillController.getSkill(usr._skills![i]._title, callback: { (skillName) -> Void in
                if (curSkillIndex == 0) {
                    self.userSkill1 = skillName
                    self._userSkill1.text = skillName
                    self._userSkill1.hidden = false
                    curSkillIndex++
                } else if (curSkillIndex == 1) {
                    self.userSkill2 = skillName
                    self._userSkill2.text = skillName
                    self._userSkill2.hidden = false
                    curSkillIndex++
                } else {
                    self.userSkill3 = skillName
                    self._userSkill3.text = skillName
                    self._userSkill3.hidden = false
                    curSkillIndex = 0
                }
            })

        }
        
    }
    
    func updateProfileFields() {
        _userImage.image = userImage
        _userName.text = userName
        _userTagLine.text = userTagLine
        _userDescription.text = userDescription
    }
    
    override func viewDidAppear(animated: Bool) {
        firstTimeUser ? editProfile() : saveProfile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func editProfile() {
        var editButton:UIBarButtonItem?
        
        if (isSelf) {
            firstTimeUser = false
            performSegueWithIdentifier("setUpProfile", sender: self)
        } else {
            editButton = UIBarButtonItem(title: "Chat", style: UIBarButtonItemStyle.Plain, target: self, action: "beginChat")
        }
        
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    func saveProfile () {
        _userName.enabled = false
        _userTagLine.enabled = false
        
        var editButton:UIBarButtonItem?
    
        if (isSelf) {
             editButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "editProfile"  )
        } else {
             editButton = UIBarButtonItem(title: "Chat", style: UIBarButtonItemStyle.Plain, target: self, action: "beginChat")
        }
        
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    
    func beginChat() {
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "setUpProfile") {
            if(firstTimeUser) {
                firstTimeUser = false
            } else {
                if let editController = segue.destinationViewController as? EditProfileViewController {
                    editController.firstName = firstName
                    editController.lastName = lastName
                    editController.usrDescription = userDescription
                    editController.tagLine = userTagLine
                    
                    editController.firstTimeUser = false
                }
            }
        }
    }
    
    @IBAction func addProjectButtonPressed(sender: AnyObject) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("AddProjectViewController") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func unwindToProfile(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindToLogInView(segue:UIStoryboardSegue) {
        
    }
    
    dynamic private func newProjectAdded(notification: NSNotification){
        //Action take on Notification
        UserController.getUsersProjects(curUsr!, callback: { (project) -> Void in
            print(project)
            
            self.usrProjects = project as? [Project]
            self._projectTable.reloadData()
        })
    }
    
    dynamic private func skillsFinished(notification: NSNotification){
        //Action take on Notification
        UserController.getUsersProjects(curUsr!, callback: { (project) -> Void in
            print(project)
            
            self.usrProjects = project as? [Project]
            self._projectTable.reloadData()
        })
    }
    
    // MARK: - Data source methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(usrProjects == nil) {
            return 0
        }
        
        return usrProjects!.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("projectCell", forIndexPath: indexPath) as! CustomProjectTableViewCell
        
        if(usrProjects != nil) {
            cell.setUpCell(usrProjects![indexPath.item])
        }
        
        return cell
    }
    
    func logOutUser() {
        performSegueWithIdentifier("logoutSegue", sender: self)
    }


}
