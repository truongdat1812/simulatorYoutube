//
//  SettingCell.swift
//  YouTube
//
//  Created by Truong Khac Dat on 9/28/18.
//  Copyright © 2018 Truong Khac Dat. All rights reserved.
//

import UIKit

class SettingCell: BaseCollectionViewCell {
    
    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.darkText
        }
    }
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "♽ Setting"
        return lb
    }()
    
    var setting: Setting? {
        didSet{
            nameLabel.text = setting?.name.rawValue
        }
    }
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)

        addContraintsWithFormat(format: "H:|-10-[v0]|", views: nameLabel)
        addContraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
    }
}
