//
//  APIService.swift
//  YouTube
//
//  Created by Truong Khac Dat on 10/12/18.
//  Copyright © 2018 Truong Khac Dat. All rights reserved.
//

import UIKit

class APIService: NSObject {
    static let shareInstance = APIService()
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        fetchVideosForUrl("\(baseUrl)/home.json") { (videos: [Video]) in
            completion(videos)
        }
    }
    
    func fetchTrendingVideos(completion: @escaping ([Video]) -> ()) {
        fetchVideosForUrl("\(baseUrl)/trending.json") { (videos: [Video]) in
            completion(videos)
        }
    }
    
    func fetchSubscriptionVideos(completion: @escaping ([Video]) -> ()) {
        fetchVideosForUrl("\(baseUrl)/subscriptions.json") { (videos: [Video]) in
            completion(videos)
        }
    }
    
    func fetchVideosForUrl(_ urlString: String, completion: @escaping ([Video]) -> ()){
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print(error ?? "erorr dataTask")
                    return
                }
                
                do{
                    if let unwrappedData = data, let jsonDictionaries = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as? [[String: AnyObject]] {
//                        let videos = jsonDictionaries.map({return Video(dictionay: $0)})
//                        var videos = [Video] ()
//                        for dictionay in jsonDictionaries {
//                            let video = Video(dictionay: dictionay)
//                            videos.append(video)
//                        }
                        
//                        jsonDictionaries.map({ (dict:[String : AnyObject]) -> Video in
//                            return Video(dictionay: dict)
//                        })
                        
                        completion(jsonDictionaries.map({return Video(dictionay: $0)}))
                    }
                }catch let jsonError{
                    print(jsonError)
                }
            }
            }.resume()
    }
}

//let json = try JSONSerialization.jsonObject(with: data!, options: [])
//
//var videos = [Video] ()
//
//for dictionay in json as! [[String: AnyObject]] {
//    let video = Video()
//    video.title = dictionay["title"] as? String
//    video.thumbnailImageName = dictionay["thumbnail_image_name"] as? String
//
//    let chanelDict = dictionay["channel"] as! [String: AnyObject]
//    let channel = Channel()
//    channel.name = chanelDict["name"] as? String
//    channel.profileImageName = chanelDict["profile_image_name"] as? String
//    video.channel = channel;
//
//    videos.append(video)
//}
//
//completion(videos)
