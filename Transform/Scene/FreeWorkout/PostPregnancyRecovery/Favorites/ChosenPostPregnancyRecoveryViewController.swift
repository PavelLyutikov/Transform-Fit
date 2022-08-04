//
//  ChosenPostPregnancyRecoveryViewController.swift
//  Transform
//
//  Created by Pavel Lyutikov on 03.06.2021.
//

import UIKit
import SnapKit
import AVKit

class ChosenPostPregnancyRecoveryViewController: UIViewController {
    
    let totalSize = UIScreen.main.bounds.size
    
    @IBOutlet weak var postPregnancyRecoveryLabel1: UILabel!
    @IBOutlet weak var postPregnancyRecoveryLabel2: UILabel!
    @IBOutlet weak var postPregnancyRecoveryLabel3: UILabel!
    @IBOutlet weak var postPregnancyRecoveryLabel4: UILabel!
    @IBOutlet weak var postPregnancyRecoveryVideoPlayer: VideoPlayer!
    
    
    var postPregnancyRecovery: PostPregnancyRecovery?
    var activityIndicator = UIActivityIndicatorView()
    
    //ironSource
    var bannerView: ISBannerView! = nil
    let kAPPKEY = "11dfcc91d"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        
        navigationController?.isNavigationBarHidden = true
        
        guard let postPregnancyRecovery = postPregnancyRecovery else { return }

        let positLb1: CGFloat!
        let fntSzLb1: CGFloat!
        if totalSize.height >= 890 {
            positLb1 = 105
            fntSzLb1 = 25
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positLb1 = 100
            fntSzLb1 = 24
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positLb1 = 70
            fntSzLb1 = 23
        } else if totalSize.height <= 670 {
            positLb1 = 50
            fntSzLb1 = 22
        } else {
            positLb1 = 85
            fntSzLb1 = 22
        }
        postPregnancyRecoveryLabel1.text = postPregnancyRecovery.text1
        postPregnancyRecoveryLabel1.font = UIFont.systemFont(ofSize: fntSzLb1)
        postPregnancyRecoveryLabel1.textColor = .white
        postPregnancyRecoveryLabel1.layer.zPosition = 3
        postPregnancyRecoveryLabel1.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        postPregnancyRecoveryLabel1.layer.shadowRadius = 5
        postPregnancyRecoveryLabel1.layer.shadowOffset = CGSize(width: 0, height: 0)
        postPregnancyRecoveryLabel1.layer.shadowOpacity = 0.3
        
        postPregnancyRecoveryLabel1.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positLb1)
        }
        
        
        let fontSizeLb2: CGFloat!
        if totalSize.height >= 830 {
            fontSizeLb2 = 20
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSizeLb2 = 20
        } else if totalSize.height <= 670 {
            fontSizeLb2 = 18
        } else {
            fontSizeLb2 = 18
        }
        postPregnancyRecoveryLabel2.text = postPregnancyRecovery.text2
        postPregnancyRecoveryLabel2.textColor = .white
        postPregnancyRecoveryLabel2.layer.zPosition = 3
        postPregnancyRecoveryLabel2.font = UIFont.systemFont(ofSize: fontSizeLb2)
        postPregnancyRecoveryLabel2.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        postPregnancyRecoveryLabel2.layer.shadowRadius = 5
        postPregnancyRecoveryLabel2.layer.shadowOffset = CGSize(width: 0, height: 0)
        postPregnancyRecoveryLabel2.layer.shadowOpacity = 0.3
        
        let fontSize: CGFloat!
        if totalSize.height >= 890 {
            fontSize = 20
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 18
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 19
        } else if totalSize.height <= 670 {
            fontSize = 18
        } else {
            fontSize = 17
        }
        postPregnancyRecoveryLabel3.text = postPregnancyRecovery.text3
        postPregnancyRecoveryLabel3.textColor = .white
        postPregnancyRecoveryLabel3.font = UIFont.systemFont(ofSize: fontSize)
        postPregnancyRecoveryLabel3.layer.zPosition = 9
        postPregnancyRecoveryLabel3.isHidden = true
        postPregnancyRecoveryLabel3.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        postPregnancyRecoveryLabel3.layer.shadowRadius = 5
        postPregnancyRecoveryLabel3.layer.shadowOffset = CGSize(width: 0, height: 0)
        postPregnancyRecoveryLabel3.layer.shadowOpacity = 0.3
        
        postPregnancyRecoveryLabel3.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(40)
            make.trailing.equalToSuperview().inset(40)
        }
        
        
        let positBttm: CGFloat!
        let fontSizeLb4: CGFloat!
        if totalSize.height >= 920 {
            positBttm = 33
            fontSizeLb4 = 23
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positBttm = 35
            fontSizeLb4 = 23
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positBttm = 34
            fontSizeLb4 = 23
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positBttm = 20
            fontSizeLb4 = 22
        } else if totalSize.height <= 670 {
            positBttm = 15
            fontSizeLb4 = 20
        } else {
            positBttm = 25
            fontSizeLb4 = 20
        }
        postPregnancyRecoveryLabel4.text = postPregnancyRecovery.text4
        postPregnancyRecoveryLabel4.textColor = .white
        postPregnancyRecoveryLabel4.layer.zPosition = 7
        postPregnancyRecoveryLabel4.font = UIFont.systemFont(ofSize: fontSizeLb4)
        postPregnancyRecoveryLabel4.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        postPregnancyRecoveryLabel4.layer.shadowRadius = 5
        postPregnancyRecoveryLabel4.layer.shadowOffset = CGSize(width: 0, height: 0)
        postPregnancyRecoveryLabel4.layer.shadowOpacity = 0.3
        
        postPregnancyRecoveryLabel4.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(positBttm)
            make.centerX.equalToSuperview()
        }
        
        imageVideoBackground.isHidden = false
        whiteColorVideo.isHidden = false
        
        let positBttmVP: CGFloat!
        let lead: CGFloat!
        if totalSize.height >= 920 {
            positBttmVP = 600
            lead = 0
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positBttmVP = 570
            lead = 20
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positBttmVP = 540
            lead = 5
        } else if totalSize.height == 812 {
            positBttmVP = 470
            lead = -10
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positBttmVP = 660
            lead = 0
        } else if totalSize.height <= 670 {
            positBttmVP = 580
            lead = 10
        } else {
            positBttmVP = 500
            lead = -15
        }

        postPregnancyRecoveryVideoPlayer.snp.makeConstraints { make in
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
        
        guard let videoUrl = URL(string: postPregnancyRecovery.video) else { return }
        
        
        URLSession.shared.dataTask(with: videoUrl) { [weak self] (data, response, error) in
            guard let data = data else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.postPregnancyRecoveryVideoPlayer.playVideoWithData(data: data)
            }
        }.resume()
        
        setupActivityIndicator()
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        infoButton.addTarget(self, action: #selector(buttonInfoAction(sender:)), for: .touchUpInside)
    
        //ads
        if !UserDefaults.standard.bool(forKey: "removeAdsPurchased") {
            setupIronSourceSdk()
            loadBanner()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChosenPostPregnancyRecoveryViewController.videoReady), name: NSNotification.Name(rawValue: "videoReadyPostPregnancyRecovery"), object: nil)
    }
//MARK: - IronSource
    func loadBanner() {
        let BNSize: ISBannerSize = ISBannerSize(description: "BANNER", width: Int(self.view.frame.size.width), height: 50)
           IronSource.loadBanner(with: self, size: BNSize)
        UserDefaults.standard.set(true, forKey: "bannerLoaded")
    }
    func setupIronSourceSdk() {

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
    private func setupActivityIndicator(){
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        activityIndicator.center = self.view.center
        activityIndicator.style = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = #colorLiteral(red: 0.9971613288, green: 0.7633588314, blue: 0.7777944207, alpha: 1)
        activityIndicator.layer.cornerRadius = 15
        activityIndicator.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        activityIndicator.layer.shadowRadius = 3
        activityIndicator.layer.shadowOffset = CGSize(width: 0, height: 0)
        activityIndicator.layer.shadowOpacity = 0.4
    }
//MARK: - BackgroundInfo
    lazy var backgroundInfo: UIImageView = {
        
        var image = UIImageView(image: #imageLiteral(resourceName: "infoBackground"))
        image.contentMode = .scaleAspectFit
        image.layer.zPosition = 8
        image.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        image.layer.shadowRadius = 50
        image.layer.shadowOffset = CGSize(width: 0, height: 0)
        image.layer.shadowOpacity = 0.8
        self.view.addSubview(image)
        
        image.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        return image
    }()
//MARK: - imageBackgroundVideo
    lazy var imageVideoBackground: UIImageView = {
        var wdth: CGFloat!
        var bttm: CGFloat!
        var lead: CGFloat!
        if totalSize.height >= 920 {
            wdth = 538
            bttm = -449
            lead = -60
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            wdth = 470
            bttm = -387.5
            lead = -51
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 470
            bttm = -387.5
            lead = -51
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 430
            bttm = -561
            lead = -21
        } else if totalSize.height <= 670 {
            wdth = 403
            bttm = -516.5
            lead = -27.5
        } else {
            wdth = 430
            bttm = -370.5
            lead = -21
        }
        
        var image = UIImageView(image: postPregnancyRecovery?.imageBackground)
        image.contentMode = .scaleAspectFit
        image.layer.zPosition = -2
        postPregnancyRecoveryVideoPlayer.addSubview(image)
        
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
            trail = 15
            bottom = 20
            size = 50
        } else if totalSize.height == 812 {
            trail = 20
            bottom = 10
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
            bottom = 10
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
        postPregnancyRecoveryVideoPlayer.playerEndPlay()
        
        sender.zoomOut()
        
        UserDefaults.standard.set(false, forKey: "isOpenRecovery")
        UserDefaults.standard.set(true, forKey: "openNextPostPregnancyRecovery")
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ChosenPostPregnancyRecoveryTableViewController")

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
            trail = 15
            bottom = 20
            size = 50
        } else if totalSize.height == 812 {
            trail = 20
            bottom = 10
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
            bottom = 10
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
        postPregnancyRecoveryVideoPlayer.playerEndPlay()
        
        sender.zoomOut()
        
        UserDefaults.standard.set(false, forKey: "isOpenRecovery")
        UserDefaults.standard.set(true, forKey: "openBackPostPregnancyRecovery")
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ChosenPostPregnancyRecoveryTableViewController")

        viewController.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(viewController, animated: false, completion: nil)
        
    }
//MARK: - whiteColorVideo
    lazy var whiteColorVideo: UIImageView = {
        let positY: CGFloat!
        if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 50
        } else {
            positY = 50
        }
        let img = UIImageView(image: #imageLiteral(resourceName: "whiteColor"))
        img.layer.zPosition = 0
        self.view.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.height.equalTo(300)
            make.width.equalTo(800)
            make.top.equalToSuperview().inset(positY)
        }
        
        return img
    }()
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
            var panel = UIImageView(image: #imageLiteral(resourceName: "redPinkPanel"))
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
                positX = -20
            } else if totalSize.height <= 800 {
                positX = -60
            } else {
                positX = -30
            }
            var panel = UIImageView(image: #imageLiteral(resourceName: "redPinkPanelLight"))
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
            } else if totalSize.height <= 800 {
                positBttm = -175
            } else {
                positBttm = -165
            }
            var panel = UIImageView(image: #imageLiteral(resourceName: "redPinkPanelLight"))
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
//        backgroundImage.isHidden = false
        self.darkPanel.isHidden = false
        self.lightPanel.isHidden = false
        self.lightPanelBottom.isHidden = false
    }
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
            btn.setImage(#imageLiteral(resourceName: "informationPostPregnancyRecovery"), for: .normal)
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
            
            postPregnancyRecoveryLabel3.isHidden = false
            postPregnancyRecoveryLabel3.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            UIView.animate(withDuration: 0.4) {
                self.postPregnancyRecoveryLabel3.transform = CGAffineTransform.identity
                self.postPregnancyRecoveryLabel3.alpha = 1
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
                positTop = 220
                trail = 40
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                positTop = 220
                trail = 45
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                positTop = 210
                trail = 45
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                positTop = 125
                trail = 35
            } else if totalSize.height <= 670 {
                positTop = 120
                trail = 35
            } else {
                positTop = 205
                trail = 45
            }
            let btn = UIButton()
            btn.setImage(#imageLiteral(resourceName: "cancelWhite"), for: .normal)
            btn.layer.zPosition = 10
            btn.alpha = 0
            btn.layer.shadowRadius = 3
            btn.layer.shadowOffset = CGSize(width: 0, height: 0)
            btn.layer.shadowOpacity = 0.4
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
                self.postPregnancyRecoveryLabel3.isHidden = true
            }
            postPregnancyRecoveryLabel3.zoomOutInfo()
            
            closeInfoButton.zoomOutInfo()
            
            self.closeInfoButton.isHidden = true
            
            infoButton.isHidden = false
        }
//MARK: Dismiss
        @objc lazy var dismissButton: UIButton = {
    
            let btn = UIButton()
            btn.setImage(#imageLiteral(resourceName: "cancelWhite"), for: .normal)
            btn.layer.zPosition = 4
            btn.layer.shadowRadius = 3
            btn.layer.shadowOffset = CGSize(width: 0, height: 0)
            btn.layer.shadowOpacity = 0.4
            self.view.addSubview(btn)

            btn.snp.makeConstraints { make in
                make.trailing.top.equalToSuperview().inset(30)
                make.height.equalTo(30)
                make.width.equalTo(30)
            }
            
            return btn
        }()
        @objc func buttonDismiss(sender: UIButton) {
            
            destroyBanner()
            postPregnancyRecoveryVideoPlayer.playerEndPlay()
            
            UserDefaults.standard.set(false, forKey: "isOpenRecovery")
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ChosenPostPregnancyRecoveryTableViewController")
            
            viewController.modalPresentationStyle = .fullScreen

            let transition = CATransition()
            transition.duration = 0.4
            transition.type = CATransitionType.fade
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
extension ChosenPostPregnancyRecoveryViewController: ISBannerDelegate, ISImpressionDataDelegate {
    
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
}
