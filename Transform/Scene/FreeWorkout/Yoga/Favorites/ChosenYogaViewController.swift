//
//  ChosenYogaViewController.swift
//  Transform
//
//  Created by Pavel Lyutikov on 16.05.2021.
//

import UIKit
import SnapKit
import AVKit
import CachingPlayerItem

class ChosenYogaViewController: UIViewController {
  
    @IBOutlet weak var yogaLabel1: UILabel!
    @IBOutlet weak var yogaLabel2: UILabel!
    @IBOutlet weak var yogaLabel3: UILabel!
    @IBOutlet weak var yogaLabel4: UILabel!
    @IBOutlet weak var yogaVideoPlayer: VideoPlayer!
    
    let totalSize = UIScreen.main.bounds.size
    
    var yoga: Yoga?
    var activityIndicator = UIActivityIndicatorView()
    
    //ironSource
    var bannerView: ISBannerView! = nil
    let kAPPKEY = "11dfcc91d"
    
//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        
        navigationController?.isNavigationBarHidden = true
        
        setupActivityIndicator()
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        guard let yoga = yoga else { return }

        //Lbl1
        let positLb1: CGFloat!
        if totalSize.height >= 890 {
            switch Locale.current.languageCode {
            case "ru":
                positLb1 = 90
            case "en":
                positLb1 = 102
            default:
                positLb1 = 102
            }
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            switch Locale.current.languageCode {
            case "ru":
                positLb1 = 90
            case "en":
                positLb1 = 97
            default:
                positLb1 = 97
            }
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            switch Locale.current.languageCode {
            case "ru":
                positLb1 = 65
            case "en":
                positLb1 = 62
            default:
                positLb1 = 62
            }
        } else if totalSize.height <= 670 {
            positLb1 = 55
        } else {
            positLb1 = 80
        }

        yogaLabel1.text = yoga.text1
        yogaLabel1.textColor = .white
        yogaLabel1.layer.zPosition = 3
        yogaLabel1.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        yogaLabel1.layer.shadowRadius = 5
        yogaLabel1.layer.shadowOffset = CGSize(width: 0, height: 0)
        yogaLabel1.layer.shadowOpacity = 0.3
        
        yogaLabel1.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positLb1)
        }
        
        
        //Lbl2
        let fontSizeLb2: CGFloat!
        if totalSize.height >= 890 {
            fontSizeLb2 = 20
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            switch Locale.current.languageCode {
            case "ru":
                fontSizeLb2 = 18
            case "en":
                fontSizeLb2 = 20
            default:
                fontSizeLb2 = 20
            }
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            switch Locale.current.languageCode {
            case "ru":
                fontSizeLb2 = 18
            case "en":
                fontSizeLb2 = 20
            default:
                fontSizeLb2 = 20
            }
        } else if totalSize.height <= 670 {
            switch Locale.current.languageCode {
            case "ru":
                fontSizeLb2 = 16
            case "en":
                fontSizeLb2 = 19
            default:
                fontSizeLb2 = 19
            }
        } else {
            switch Locale.current.languageCode {
            case "ru":
                fontSizeLb2 = 16
            case "en":
                fontSizeLb2 = 20
            default:
                fontSizeLb2 = 20
            }
        }
        yogaLabel2.text = yoga.text2
        yogaLabel2.textColor = .white
        yogaLabel2.layer.zPosition = 3
        yogaLabel2.font = UIFont.systemFont(ofSize: fontSizeLb2)
        yogaLabel2.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        yogaLabel2.layer.shadowRadius = 5
        yogaLabel2.layer.shadowOffset = CGSize(width: 0, height: 0)
        yogaLabel2.layer.shadowOpacity = 0.3
        
        //Lbl3
        let fontSize: CGFloat!
        if totalSize.height >= 920 {
            fontSize = 18
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 17
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 16
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 17
        } else if totalSize.height <= 670 {
            fontSize = 15
        } else {
            fontSize = 15
        }
        yogaLabel3.text = yoga.text3
        yogaLabel3.textColor = .white
        yogaLabel3.layer.zPosition = 9
        yogaLabel3.textAlignment = .natural
        yogaLabel3.isHidden = true
        yogaLabel3.font = UIFont.systemFont(ofSize: fontSize)
        yogaLabel3.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        yogaLabel3.layer.shadowRadius = 5
        yogaLabel3.layer.shadowOffset = CGSize(width: 0, height: 0)
        yogaLabel3.layer.shadowOpacity = 0.3
        
        yogaLabel3.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        //Lbl4
        let positBttm: CGFloat!
        if totalSize.height >= 920 {
            positBttm = 33
        } else if totalSize.height >= 830 && totalSize.height <= 919 {
            positBttm = 30
        } else if totalSize.height <= 800 {
            positBttm = 15
        } else {
            positBttm = 25
        }
        
        yogaLabel4.text = yoga.text4
        yogaLabel4.textColor = .white
        yogaLabel4.layer.zPosition = 7
        yogaLabel4.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        yogaLabel4.layer.shadowRadius = 5
        yogaLabel4.layer.shadowOffset = CGSize(width: 0, height: 0)
        yogaLabel4.layer.shadowOpacity = 0.3
        
        yogaLabel4.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(positBttm)
        }
        
        imageVideoBackground.isHidden = false
        
        let positBttmVP: CGFloat!
        let lead: CGFloat!
        if totalSize.height >= 920 {
            positBttmVP = 660
            lead = -20
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positBttmVP = 640
            lead = 0
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positBttmVP = 630
            lead = -10
        } else if totalSize.height == 812 {
            positBttmVP = 560
            lead = -10
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positBttmVP = 720
            lead = -10
        } else if totalSize.height <= 670 {
            positBttmVP = 650
            lead = -5
        } else {
            positBttmVP = 580
            lead = -30
        }
        
        yogaVideoPlayer.contentMode = .scaleToFill
        yogaVideoPlayer.snp.makeConstraints { make in
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
        
        guard let videoUrl = URL(string: yoga.video) else { return }
        
        URLSession.shared.dataTask(with: videoUrl) { [weak self] (data, response, error) in
            guard let data = data else { return }

            DispatchQueue.main.async { [weak self] in
                self?.yogaVideoPlayer.playVideoWithData(data: data)
            }

        }.resume()
        
        
        //InfoBtn
        infoButton.addTarget(self, action: #selector(buttonInfoAction(sender:)), for: .touchUpInside)
        
        //TimedOutAlert
        NotificationCenter.default.addObserver(self, selector: #selector(ChosenYogaViewController.videoReady), name: NSNotification.Name(rawValue: "videoReady"), object: nil)
        
        //ads
        if !UserDefaults.standard.bool(forKey: "removeAdsPurchased") {
            setupIronSourceSdk()
            loadBanner()
        }
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
        activityIndicator.backgroundColor = #colorLiteral(red: 0.8977387547, green: 0.48763901, blue: 0.4868730307, alpha: 1)
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
            wdth = 970
            bttm = -777
            lead = -266
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            wdth = 865
            bttm = -708
            lead = -239
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 830
            bttm = -694.5
            lead = -226
        } else if totalSize.height == 812 {
            wdth = 822
            bttm = -645.5
            lead = -222
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 798
            bttm = -833
            lead = -195
        } else if totalSize.height <= 670 {
            wdth = 730
            bttm = -757
            lead = -181
        } else {
            wdth = 820
            bttm = -864.5
            lead = -201
        }
        
        var image = UIImageView(image: yoga?.imageBackground)
        image.contentMode = .scaleAspectFit
        image.layer.zPosition = -1
        yogaVideoPlayer.addSubview(image)
        
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
            trail = 10
            bottom = 20
            size = 50
        } else if totalSize.height == 812 {
            trail = 5
            bottom = 15
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
            trail = 5
            bottom = 15
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
        yogaVideoPlayer.playerEndPlay()
        
        sender.zoomOut()
        
        UserDefaults.standard.set(false, forKey: "isOpenYoga")
        UserDefaults.standard.set(true, forKey: "openNextYoga")
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ChosenYogaTableViewController")

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
            trail = 10
            bottom = 20
            size = 50
        } else if totalSize.height == 812 {
            trail = 5
            bottom = 15
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
            trail = 5
            bottom = 15
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
        yogaVideoPlayer.playerEndPlay()
        
        sender.zoomOut()
        
        UserDefaults.standard.set(false, forKey: "isOpenYoga")
        UserDefaults.standard.set(true, forKey: "openBackYoga")
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ChosenYogaTableViewController")

        viewController.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(viewController, animated: false, completion: nil)
        
    }
//MARK: - BackgroundInfo
    lazy var backgroundInfo: UIImageView = {
        
        var image = UIImageView(image: #imageLiteral(resourceName: "infoBackgroundRed"))
        image.contentMode = .scaleAspectFit
        image.layer.zPosition = 8
        image.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        image.layer.shadowRadius = 50
        image.layer.shadowOffset = CGSize(width: 0, height: 0)
        image.layer.shadowOpacity = 0.8
        self.view.addSubview(image)
        
        image.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
        return image
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
            var panel = UIImageView(image: #imageLiteral(resourceName: "redPanelLight"))
            panel.contentMode = .scaleAspectFit
            panel.layer.zPosition = 2
            panel.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            panel.layer.shadowRadius = 5
            panel.layer.shadowOffset = CGSize(width: 0, height: 0)
            panel.layer.shadowOpacity = 50
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
            var panel = UIImageView(image: #imageLiteral(resourceName: "redPanel"))
            panel.contentMode = .scaleAspectFit
            panel.layer.zPosition = 1
            panel.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            panel.layer.shadowRadius = 3
            panel.layer.shadowOffset = CGSize(width: 1, height: 1)
            panel.layer.shadowOpacity = 50
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
                positBttm = -160
            }
            var panel = UIImageView(image: #imageLiteral(resourceName: "redPanel"))
            panel.contentMode = .scaleAspectFit
            panel.layer.zPosition = 1
            panel.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            panel.layer.shadowRadius = 3
            panel.layer.shadowOffset = CGSize(width: 0, height: 0)
            panel.layer.shadowOpacity = 50
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
            btn.setImage(#imageLiteral(resourceName: "informationYoga"), for: .normal)
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

            yogaLabel3.isHidden = false
            yogaLabel3.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            UIView.animate(withDuration: 0.4) {
                self.yogaLabel3.transform = CGAffineTransform.identity
                self.yogaLabel3.alpha = 1
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
            if totalSize.height >= 890 {
                positTop = 115
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                positTop = 110
            } else if totalSize.height <= 800 {
                positTop = 30
            } else {
                positTop = 105
            }
            
            let btn = UIButton()
            btn.setImage(#imageLiteral(resourceName: "cancelWhite"), for: .normal)
            btn.layer.zPosition = 10
            btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            btn.layer.shadowRadius = 3
            btn.layer.shadowOffset = CGSize(width: 0, height: 0)
            btn.layer.shadowOpacity = 0.4
            self.view.addSubview(btn)

            btn.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(30)
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
                self.yogaLabel3.isHidden = true
            }
            yogaLabel3.zoomOutInfo()
            
            closeInfoButton.zoomOutInfo()
            
            self.closeInfoButton.isHidden = true
            
            infoButton.isHidden = false
        }
//MARK: Dismiss
        @objc lazy var dismissButton: UIButton = {
            
            let positBtn: CGFloat!
            if totalSize.height >= 830 {
                positBtn = 30
            } else if totalSize.height == 812 {
                positBtn = 20
            } else if totalSize.height <= 800 {
                positBtn = 20
            } else {
                positBtn = 20
            }
            let btn = UIButton()
            btn.setImage(#imageLiteral(resourceName: "cancelWhite"), for: .normal)
            btn.layer.zPosition = 4
            btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            btn.layer.shadowRadius = 3
            btn.layer.shadowOffset = CGSize(width: 0, height: 0)
            btn.layer.shadowOpacity = 0.4
            self.view.addSubview(btn)

            btn.snp.makeConstraints { make in
                make.trailing.top.equalToSuperview().inset(positBtn)
                make.height.equalTo(30)
                make.width.equalTo(30)
            }
            
            return btn
        }()
        @objc func buttonDismiss(sender: UIButton) {
            yogaVideoPlayer.playerEndPlay()
            destroyBanner()
            
            UserDefaults.standard.set(false, forKey: "isOpenYoga")
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ChosenYogaTableViewController")
            
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
extension ChosenYogaViewController: ISBannerDelegate, ISImpressionDataDelegate {
    
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
