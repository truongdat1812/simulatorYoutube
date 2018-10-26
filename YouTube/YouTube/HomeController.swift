//
//  ViewController.swift
//  YouTube
//
//  Created by Truong Khac Dat on 9/19/18.
//  Copyright © 2018 Truong Khac Dat. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

//    let videos: [Video] = {
//        let kajayChannel = Channel()
//        kajayChannel.name = "Kayac canel"
//        kajayChannel.profileImageName = "fconrad_Portrait_060414a"
//
//        let kajayChannel2 = Channel()
//        kajayChannel2.name = "Kayac canel is the best in the world!"
//        kajayChannel2.profileImageName = "IMG_0311"
//
//        let vd = Video()
//        vd.title = "Taylor Swift - Balnk spase"
//        vd.thumbnailImageName = "fconrad_Portrait_060414a"
//        vd.channel = kajayChannel
//        vd.numberOfView = 23217216
//
//        let badfloodVideo = Video()
//        badfloodVideo.title = "Taylor Swift - back fllood trading blanmark lemar king home"
//        badfloodVideo.thumbnailImageName = "IMG_0311"
//        badfloodVideo.channel = kajayChannel2
//        badfloodVideo.numberOfView = 9829380
//
//        return [vd, badfloodVideo]
//    }()
    
    let cellId = "CellId"
    let trendingCellId = "trendingCellId"
    let subscriptionCellId = "SubscriptionCellId"
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "   Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        return titleLabel;
    }()
    
    lazy var settingLauncher: SettingLauncher = {
        let launcher = SettingLauncher()
        launcher.homeViewController = self
       return launcher
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        titleLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        navigationItem.titleView = titleLabel

        setupCollectionView()
        
        setupMenuBar()
        setupNavButton()
    }

    func setupCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView?.backgroundColor = .white
//        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "CellId")
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        collectionView?.isPagingEnabled = true
    }
    func setupNavButton(){
        let searchBarImage = UIImage(named: "icons8-search-32")?.withRenderingMode(.alwaysOriginal)
        let searchBarItem = UIBarButtonItem(image: searchBarImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreBarItem = UIBarButtonItem(image: UIImage(named: "icons8-more-filled-50")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreBarItem, searchBarItem]
        
    }
    
    @objc func handleMore(){
        print("Handlesearch")
        settingLauncher.ShowSetting()
    }
    
    @objc func handleSearch(){
        print("Handlesearch")
    }
    
    let titles = ["Home", "Trending", "Subscription", "Account"]
    private func setTitleForIndex(_ index: Int){
        titleLabel.text = "    \(titles[Int(index)])"
    }
    func scrollTomenuIndex(_ menuIndex: Int){
        let indexPath = IndexPath(item: menuIndex, section: 0)
        
        setTitleForIndex(menuIndex)
        collectionView?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: true)
    }
    func showSettingController(_ setting:Setting) {
        if setting.name == .Cancel {
            return
        }
        let dummyViewControler = UIViewController()
        dummyViewControler.navigationItem.title = setting.name.rawValue
        dummyViewControler.view.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationItem.leftBarButtonItem?.titleTextAttributes(for: UIControlState.normal)
        navigationController?.pushViewController(dummyViewControler, animated: true)
    }
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    func setupMenuBar() {
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgba(230, 32, 31, 1)
        view.addSubview(redView)

        view.addSubview(menuBar)
        
        view.addContraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addContraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addContraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addContraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        view.addConstraint(NSLayoutConstraint(item: menuBar, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset.x)
        menuBar.leftAnchorBarContraint?.constant = scrollView.contentOffset.x/4
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        print(targetContentOffset.move().x)
        
        let index = targetContentOffset.move().x/self.view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        
        setTitleForIndex(Int(index))
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.left)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier: String
        if indexPath.item == 1 {
            identifier = trendingCellId
        }else if indexPath.item == 2 {
            identifier = subscriptionCellId
        }else{
            identifier = cellId
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height - menuBar.frame.height)
    }
}

