//
//  BaseCollectionViewCell.swift
//  YouTube
//
//  Created by Truong Khac Dat on 9/22/18.
//  Copyright © 2018 Truong Khac Dat. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews() {
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
