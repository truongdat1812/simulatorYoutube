//
//  BarMenuCell.swift
//  YouTube
//
//  Created by Truong Khac Dat on 9/22/18.
//  Copyright © 2018 Truong Khac Dat. All rights reserved.
//

import UIKit

class BarMenuCell: BaseCollectionViewCell {    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Home")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.rgba(91, 14, 13, 1)
        return iv;
    }()
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? .white : UIColor.rgba(91, 14, 13, 1)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            print("123")
            imageView.tintColor = isSelected ? .white : UIColor.rgba(91, 14, 13, 1)
        }
    }
    
    override func setupViews() {
        super.setupViews()

        addSubview(imageView)
        
        addContraintsWithFormat(format: "H:[v0(28)]", views: imageView)
        addContraintsWithFormat(format: "V:[v0(28)]", views: imageView)
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
