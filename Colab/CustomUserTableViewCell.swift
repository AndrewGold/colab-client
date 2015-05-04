//
//  CustomUserTableViewCell.swift
//  Co-Llab
//
//  Created by Matthew Fishkin on 3/15/15.
//  Copyright (c) 2015 Fishkin. All rights reserved.
//

import UIKit

class CustomUserTableViewCell: UITableViewCell {

    @IBOutlet weak var _userImage: UIImageView!
    @IBOutlet weak var _userName: UILabel!
    @IBOutlet weak var _userTagline: UILabel!
    @IBOutlet weak var _userScore: UILabel!

    
    @IBOutlet weak var _userSkill1: UILabel!
    @IBOutlet weak var _userSkill2: UILabel!
    @IBOutlet weak var _userSkill3: UILabel!
    
    var _userId:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func setUpCell(usr:User!)
    {
        
        _userImage.image = UIImage(named: "placeholder.png")
        _userName.text = usr._firstName! + " " + usr._lastName!
        _userTagline.text = usr._tagline!
        _userScore.text = "99"
        
        _userSkill1.text = "default"
        _userSkill2.text = "default"
        _userSkill3.text = "default"
        
        _userId = usr._id
    }

}
