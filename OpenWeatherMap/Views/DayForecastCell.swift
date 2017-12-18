//
//  DayForecastCell.swift
//  OpenWeatherMap
//
//  Created by Pradheep Rajendirane on 12/12/2017.
//  Copyright © 2017 Pradheep Rajendirane. All rights reserved.
//

import UIKit

fileprivate let cornerRadius: CGFloat = 5

class DayForecastCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContainerView: UIStackView!
    
    /*@IBOutlet var collapsedConstraint: NSLayoutConstraint!
    @IBOutlet var expandedConstraint: NSLayoutConstraint!*/
    
    /*var isCollapsed:Bool = true {
        didSet {
            if isCollapsed {
                scrollViewHeight.constant = 0
            } else {
                scrollViewHeight.constant = 80
            }
        }
    }*/

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        containerView.layer.cornerRadius = cornerRadius
        containerView.backgroundColor = .white
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 2, height: 2)
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowRadius = 5
        
        scrollView.clipsToBounds = true
        
        
        let view = ForecastView(frame: .zero, hour: "08:00")
        scrollContainerView.addArrangedSubview(view)
        
        let view1 = ForecastView(frame: .zero, hour: "09:00")
        scrollContainerView.addArrangedSubview(view1)
        
        let view2 = ForecastView(frame: .zero, hour: "10:00")
        scrollContainerView.addArrangedSubview(view2)
        
        let view3 = ForecastView(frame: .zero, hour: "11:00")
        scrollContainerView.addArrangedSubview(view3)
        
        let view4 = ForecastView(frame: .zero, hour: "12:00")
        scrollContainerView.addArrangedSubview(view4)
        
        let view5 = ForecastView(frame: .zero, hour: "13:00")
        scrollContainerView.addArrangedSubview(view5)
        
        let view6 = ForecastView(frame: .zero, hour: "14:00")
        scrollContainerView.addArrangedSubview(view6)
        
        let view7 = ForecastView(frame: .zero, hour: "15:00")
        scrollContainerView.addArrangedSubview(view7)
        
        let view8 = ForecastView(frame: .zero, hour: "16:00")
        scrollContainerView.addArrangedSubview(view8)
        
        /*self.collapsedConstraint.isActive = true
        self.expandedConstraint.isActive = false
        self.scrollView.isHidden = true*/
        
    }
    
    /*func expandCell() {
        if isCollapsed {
            collapsedConstraint.isActive = !collapsedConstraint.isActive
            expandedConstraint.isActive = !expandedConstraint.isActive
            self.scrollView.alpha = 0.0
            self.scrollView.isHidden = !self.scrollView.isHidden
            self.isCollapsed = false
        }
    }
    
    func collapse() {
        if !isCollapsed {
            collapsedConstraint.isActive = !collapsedConstraint.isActive
            expandedConstraint.isActive = !expandedConstraint.isActive
            self.scrollView.isHidden = !self.scrollView.isHidden
            self.isCollapsed = true
        }
    }*/

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
