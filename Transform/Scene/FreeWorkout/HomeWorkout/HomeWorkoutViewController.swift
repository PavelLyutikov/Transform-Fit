//
//  TransformViewController.swift
//  Transform
//
//  Created by Nikita Malevich on 9/23/20.
//

import UIKit
import AVKit
import SnapKit
//import CachingPlayerItem

class HomeWorkoutViewController: UIViewController {
        
    let totalSize = UIScreen.main.bounds.size
    
    @IBOutlet weak var homeWorkoutLabel1: UILabel!
    @IBOutlet weak var homeWorkoutLabel2: UILabel!
    @IBOutlet weak var homeWorkoutLabel3: UILabel!
    @IBOutlet weak var homeWorkoutLabel4: UILabel!
    @IBOutlet weak var homeWorkoutVideoPlayer: VideoPlayer!
    
    var homeWorkout: HomeWorkout?
    var activityIndicator = UIActivityIndicatorView()

    //ironSource
    var bannerView: ISBannerView! = nil
    let kAPPKEY = "11dfcc91d"
    var integ = UserDefaults.standard.integer(forKey: "interstitialHomeWorkout")
    
//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        
        setupBackground()
        
        guard let homeWorkout = homeWorkout else { return }

        
        let fontSize: CGFloat!
        let positLb1: CGFloat!
        if totalSize.height >= 920 {
            fontSize = 25
            positLb1 = 100
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 24
            positLb1 = 100
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 23
            positLb1 = 95
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 22
            positLb1 = 60
        } else if totalSize.height <= 670 {
            fontSize = 22
            positLb1 = 55
        } else {
            fontSize = 22
            positLb1 = 75
        }
        
        homeWorkoutLabel1.text = homeWorkout.text1
        homeWorkoutLabel1.textColor = .white
        homeWorkoutLabel1.layer.zPosition = 3
        homeWorkoutLabel1.font = UIFont.systemFont(ofSize: fontSize)
        homeWorkoutLabel1.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        homeWorkoutLabel1.layer.shadowRadius = 5
        homeWorkoutLabel1.layer.shadowOffset = CGSize(width: 0, height: 0)
        homeWorkoutLabel1.layer.shadowOpacity = 0.3
        
        homeWorkoutLabel1.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positLb1)
        }
        
        let fontSize2: CGFloat!
        if totalSize.height >= 830 {
            fontSize2 = 18
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize2 = 18
        } else if totalSize.height <= 670 {
            fontSize2 = 17
        } else {
            fontSize2 = 17
        }
        homeWorkoutLabel2.text = homeWorkout.text2
        homeWorkoutLabel2.textColor = .white
        homeWorkoutLabel2.layer.zPosition = 3
        homeWorkoutLabel2.font = UIFont.systemFont(ofSize: fontSize2)
        homeWorkoutLabel2.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        homeWorkoutLabel2.layer.shadowRadius = 5
        homeWorkoutLabel2.layer.shadowOffset = CGSize(width: 0, height: 0)
        homeWorkoutLabel2.layer.shadowOpacity = 0.3
        
        let fontSizeLb3: CGFloat!
        if totalSize.height >= 890 {
            fontSizeLb3 = 20
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSizeLb3 = 19
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSizeLb3 = 19
        } else if totalSize.height <= 670 {
            fontSizeLb3 = 18
        } else {
            fontSizeLb3 = 19
        }
        homeWorkoutLabel3.text = homeWorkout.text3
        homeWorkoutLabel3.textColor = .white
        homeWorkoutLabel3.layer.zPosition = 9
        homeWorkoutLabel3.isHidden = true
        homeWorkoutLabel3.font = UIFont.systemFont(ofSize: fontSizeLb3)
        homeWorkoutLabel3.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        homeWorkoutLabel3.layer.shadowRadius = 5
        homeWorkoutLabel3.layer.shadowOffset = CGSize(width: 0, height: 0)
        homeWorkoutLabel3.layer.shadowOpacity = 0.3
        
        homeWorkoutLabel3.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(40)
            make.trailing.equalToSuperview().inset(40)
        }
        
        
        let positBttm: CGFloat!
        if totalSize.height >= 920 {
            positBttm = 29
        } else if totalSize.height >= 830  && totalSize.height <= 919 {
            positBttm = 30
        } else if totalSize.height == 812 {
            positBttm = 25
        } else if totalSize.height <= 800 {
            positBttm = 15
        } else {
            positBttm = 15
        }
        homeWorkoutLabel4.text = homeWorkout.text4
        homeWorkoutLabel4.textColor = .white
        homeWorkoutLabel4.layer.zPosition = 7
        homeWorkoutLabel4.textAlignment = .center
        homeWorkoutLabel4.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        homeWorkoutLabel4.layer.shadowRadius = 5
        homeWorkoutLabel4.layer.shadowOffset = CGSize(width: 0, height: 0)
        homeWorkoutLabel4.layer.shadowOpacity = 0.3
        
        homeWorkoutLabel4.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(positBttm)
            make.centerX.equalToSuperview()
        }
        
        imageVideoBackground.isHidden = false
        
        let positBttmVP: CGFloat!
        let lead: CGFloat!
        if totalSize.height >= 920 {
            positBttmVP = 620
            lead = -10
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positBttmVP = 540
            lead = 20
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positBttmVP = 530
            lead = 0
        } else if totalSize.height == 812 {
            positBttmVP = 500
            lead = -5
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positBttmVP = 740
            lead = -22
        } else if totalSize.height <= 670 {
            positBttmVP = 690
            lead = -22
        } else {
            positBttmVP = 550
            lead = -15
        }

        homeWorkoutVideoPlayer.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(positBttmVP)
            make.leading.equalToSuperview().inset(lead)
        }
        
        dismissButton.addTarget(self, action: #selector(buttonDismiss), for: .touchUpInside)
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            self.nextWorkoutButton.addTarget(self, action: #selector(self.nextWorkoutButtonAction(sender:)), for: .touchUpInside)
            self.nextWorkoutButton.alpha()
            self.backWorkoutButton.addTarget(self, action: #selector(self.backWorkoutButtonAction(sender:)), for: .touchUpInside)
            self.backWorkoutButton.alpha()
        }
        
        guard let videoUrl = URL(string: homeWorkout.video) else { return }
        
        URLSession.shared.dataTask(with: videoUrl) { [weak self] (data, response, error) in
            guard let data = data else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.homeWorkoutVideoPlayer.playVideoWithData(data: data)
            }
        }.resume()
        
        setupActivityIndicator()
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        infoButton.addTarget(self, action: #selector(buttonInfoAction(sender:)), for: .touchUpInside)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(HomeWorkoutViewController.videoReady), name: NSNotification.Name(rawValue: "videoReadyWorkout"), object: nil)
        
        //Ads
        if !UserDefaults.standard.bool(forKey: "removeAdsPurchased") {
            setupIronSourceSdk()
            loadBanner()
            loadInterstitial()
        
        
            //SpawnInterstitial
            if integ >= 5 {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    
                    IronSource.showInterstitial(with: self)
                    
                    self.integ = 0
                    
                    UserDefaults.standard.set(self.integ, forKey: "interstitialHomeWorkout")
                }
            } else {
                integ += 1
                UserDefaults.standard.set(integ, forKey: "interstitialHomeWorkout")
            }
        }
    }
//MARK: - VideoPlayer
    func playVideoWithPlayer(_ player: AVPlayer) {
        player.play()
    }
    
    func playVideoWithPlayer(_ player: AVPlayer, video:AVURLAsset, filterName:String) {
        
        let  avPlayerItem = AVPlayerItem(asset: video)
        
        if (filterName != "NoFilter") {
            let avVideoComposition = AVVideoComposition(asset: video, applyingCIFiltersWithHandler: { request in
                let source = request.sourceImage.clampedToExtent()
                let filter = CIFilter(name:filterName)!
                filter.setDefaults()
                filter.setValue(source, forKey: kCIInputImageKey)
                let output = filter.outputImage!
                request.finish(with:output, context: nil)
            })
            avPlayerItem.videoComposition = avVideoComposition
        }
        
        player.replaceCurrentItem(with: avPlayerItem)
        player.play()
    }
//MARK: - IronSource
    func loadBanner() {
        let BNSize: ISBannerSize = ISBannerSize(description: "BANNER", width: Int(self.view.frame.size.width), height: 50)
           IronSource.loadBanner(with: self, size: BNSize)
    }
    func loadInterstitial() {
        IronSource.loadInterstitial()
    }
    func setupIronSourceSdk() {

        IronSource.setInterstitialDelegate(self)
        IronSource.setBannerDelegate(self)
        IronSource.add(self)
        
        IronSource.initWithAppKey(kAPPKEY)
    }
    func logFunctionName(string: String = #function) {
        print("IronSource Swift Demo App:"+string)
    }
    func destroyBanner() {
        if bannerView != nil {
            IronSource.destroyBanner(bannerView)
        }
    }
//MARK: - ActivityIndicator
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        activityIndicator.center = self.view.center
        activityIndicator.style = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = #colorLiteral(red: 0.4759204984, green: 0.8397880197, blue: 0.8705828786, alpha: 1)
        activityIndicator.layer.cornerRadius = 15
        activityIndicator.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        activityIndicator.layer.shadowRadius = 3
        activityIndicator.layer.shadowOffset = CGSize(width: 0, height: 0)
        activityIndicator.layer.shadowOpacity = 0.4
    }
//MARK: - imageBackgroundVideo
    lazy var imageVideoBackground: UIImageView = {
        var wdth: CGFloat!
        var bttm: CGFloat!
        var lead: CGFloat!
        if totalSize.height >= 920 {
            wdth = 750
            bttm = -668
            lead = -151
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            wdth = 730
            bttm = -597.5
            lead = -181
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 685
            bttm = -584
            lead = -159
        } else if totalSize.height == 812 {
            wdth = 685
            bttm = -559
            lead = -153.5
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 707
            bttm = -835.5
            lead = -129.5
        } else if totalSize.height <= 670 {
            wdth = 640
            bttm = -790
            lead = -111
        } else {
            wdth = 820
            bttm = -864.5
            lead = -201
        }
        
        var image = UIImageView(image: homeWorkout?.imageBackground)
        image.contentMode = .scaleAspectFit
        image.layer.zPosition = -1
        homeWorkoutVideoPlayer.addSubview(image)
        
        image.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(bttm)
            make.leading.equalToSuperview().inset(lead)
            make.width.equalTo(wdth)
            make.height.equalTo(wdth)
        }
        return image
    }()
//MARK: - VideoReady
    @objc func videoReady() {
        activityIndicator.isHidden = true
    }
//MARK: - ButtonNextWorkout
    @objc lazy var nextWorkoutButton: UIButton = {
        let trail: CGFloat!
        let bottom: CGFloat!
        let size: CGFloat!
        if totalSize.height >= 920 {
            trail = 20
            bottom = 17
            size = 60
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            trail = 15
            bottom = 15
            size = 60
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            trail = 20
            bottom = 20
            size = 50
        } else if totalSize.height == 812 {
            trail = 20
            bottom = 20
            size = 50
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            trail = 8
            bottom = 9
            size = 45
        } else if totalSize.height <= 670 {
            trail = 10
            bottom = 10
            size = 40
        } else {
            trail = 20
            bottom = 20
            size = 50
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "rightArrow"), for: .normal)
        btn.layer.zPosition = 4
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.3
        btn.alpha = 0
//        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(trail)
            make.bottom.equalToSuperview().inset(bottom)
            make.height.equalTo(size)
            make.width.equalTo(size)
        }
        
        return btn
    }()
    @objc func nextWorkoutButtonAction(sender: UIButton) {

        destroyBanner()
        homeWorkoutVideoPlayer.playerEndPlay()
        
        sender.zoomOut()
        
        UserDefaults.standard.set(false, forKey: "isOpenHomeWorkout")
        UserDefaults.standard.set(true, forKey: "openNextHomeWorkoutList")
    
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeWorkoutTableViewController")

        viewController.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(viewController, animated: false, completion: nil)

    }
//MARK: - ButtonBackWorkout
    @objc lazy var backWorkoutButton: UIButton = {
        let trail: CGFloat!
        let bottom: CGFloat!
        let size: CGFloat!
        if totalSize.height >= 920 {
            trail = 20
            bottom = 17
            size = 60
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            trail = 15
            bottom = 15
            size = 60
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            trail = 20
            bottom = 20
            size = 50
        } else if totalSize.height == 812 {
            trail = 20
            bottom = 20
            size = 50
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            trail = 8
            bottom = 9
            size = 45
        } else if totalSize.height <= 670 {
            trail = 10
            bottom = 10
            size = 40
        } else {
            trail = 20
            bottom = 20
            size = 50
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "leftArrow"), for: .normal)
        btn.layer.zPosition = 4
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.3
        btn.alpha = 0
//        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(trail)
            make.bottom.equalToSuperview().inset(bottom)
            make.height.equalTo(size)
            make.width.equalTo(size)
        }
        
        return btn
    }()
    @objc func backWorkoutButtonAction(sender: UIButton) {

        destroyBanner()
        homeWorkoutVideoPlayer.playerEndPlay()
        
        sender.zoomOut()
        
        UserDefaults.standard.set(false, forKey: "isOpenHomeWorkout")
        UserDefaults.standard.set(true, forKey: "openBackHomeWorkoutList")
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeWorkoutTableViewController")

        viewController.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(viewController, animated: false, completion: nil)
    }
//MARK: - backgroundImage
    lazy var darkPanel: UIImageView =  {
        let positX: CGFloat!
        if totalSize.height >= 830 {
            positX = -90
        } else if totalSize.height <= 800 {
            positX = -130
        } else {
            positX = -110
        }
        var panel = UIImageView(image: #imageLiteral(resourceName: "turquoisePanel"))
        panel.contentMode = .scaleAspectFit
        panel.layer.zPosition = 2
        panel.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        panel.layer.shadowRadius = 5
        panel.layer.shadowOffset = CGSize(width: 0, height: 0)
        panel.layer.shadowOpacity = 0.5
        self.view.addSubview(panel)

        panel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positX)
            make.leading.trailing.equalToSuperview()
    }
        return panel
    }()
    lazy var lightPanel: UIImageView =  {
        let positX: CGFloat!
        if totalSize.height >= 830 {
            positX = -10
        } else if totalSize.height <= 800 {
            positX = -50
        } else {
            positX = -30
        }
        var panel = UIImageView(image: #imageLiteral(resourceName: "turquoisePanelLight"))
        panel.contentMode = .scaleAspectFit
        panel.layer.zPosition = 1
        panel.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        panel.layer.shadowRadius = 3
        panel.layer.shadowOffset = CGSize(width: 1, height: 1)
        panel.layer.shadowOpacity = 0.5
        self.view.addSubview(panel)

        panel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positX)
            make.leading.trailing.equalToSuperview()
    }
        return panel
    }()
    lazy var lightPanelBottom: UIImageView =  {
        let positBttm: CGFloat!
        if totalSize.height >= 830 {
            positBttm = -150
        } else if totalSize.height == 812 {
            positBttm = -150
        } else if totalSize.height <= 800 {
            positBttm = -175
        } else {
            positBttm = -175
        }
        var panel = UIImageView(image: #imageLiteral(resourceName: "turquoisePanelLight"))
        panel.contentMode = .scaleAspectFit
        panel.layer.zPosition = 1
        panel.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        panel.layer.shadowRadius = 3
        panel.layer.shadowOffset = CGSize(width: 0, height: 0)
        panel.layer.shadowOpacity = 0.5
        self.view.addSubview(panel)

        panel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(positBttm)
            make.leading.trailing.equalToSuperview()
    }
        return panel
    }()
    private func setupBackground() {
        self.darkPanel.isHidden = false
        self.lightPanel.isHidden = false
        self.lightPanelBottom.isHidden = false
    }
//MARK: - BackgroundInfo
    lazy var backgroundInfo: UIImageView = {
        
        var image = UIImageView(image: #imageLiteral(resourceName: "infoBackgroundTurquoise"))
        image.contentMode = .scaleAspectFit
        image.layer.zPosition = 8
        image.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        image.layer.shadowRadius = 20
        image.layer.shadowOffset = CGSize(width: 0, height: 0)
        image.layer.shadowOpacity = 0.6
        self.view.addSubview(image)
        
        image.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        return image
    }()
//MARK: InfoButton
        @objc lazy var infoButton: UIButton = {
            let positTop: CGFloat!
            let trail: CGFloat!
            if totalSize.height >= 830 {
                positTop = 260
                trail = 30
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                positTop = 260
                trail = 25
            } else if totalSize.height <= 670 {
                positTop = 250
                trail = 25
            } else {
                positTop = 225
                trail = 25
            }
            let btn = UIButton()
            btn.setImage(#imageLiteral(resourceName: "informationWorkout"), for: .normal)
            btn.layer.zPosition = 4
            btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            btn.layer.shadowRadius = 3
            btn.layer.shadowOffset = CGSize(width: 0, height: 0)
            btn.layer.shadowOpacity = 0.4
            btn.adjustsImageWhenHighlighted = false
            self.view.addSubview(btn)

            btn.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(trail)
                make.top.equalToSuperview().inset(positTop)
                make.height.equalTo(40)
                make.width.equalTo(40)
            }
            
            return btn
        }()
        @objc func buttonInfoAction(sender: UIButton) {
            
            backgroundInfo.isHidden = false
            backgroundInfo.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            UIView.animate(withDuration: 0.4) {
                self.backgroundInfo.transform = CGAffineTransform.identity
                self.backgroundInfo.alpha = 1
            }

            homeWorkoutLabel3.isHidden = false
            homeWorkoutLabel3.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            UIView.animate(withDuration: 0.4) {
                self.homeWorkoutLabel3.transform = CGAffineTransform.identity
                self.homeWorkoutLabel3.alpha = 1
            }

            infoButton.isHidden = true

            closeInfoButton.isHidden = false

            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
                self.closeInfoButton.zoomInInfo()
            }

            closeInfoButton.addTarget(self, action: #selector(buttonCloseInfoAction(sender:)), for: .touchUpInside)
        }
//MARK: CloseInfoButton
        @objc lazy var closeInfoButton: UIButton = {
            let positTop: CGFloat!
            let trail: CGFloat!
            if totalSize.height >= 920 {
                positTop = 270
                trail = 40
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                positTop = 270
                trail = 45
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                positTop = 255
                trail = 45
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                positTop = 175
                trail = 35
            } else if totalSize.height <= 670 {
                positTop = 165
                trail = 35
            } else {
                positTop = 245
                trail = 45
            }
            let btn = UIButton()
            btn.setImage(#imageLiteral(resourceName: "cancelWhite"), for: .normal)
            btn.layer.zPosition = 10
            btn.alpha = 0
            btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            btn.layer.shadowRadius = 5
            btn.layer.shadowOffset = CGSize(width: 0, height: 0)
            btn.layer.shadowOpacity = 0.3
            self.view.addSubview(btn)

            btn.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(trail)
                make.top.equalToSuperview().inset(positTop)
                make.height.equalTo(30)
                make.width.equalTo(30)
            }
            
            return btn
        }()
        @objc func buttonCloseInfoAction(sender: UIButton) {
            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                self.backgroundInfo.isHidden = true
            }
            backgroundInfo.zoomOutInfo()
            
            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                self.homeWorkoutLabel3.isHidden = true
            }
            homeWorkoutLabel3.zoomOutInfo()
            
            closeInfoButton.zoomOutInfo()
            
            self.closeInfoButton.isHidden = true
            
            infoButton.isHidden = false
        }
//MARK: Dismiss
        @objc lazy var dismissButton: UIButton = {
            let trail: CGFloat!
            if totalSize.height >= 920 {
                trail = 35
            } else if totalSize.height >= 830 && totalSize.height <= 919 {
                trail = 30
            } else if totalSize.height == 812 {
                trail = 30
            } else if totalSize.height <= 800 {
                trail = 20
            } else {
                trail = 40
            }
            let btn = UIButton()
            btn.setImage(#imageLiteral(resourceName: "cancelWhite"), for: .normal)
            btn.layer.zPosition = 4
            btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            btn.layer.shadowRadius = 5
            btn.layer.shadowOffset = CGSize(width: 0, height: 0)
            btn.layer.shadowOpacity = 0.3
            self.view.addSubview(btn)

            btn.snp.makeConstraints { make in
                make.trailing.top.equalToSuperview().inset(trail)
                make.height.equalTo(30)
                make.width.equalTo(30)
            }
            
            return btn
        }()
        @objc func buttonDismiss(sender: UIButton) {
            
            destroyBanner()
            homeWorkoutVideoPlayer.playerEndPlay()
            
            UserDefaults.standard.set(false, forKey: "isOpenHomeWorkout")
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeWorkoutTableViewController")
            
            viewController.modalPresentationStyle = .fullScreen

            let transition = CATransition()
            transition.duration = 0.4
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromBottom
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
            view.window!.layer.add(transition, forKey: kCATransition)

            present(viewController, animated: false, completion: nil)
        }
//MARK: StatusBar
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

//MARK: - ExtensionIronSource
extension HomeWorkoutViewController: ISBannerDelegate, ISImpressionDataDelegate, ISInterstitialDelegate {
    
    //banner
    func bannerDidLoad(_ bannerView: ISBannerView!) {
        self.bannerView = bannerView
               
            if totalSize.height >= 920 {
                bannerView.frame = CGRect(x: 0, y: view.frame.size.height - 150, width: view.frame.size.width, height: 0)
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                bannerView.frame = CGRect(x: 0, y: view.frame.size.height - 150, width: view.frame.size.width, height: 0)
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                bannerView.frame = CGRect(x: 0, y: view.frame.size.height - 150, width: view.frame.size.width, height: 0)
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                bannerView.frame = CGRect(x: 0, y: view.frame.size.height - 540, width: view.frame.size.width, height: 0)
            } else if totalSize.height <= 670 {
                bannerView.frame = CGRect(x: 0, y: view.frame.size.height - 480, width: view.frame.size.width, height: 0)
            } else {
                bannerView.frame = CGRect(x: 0, y: view.frame.size.height - 140, width: view.frame.size.width, height: 0)
            }


        bannerView.backgroundColor = .clear
        bannerView.layer.zPosition = 7
        view.addSubview(bannerView)
        
        logFunctionName()
    }
    
    func bannerDidShow() {
        logFunctionName()
    }
    
    func bannerDidFailToLoadWithError(_ error: Error!) {
        logFunctionName(string: #function+String(describing: Error.self))

    }
    
    func didClickBanner() {
        logFunctionName()
    }
    
    func bannerWillPresentScreen() {
        logFunctionName()
    }
    
    func bannerDidDismissScreen() {
        logFunctionName()
    }
    
    func bannerWillLeaveApplication() {
        logFunctionName()
    }
    func impressionDataDidSucceed(_ impressionData: ISImpressionData!) {
        logFunctionName(string: #function+String(describing: impressionData))

    }
    
    //Interstitial
    public func didClickInterstitial() {
        logFunctionName()
    }
    public func interstitialDidFailToShowWithError(_ error: Error!) {
        logFunctionName(string: String(describing: error.self))
    }
    public func interstitialDidShow() {
        logFunctionName()
    }
    public func interstitialDidClose() {
        logFunctionName()
    }
    public func interstitialDidOpen() {
        logFunctionName()
    }
    public func interstitialDidFailToLoadWithError(_ error: Error!) {
        logFunctionName(string: #function+String(describing: error.self))
    }
    public func interstitialDidLoad() {
        logFunctionName()
    }
}
