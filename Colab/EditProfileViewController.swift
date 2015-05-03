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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        var params = [String:AnyObject]()
        params["user"] = user.serialize()
        
        QueryManager.sharedInstance.POST(params, url: Constants.URLsuffix.updateUserInfo) { (responseObject) -> Void in
            print(responseObject)
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
