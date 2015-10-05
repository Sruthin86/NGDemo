//
//  pastGoalsTableViewCell.swift
//  Nail Goals
//
//  Created by Sparty on 5/27/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import UIKit

class pastGoalsTableViewCell: UITableViewCell {

    @IBOutlet var startDateLabel: UILabel!
    
    @IBOutlet var endDateLabel: UILabel!
    
    @IBOutlet var daysAgoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
