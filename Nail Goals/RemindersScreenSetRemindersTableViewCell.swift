//
//  RemindersScreenSetRemindersTableViewCell.swift
//  Nail Goals
//
//  Created by Sparty on 5/3/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import UIKit

class RemindersScreenSetRemindersTableViewCell: UITableViewCell {

    
    @IBOutlet var tapToselect: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        tapToselect.enabled = false;
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
