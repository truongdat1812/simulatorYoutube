//
//  MenuBar.swift
//  YouTube
//
//  Created by Truong Khac Dat on 9/20/18.
//  Copyright © 2018 Truong Khac Dat. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let imageNames = ["Home", "fire", "briefcase", "user"]

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgba(230, 32, 31, 1)
        cv.delegate = self
        cv.dataSource = self
        
        return cv;
    }()
    
    var homeController: HomeController?
    var leftAnchorBarContraint:NSLayoutConstraint?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(BarMenuCell.self, forCellWithReuseIdentifier: "BarCellId")
        addSubview(collectionView)
        addContraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addContraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition.right)
        
        setupHorizonBar()
    }
    
    func setupHorizonBar() {
        let horizonbarView = UIView()
        horizonbarView.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        addSubview(horizonbarView)
        horizonbarView.translatesAutoresizingMaskIntoConstraints = false
        //Old school way to do
//        horizonbarView.frame = CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        
        //new school eay of laying out our view
        //in iOS9 and above
        //need x, y, width height contraints
        leftAnchorBarContraint = horizonbarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        leftAnchorBarContraint?.isActive = true
        
        horizonbarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizonbarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        horizonbarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        
        //Remove it because already on didScroll
//        let x = CGFloat(indexPath.item) * frame.width/4
//        leftAnchorBarContraint?.constant = x
//
//        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
//            self.layoutIfNeeded()
//        }, completion: nil)
        
        homeController?.scrollTomenuIndex(indexPath.item)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BarCellId", for: indexPath) as! BarMenuCell
        
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
//        cell.imageView.tintColor = UIColor.rgba(91, 14, 13, 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width/4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
