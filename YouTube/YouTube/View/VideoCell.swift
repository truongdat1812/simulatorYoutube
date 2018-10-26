//
//  VideoCell.swift
//  YouTube
//
//  Created by Truong Khac Dat on 9/19/18.
//  Copyright © 2018 Truong Khac Dat. All rights reserved.
//

import UIKit

class VideoCell: BaseCollectionViewCell {
    
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            
            setupProfileImage()
            
            setupImageThumbnail()
    
            if let subtitle = video?.channel?.name, let numberOfView = video?.number_of_views {
                let numberFormat = NumberFormatter()
                numberFormat.numberStyle = .decimal
                subtitleTexeView.text = "\(subtitle) ◉ \(numberOfView) ◉ 2 years ago"
            }
            
            //mesure the title tiext
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 100)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimatedRect.height > 20 {
                    titleHeightContraint?.constant = 44
                }else{
                    titleHeightContraint?.constant = 20
                }
            }
        }
    }
    
    func setupImageThumbnail() {
        if let thumbnailImageName = video?.thumbnail_image_name {
            self.thumbnailView.loadImageUsingUrlString(urlString: thumbnailImageName)
        }
    }
    
    func setupProfileImage() {
        if let profileImageUrl = video?.channel?.profile_image_name {
            self.userProfileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
        }
    }
    
    let thumbnailView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "fconrad_Portrait_060414a")
        return imageView
        }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "fconrad_Portrait_060414a")
        imageView.backgroundColor = .green
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
       return view
    }()
    
    let titleLabel: UILabel = {
       let label = UILabel()
//        label.backgroundColor = UIColor.purple
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title Taylor Swift - Blank space"
        label.numberOfLines = 2
        return label
    }()
    
    let subtitleTexeView: UITextView = {
        let textView = UITextView()
//        textView.backgroundColor = .red
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Taylor Swift - 1.00000055 Views - 2 years"
        textView.textColor = .lightGray
//        textView.textContainerInset = UIEdgeInsetsMake(0, 0, -4, 0)
        textView.backgroundColor = .clear
        return textView
    }()
    
    var titleHeightContraint: NSLayoutConstraint?
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(thumbnailView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTexeView)
        
//        let contraints = [
//            thumbnailView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
//            thumbnailView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
//            thumbnailView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
//            thumbnailView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
//        ]
//
//        NSLayoutConstraint.activate(contraints)
        
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": thumbnailView]))
         addContraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailView)
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-16-[v1(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": thumbnailView, "v1":separatorView]))
         addContraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-30-[v2(1)]|", views: thumbnailView,userProfileImageView, separatorView)
        
        addContraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": separatorView]))
        addContraintsWithFormat(format: "H:|[v0]|", views: separatorView)
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(0.5)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": separatorView]))
        
        //top contrains
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailView, attribute: .bottom, multiplier: 1, constant: 8))
        //left contraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right contraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailView, attribute: .right, multiplier: 1, constant: 0))
        
        //height contraints
        titleHeightContraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(titleHeightContraint!)
        
//        addContraintsWithFormat(format: "V:[v0(20)]", views: titleLabel)
//        addContraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
        
        addConstraint(NSLayoutConstraint(item: subtitleTexeView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: -8))
        addConstraint(NSLayoutConstraint(item: subtitleTexeView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: subtitleTexeView, attribute: .right, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: subtitleTexeView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 38))
    }
}
