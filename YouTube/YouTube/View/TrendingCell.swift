//
//  TrendingCell.swift
//  YouTube
//
//  Created by Truong Khac Dat on 10/18/18.
//  Copyright © 2018 Truong Khac Dat. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    override func fetchVideos() {
        APIService.shareInstance.fetchTrendingVideos { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
