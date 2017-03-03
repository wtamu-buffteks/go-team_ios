//
//  MemberTableViewCell.swift
//  GoTeam
//
//  Created by Brett Ponder on 3/3/17.
//  Copyright © 2017 BuffTeks. All rights reserved.
//

import UIKit
import Parse

class MemberTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.profilePicImageView.layer.cornerRadius = 25.0
    }
    
    func setImage(object: PFObject) {
        if let imageFile = object[ParseConstants.User.Picture] as? PFFile {
            imageFile.getDataInBackground(block: { (data: Data?, error: Error?) in
                self.profilePicImageView.image = UIImage(data: data!)
            })
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
