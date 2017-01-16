//
//  SystemsTableViewCell.swift
//  MindHack
//
//  Created by Bryan Ye on 16/1/17.
//  Copyright © 2017 Bryan Ye. All rights reserved.
//

import UIKit

class SystemsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var triggerLabel: UILabel!
    
    @IBOutlet weak var routineLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
