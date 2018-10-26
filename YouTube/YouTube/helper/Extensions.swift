//
//  Extensions.swift
//  YouTube
//
//  Created by Truong Khac Dat on 9/21/18.
//  Copyright © 2018 Truong Khac Dat. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgba(_ red: CGFloat,_ green: CGFloat,_ blue: CGFloat,_ alpha: CGFloat) -> UIColor{
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255, alpha: alpha)
    }
}

extension UIView{
    func addContraintsWithFormat(format: String, views: UIView...) {
        var dictionaryView = [String: UIView]()
        
        for (index, view) in views.enumerated(){
            view.translatesAutoresizingMaskIntoConstraints = false
            let key = "v\(index)"
            dictionaryView[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: dictionaryView))
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String){
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject)  as? UIImage{
            DispatchQueue.main.async {
                self.image = imageFromCache
                return
            }
        }
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return;
            }
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString{
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
            }
        }.resume()
    }
}

class Extensions: NSObject {

}
