//
//  ForecastCell.swift
//  OpenWeatherMap
//
//  Created by Pradheep Rajendirane on 16/12/2017.
//  Copyright © 2017 Pradheep Rajendirane. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    fileprivate let cornerRadius: CGFloat = 10
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        containerView.layer.cornerRadius = cornerRadius
        containerView.backgroundColor = .white
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 2, height: 2)
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowRadius = 5
        
        dateLabel.textColor = mainColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
