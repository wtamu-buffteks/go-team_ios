//
//  CalendarTableViewCell.swift
//  GoTeam
//
//  Created by Brett Ponder on 2/24/17.
//  Copyright © 2017 BuffTeks. All rights reserved.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
