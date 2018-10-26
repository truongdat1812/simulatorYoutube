//
//  SettingLauncher.swift
//  YouTube
//
//  Created by Truong Khac Dat on 9/27/18.
//  Copyright © 2018 Truong Khac Dat. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: SettingName
    let imageName: String
    
    init(name: SettingName, imageName: String){
        self.imageName = imageName
        self.name = name
    }
}

enum SettingName: String{
    case Cancel = "✘  Cancel and Dissmiss"
    case Setting = "⚙︎  Setting"
    case Term = "❦  Terms and privacy policy"
    case Feedback = "☂︎  Send feedback"
    case Help = "☹︎  Help"
    case SwitchAccount = "☠︎  Switch Account"
}
class SettingLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView .register(SettingCell.self, forCellWithReuseIdentifier: "SeetingId")
        //
    }
    
    var homeViewController: HomeController?
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let cellheight: CGFloat = 50
    
    let blackView = UIView()
    
    let settings: [Setting] = {
        let setting = Setting(name: .Setting, imageName: "")
        let term = Setting(name: .Term, imageName: "")
        let feedback = Setting(name: .Feedback, imageName: "")
        let help = Setting(name: .Help, imageName: "")
        let swithAccount = Setting(name: .SwitchAccount, imageName: "")
        let exit = Setting(name: .Cancel, imageName: "")
        
        return [setting, term, feedback, help, swithAccount, exit]
    }()
    
    @objc func handleDismiss(){
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: self.collectionView.frame.height)
            }
        }
    }
    
    func ShowSetting(){
        print("handleMore")
        if let window = UIApplication.shared.keyWindow{
            
            blackView.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let height: CGFloat = CGFloat(settings.count) * cellheight
            let y = window.frame.height - height
            
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: collectionView.frame.width, height: cellheight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeetingId", for: indexPath) as! SettingCell
//        cell.backgroundColor = .red
        cell.setting = settings[indexPath.item]
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = settings[indexPath.row]
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: self.collectionView.frame.height)
            }
        }) { (completed) in
            print("Animation competed")
            self.homeViewController?.showSettingController(setting)
        }
    }
}
