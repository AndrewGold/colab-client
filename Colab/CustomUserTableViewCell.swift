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
        
        let maxIndex = min(3, usr._skills!.count)
        var curSkillIndex = 0
        for(var i = 0; i < maxIndex; i++) {
            SkillController.getSkill(usr._skills![i]._title, callback: { (skillName) -> Void in
                if (curSkillIndex == 0) {
                    self._userSkill1.text = skillName
                    self._userSkill1.hidden = false
                    curSkillIndex++
                } else if (curSkillIndex == 1) {
                    self._userSkill2.text = skillName
                    self._userSkill2.hidden = false
                    curSkillIndex++
                } else {
                    self._userSkill3.text = skillName
                    self._userSkill3.hidden = false
                    curSkillIndex = 0
                }
            })
        }
        
        _userId = usr._id
    }
    
}
