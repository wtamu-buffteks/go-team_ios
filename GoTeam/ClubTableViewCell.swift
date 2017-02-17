//
//  ClubTableViewCell.swift
//  GoTeam
//
//  Created by Brett Ponder on 12/2/16.
//  Copyright © 2016 BuffTeks. All rights reserved.
//

import UIKit

class ClubTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var clubNameLabel: UILabel!
    @IBOutlet weak var gradientBackgroundView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        createGradientLayer()
        self.logoImageView.layer.borderWidth = 2.0
        self.logoImageView.layer.borderColor = UIColor.white.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func createGradientLayer() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 1000, height: self.gradientBackgroundView.frame.size.height)
        
        let colorTop = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.0).cgColor
        let colorBottom = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        
        gradientLayer.colors = [colorTop, colorBottom]
        
        self.gradientBackgroundView.layer.insertSublayer(gradientLayer, at: 0)
    }

}
