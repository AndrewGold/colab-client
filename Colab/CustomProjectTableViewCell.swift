//
//  CustomProjectTableViewCell.swift
//  Colab
//
//  Created by Matthew Fishkin on 5/9/15.
//  Copyright (c) 2015 goldreddyfishkin. All rights reserved.
//

import UIKit

class CustomProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var _projectName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(proj:Project!) {
        _projectName.text = proj._title
    }

}
