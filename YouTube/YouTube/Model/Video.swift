//
//  File.swift
//  YouTube
//
//  Created by Truong Khac Dat on 9/23/18.
//  Copyright © 2018 Truong Khac Dat. All rights reserved.
//

import UIKit

class Video: NSObject {
    var title: String?
    var number_of_views: NSNumber?
    var thumbnail_image_name: String?
    var channel: Channel?
    var duration: NSNumber?
//    var uploadDate: NSDate?
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    
    func setMultiTypeValuesForkeys(_ dictionay: [String: AnyObject]){
        self.title = dictionay["title"] as? String
        self.thumbnail_image_name = dictionay["thumbnail_image_name"] as? String
        self.number_of_views = dictionay["number_of_views"] as? NSNumber
        self.duration = dictionay["duration"] as? NSNumber
        
        let chanelDict = dictionay["channel"] as! [String: AnyObject]
        let channel = Channel()
        //                        channel.setValuesForKeys(chanelDict)
        channel.name = chanelDict["name"] as? String
        channel.profile_image_name = chanelDict["profile_image_name"] as? String
        self.channel = channel;
    }
    
    init(dictionay: [String: AnyObject]) {
        super.init()
        setMultiTypeValuesForkeys(dictionay)
    }
}

class Channel: NSObject {
    var name: String?
    var profile_image_name: String?
}


