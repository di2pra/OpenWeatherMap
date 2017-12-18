//
//  ForecastView.swift
//  OpenWeatherMap
//
//  Created by Pradheep Rajendirane on 12/12/2017.
//  Copyright © 2017 Pradheep Rajendirane. All rights reserved.
//

import UIKit

fileprivate let padding: CGFloat = 2.5
fileprivate let iconeSize: CGFloat = 30

class ForecastView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(frame: CGRect, hour: String) {
        
        self.init(frame: frame)
        self.setup(hour: hour)
        //self.backgroundColor = .red
    }
    
    func setup(hour: String) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let hourLabel = UILabel(frame: .zero)
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        hourLabel.text = hour
        hourLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(hourLabel)
        
        self.addConstraints([
            NSLayoutConstraint(item: hourLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            /*NSLayoutConstraint(item: hourLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: padding),
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: hourLabel, attribute: .trailing, multiplier: 1, constant: padding),*/
            NSLayoutConstraint(item: hourLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            /*NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: hourLabel, attribute: .bottom, multiplier: 1, constant: padding),*/
            ])
        
        
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "01d")
        //imageView.backgroundColor = .red
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        self.addSubview(imageView)
        
        self.addConstraints([
            NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: hourLabel, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: iconeSize),
            NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: iconeSize),
            /*NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: padding),
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: imageView, attribute: .trailing, multiplier: 1, constant: padding),*/
            NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: padding)
            ])
        
        
        let tempLabel = UILabel(frame: .zero)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.text = "21°C"
        tempLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(tempLabel)
        
        self.addConstraints([
            NSLayoutConstraint(item: tempLabel, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: padding),
            NSLayoutConstraint(item: tempLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            /*NSLayoutConstraint(item: hourLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: padding),
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: hourLabel, attribute: .trailing, multiplier: 1, constant: padding),
            NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: tempLabel, attribute: .bottom, multiplier: 1, constant: padding)*/
            ])
        
        
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
