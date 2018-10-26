//
//  FeedCell.swift
//  YouTube
//
//  Created by Truong Khac Dat on 10/17/18.
//  Copyright © 2018 Truong Khac Dat. All rights reserved.
//

import UIKit

class FeedCell: BaseCollectionViewCell, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
       let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    var videos: [Video]?
    
    let cellId = "VideoCellId"
    override func setupViews() {
        super.setupViews()
        
        fetchVideos()
        
        addSubview(collectionView)
        addContraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addContraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func fetchVideos() {
        APIService.shareInstance.fetchVideos { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let count = videos?.count {
//            return count
//        }
//
//        return 0
        return videos?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell

        if let video = videos?[indexPath.item] {
            cell.video = video
        }

        return cell;
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 270)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoLancher = VideoLancher()
        videoLancher.showVideoPlayer()
    }
}
