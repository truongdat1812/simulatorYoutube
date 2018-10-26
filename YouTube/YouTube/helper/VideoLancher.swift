//
//  VideoLancher.swift
//  YouTube
//
//  Created by Truong Khac Dat on 10/24/18.
//  Copyright © 2018 Truong Khac Dat. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        return indicator
    }()
    let controlsContainerView: UIView = {
        let uiview = UIView()
        uiview.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return uiview;
    }()
    
    lazy var pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        //▶︎
        button.setTitle("⏏︎", for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return button
    }()
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let videoSlider: UISlider = {
        let sd = UISlider()
        sd.translatesAutoresizingMaskIntoConstraints = false
        sd.minimumTrackTintColor = .red
        sd.maximumTrackTintColor = .white
//        sd.setThumbImage(UIImage(named: ""), for: UIControlState.normal)
        sd.addTarget(self, action: #selector(handleSliderChanged), for: UIControl.Event.valueChanged)
        return sd
    }()
    
    @objc func handleSliderChanged(){
        
        
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let value = Float64(videoSlider.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            
            player?.seek(to: seekTime, completionHandler: { (completedSeek) in
                
            })
        }

    }
    var isPlaying = false
    @objc func handlePause(){
        if isPlaying {
            player?.pause()
            pausePlayButton.setTitle("▶︎", for: UIControlState.normal)
        }else{
            pausePlayButton.setTitle("⏏︎", for: UIControlState.normal)
            player?.play()
        }
        isPlaying = !isPlaying
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayerView()
        controlsContainerView.frame = frame
        controlsContainerView.addSubview(activityIndicatorView)
        controlsContainerView.addSubview(pausePlayButton)

        addContraintsWithFormat(format: "H:|[v0]|", views: pausePlayButton)
        addContraintsWithFormat(format: "V:|[v0]|", views: pausePlayButton)

        addContraintsWithFormat(format: "H:|[v0]|", views: activityIndicatorView)
        addContraintsWithFormat(format: "V:|[v0]|", views: activityIndicatorView)
        
        addSubview(controlsContainerView)
        backgroundColor = .black
        
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 64).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(videoSlider)
        videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor, constant: 0).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: leftAnchor, constant: 0 ).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    var player:AVPlayer?
    private func setupLayerView(){
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        if let url = NSURL(string: urlString) {
            player = AVPlayer(url: url as URL)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new
                , context: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pausePlayButton.isHidden = false
            isPlaying = true
            
            if let duration = player?.currentItem?.duration {
                let seconds = (integer_t)(CMTimeGetSeconds(duration))
                
                let secondsText = seconds % 60
                let minutsTxt = String(format: "%02d", secondsText / 60)
                videoLengthLabel.text = "\(minutsTxt):\(secondsText)"
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
class VideoLancher: NSObject {
    func showVideoPlayer() {
        let keyWindow = UIApplication.shared.keyWindow
        let view = UIView(frame: keyWindow?.frame ?? .zero)
        view.backgroundColor = .white
        
        view.frame = CGRect(x: keyWindow?.frame.width ?? 0 - 10, y: keyWindow?.frame.height ?? 0 - 10, width: 10, height: 10)
        
        keyWindow?.addSubview(view)
        
        //16x9 is the aspect ratio of all HD video
        let height = (keyWindow?.frame.width ?? 0) * (9 / 16)
        let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow?.frame.width ?? 0, height: height)
        let videoPlayerView = VideoPlayerView (frame: videoPlayerFrame)
        view.addSubview(videoPlayerView)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut
            , animations: {
                view.frame = keyWindow?.frame ?? .zero
        }) { (completed) in
            //Todo
            UIApplication.shared.isStatusBarHidden = true
        }
    }
}
