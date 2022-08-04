//
//  StretchingListViewController.swift
//  Transform
//
//  Created by Pavel Lyutikov on 05.01.2021.
//

import UIKit
import SnapKit
import EGOCircleMenu

class StretchingMenuViewController: UIViewController, CircleMenuDelegate {
    
    let totalSize = UIScreen.main.bounds.size
    
    var icons = [String]()
    let submenuIds = [2]
    let showItemSegueId = "showItem"
    var selectedItemId: Int?
    
    //ironSource
    var bannerView: ISBannerView! = nil
    let kAPPKEY = "11dfcc91d"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        self.view.backgroundColor = #colorLiteral(red: 1, green: 0.9721277356, blue: 0.9925144315, alpha: 1)
        warmUpButton.addTarget(self, action: #selector(warmUpAction(sender:)), for: .touchUpInside)
        flexibleBackButton.addTarget(self, action: #selector(flexibleBackAction(sender:)), for: .touchUpInside)
        sideSplitsButton.addTarget(self, action: #selector(sideSplitsAction(sender:)), for: .touchUpInside)
        longTwineButton.addTarget(self, action: #selector(longTwineAction(sender:)), for: .touchUpInside)
        favoritesButton.addTarget(self, action: #selector(favoritesButtonAction(sender:)), for: .touchUpInside)
        
        //Ads
        if !UserDefaults.standard.bool(forKey: "removeAdsPurchased") {
            setupIronSourceSdk()
            loadBanner()
        }
        
        setupCircleMenu()
        
        //Notification
        NotificationCenter.default.addObserver(self, selector: #selector(StretchingMenuViewController.rotateCircleMenuLeft), name: NSNotification.Name(rawValue: "rotateCircleMenuLeft"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(StretchingMenuViewController.rotateCircleMenuRight), name: NSNotification.Name(rawValue: "rotateCircleMenuRight"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(StretchingMenuViewController.openCircleMenu), name: NSNotification.Name(rawValue: "openCircleMenu"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(StretchingMenuViewController.closeCircleMenu), name: NSNotification.Name(rawValue: "closeCircleMenu"), object: nil)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    func setupUI() {
        backgroundImage.isHidden = false
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
//MARK: - FavoritesButton
    @objc lazy var favoritesButton: UIButton = {
        let positX: CGFloat!
        let leidTrail: CGFloat!
        if totalSize.height >= 920 {
            positX = 80
            leidTrail = 30
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positX = 80
            leidTrail = 30
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = 80
            leidTrail = 30
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = 50
            leidTrail = 20
        } else if totalSize.height <= 670 {
            positX = 50
            leidTrail = 20
        } else {
            positX = 70
            leidTrail = 25
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "heartStretching"), for: .normal)
        btn.layer.zPosition = 6
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positX)
            make.trailing.equalToSuperview().inset(leidTrail)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        return btn
    }()
    @objc func favoritesButtonAction(sender: UIButton) {
        
        sender.zoomOut()
        
        if !UserDefaults.standard.bool(forKey: "isFirstLaunchFavoriteStretching") {
            
                destroyBanner()
            
                let vc = PreviewChosenStretchingViewController()
                vc.modalPresentationStyle = .fullScreen
                
                let transition = CATransition()
                transition.duration = 0.4
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(vc, animated: false, completion: nil)
            
           } else {
            
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    
                self.destroyBanner()
                    
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ChosenStretchingTableViewController")

                viewController.modalPresentationStyle = .fullScreen

                let transition = CATransition()
                transition.duration = 0.4
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
                self.view.window!.layer.add(transition, forKey: kCATransition)

                self.present(viewController, animated: false, completion: nil)
                }
           }
           UserDefaults.standard.set(true, forKey: "isFirstLaunchFavoriteStretching")
    
    }
//MARK: BackgroundImage
    lazy var backgroundImage: UIImageView = {
        var image = UIImageView(image: #imageLiteral(resourceName: "backgroundStretchingMenu"))
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.layer.zPosition = 0
        image.alpha = 0.5
        self.view.addSubview(image)


        image.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(0)
    }
        return image
    }()
//MARK: - Button
    //warm-Up
    @objc lazy var warmUpButton: UIButton = {
        let top: CGFloat!
        let hght: CGFloat!
        let lead: CGFloat!
        let trail: CGFloat!
        if totalSize.height >= 920 {
            top = 90
            hght = 190
            lead = 20
            trail = 100
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            top = 90
            hght = 190
            lead = 20
            trail = 100
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            top = 70
            hght = 190
            lead = 20
            trail = 90
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            top = 30
            hght = 130
            lead = 20
            trail = 90
        } else if totalSize.height <= 670 {
            top = 40
            hght = 110
            lead = 20
            trail = 90
        } else {
            top = 55
            hght = 190
            lead = 20
            trail = 90
        }
        
        let btn = UIButton()
        switch Locale.current.languageCode {
        case "ru":
            btn.setImage(#imageLiteral(resourceName: "warmUpButton"), for: .normal)
        case "en":
            btn.setImage(#imageLiteral(resourceName: "warmUpButtonEn"), for: .normal)
        default:
            btn.setImage(#imageLiteral(resourceName: "warmUpButtonEn"), for: .normal)
        }
        
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitle("Разминка".localized(), for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 30)
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 9
        btn.layer.shadowOffset = CGSize(width: 5, height: 5)
        btn.layer.shadowOpacity = 0.45
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(top)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(lead)
            make.trailing.equalToSuperview().inset(trail)
            make.height.equalTo(hght)
        }
        
        return btn
    }()
    
    @objc func warmUpAction(sender: UIButton) {
        UserDefaults.standard.set(1, forKey: "choiceMuscle")
        
        destroyBanner()
        sender.zoomOut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "StretchingTableViewController")

        viewController.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
            self.view.window!.layer.add(transition, forKey: kCATransition)

            self.present(viewController, animated: false, completion: nil)
        }
    }
    //flexibleBack
    @objc lazy var flexibleBackButton: UIButton = {
        let top: CGFloat!
        let hght: CGFloat!
        let lead: CGFloat!
        let trail: CGFloat!
        if totalSize.height >= 920 {
            top = 260
            hght = 190
            lead = 70
            trail = 50
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            top = 253
            hght = 190
            lead = 70
            trail = 50
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            top = 228
            hght = 190
            lead = 65
            trail = 45
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            top = 175
            hght = 130
            lead = 65
            trail = 40
        } else if totalSize.height <= 670 {
            top = 168
            hght = 110
            lead = 65
            trail = 40
        } else {
            top = 210
            hght = 190
            lead = 65
            trail = 45
        }
        
        let btn = UIButton()
        
        switch Locale.current.languageCode {
        case "ru":
            btn.setImage(#imageLiteral(resourceName: "fixedBackButton"), for: .normal)
        case "en":
            btn.setImage(#imageLiteral(resourceName: "fixedBackButtonEn"), for: .normal)
        default:
            btn.setImage(#imageLiteral(resourceName: "fixedBackButtonEn"), for: .normal)
        }
        
        btn.setTitle("Гибкая спина".localized(), for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 27)
        btn.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        btn.titleLabel?.textAlignment = .center
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 9
        btn.layer.shadowOffset = CGSize(width: 5, height: 5)
        btn.layer.shadowOpacity = 0.45
        btn.imageView?.contentMode = .scaleAspectFit
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(top)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(lead)
            make.trailing.equalToSuperview().inset(trail)
            make.height.equalTo(hght)
        }
        
        return btn
    }()
    @objc func flexibleBackAction(sender: UIButton) {
        UserDefaults.standard.set(2, forKey: "choiceMuscle")
        
        destroyBanner()
        sender.zoomOut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "StretchingTableViewController")

        viewController.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
            self.view.window!.layer.add(transition, forKey: kCATransition)

            self.present(viewController, animated: false, completion: nil)
        }
    }
    //sideSplits
    @objc lazy var sideSplitsButton: UIButton = {
        let bttm: CGFloat!
        let hght: CGFloat!
        let lead: CGFloat!
        let trail: CGFloat!
        if totalSize.height >= 920 {
            bttm = 300
            hght = 190
            lead = 50
            trail = 70
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            bttm = 293
            hght = 190
            lead = 50
            trail = 70
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            bttm = 268
            hght = 190
            lead = 45
            trail = 65
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            bttm = 285
            hght = 130
            lead = 40
            trail = 65
        } else if totalSize.height <= 670 {
            bttm = 260
            hght = 110
            lead = 40
            trail = 65
        } else {
            bttm = 260
            hght = 190
            lead = 45
            trail = 65
        }
        
        let btn = UIButton()
        btn.setTitle("Продольный шпагат".localized(), for: .normal)
        
        switch Locale.current.languageCode {
        case "ru":
            btn.setImage(#imageLiteral(resourceName: "sideSplitsButton"), for: .normal)
        case "en":
            btn.setImage(#imageLiteral(resourceName: "sideSplitsButtonEn"), for: .normal)
        default:
            btn.setImage(#imageLiteral(resourceName: "sideSplitsButtonEn"), for: .normal)
        }
        
        
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 22)
        btn.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        btn.titleLabel?.textAlignment = .center
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 9
        btn.layer.shadowOffset = CGSize(width: 5, height: 5)
        btn.layer.shadowOpacity = 0.45
        btn.imageView?.contentMode = .scaleAspectFit
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(bttm)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(lead)
            make.trailing.equalToSuperview().inset(trail)
            make.height.equalTo(hght)
        }
        
        return btn
    }()
    @objc func sideSplitsAction(sender: UIButton) {
        UserDefaults.standard.set(3, forKey: "choiceMuscle")
        
        destroyBanner()
        sender.zoomOut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "StretchingTableViewController")

        viewController.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
            self.view.window!.layer.add(transition, forKey: kCATransition)

            self.present(viewController, animated: false, completion: nil)
        }
    }
    //longitudinalTwine
    @objc lazy var longTwineButton: UIButton = {
        let bttm: CGFloat!
        let hght: CGFloat!
        let lead: CGFloat!
        let trail: CGFloat!
        if totalSize.height >= 920 {
            bttm = 130
            hght = 190
            lead = 100
            trail = 20
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            bttm = 130
            hght = 190
            lead = 100
            trail = 20
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            bttm = 110
            hght = 190
            lead = 90
            trail = 20
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            bttm = 135
            hght = 130
            lead = 90
            trail = 20
        } else if totalSize.height <= 670 {
            bttm = 130
            hght = 110
            lead = 90
            trail = 20
        } else {
            bttm = 105
            hght = 190
            lead = 90
            trail = 20
        }
        
        let btn = UIButton()
        btn.setTitle("Поперечный шпагат".localized(), for: .normal)
        
        switch Locale.current.languageCode {
        case "ru":
            btn.setImage(#imageLiteral(resourceName: "longTwineButton"), for: .normal)
        case "en":
            btn.setImage(#imageLiteral(resourceName: "longTwineButtonEn"), for: .normal)
        default:
            btn.setImage(#imageLiteral(resourceName: "longTwineButtonEn"), for: .normal)
        }
        
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 22)
        btn.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        btn.titleLabel?.textAlignment = .center
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 9
        btn.layer.shadowOffset = CGSize(width: 5, height: 5)
        btn.layer.shadowOpacity = 0.45
        btn.imageView?.contentMode = .scaleAspectFit
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(bttm)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(lead)
            make.trailing.equalToSuperview().inset(trail)
            make.height.equalTo(hght)
        }
        
        return btn
    }()
    @objc func longTwineAction(sender: UIButton) {
        UserDefaults.standard.set(4, forKey: "choiceMuscle")
        
        destroyBanner()
        sender.zoomOut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "StretchingTableViewController")

        viewController.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        self.view.window!.layer.add(transition, forKey: kCATransition)

        self.present(viewController, animated: false, completion: nil)
    }
    }
//MARK: - CircleMenu
    @objc func rotateCircleMenuLeft() {
        
        labelCircleMenuMoveRight.zoomOutCircleMenu()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
            if UserDefaults.standard.integer(forKey: "idCircleMenu") == 0 {
                self.labelCircleMenuMoveRight.text = "Хатха Йога".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 1 {
                self.labelCircleMenuMoveRight.text = "Фитнес дома".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 2 {
                self.labelCircleMenuMoveRight.text = "Восстановление после родов".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 3 {
                self.labelCircleMenuMoveRight.text = "Body Guide"
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 4 {
                self.labelCircleMenuMoveRight.text = "Таймер".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 5 {
                self.labelCircleMenuMoveRight.text = "Комплексы тренировок".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 6 {
                self.labelCircleMenuMoveRight.text = "Рационы питания и Калькулятор".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 7 {
                self.labelCircleMenuMoveRight.text = "Главная".localized()
            }
            self.labelCircleMenuMoveRight.zoomInCircleMenu()
        }
        
    }
    
    @objc func rotateCircleMenuRight() {
        
        labelCircleMenuMoveRight.zoomOutCircleMenu()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
            if UserDefaults.standard.integer(forKey: "idCircleMenu") == 0 {
                self.labelCircleMenuMoveRight.text = "Хатха Йога".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 1 {
                self.labelCircleMenuMoveRight.text = "Фитнес дома".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 2 {
                self.labelCircleMenuMoveRight.text = "Восстановление после родов".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 3 {
                self.labelCircleMenuMoveRight.text = "Body Guide"
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 4 {
                self.labelCircleMenuMoveRight.text = "Таймер".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 5 {
                self.labelCircleMenuMoveRight.text = "Комплексы тренировок".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 6 {
                self.labelCircleMenuMoveRight.text = "Рационы питания и Калькулятор".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 7 {
                self.labelCircleMenuMoveRight.text = "Главная".localized()
            }
            self.labelCircleMenuMoveRight.zoomInCircleMenu()
        }
        
    }
    
    @objc func openCircleMenu() {
        labelCircleMenuMoveRight.isHidden = false
        labelCircleMenuMoveRight.zoomInCircleMenu()
        labelCircleMenuMoveRight.text = "Фитнес дома".localized()
        
        whiteBackgroundCircleMenu.isHidden = false
        whiteBackgroundCircleMenu.zoomInBackCircleMenu()
    }
    @objc func closeCircleMenu() {
        labelCircleMenuMoveRight.zoomOutCircleMenu()
        whiteBackgroundCircleMenu.zoomOutBackCircleMenu()
    }
//MARK: - LabelCircleMenu
    lazy var labelCircleMenuMoveRight: UILabel = {
        let positBottom: CGFloat!
        if totalSize.height >= 920 {
            positBottom = 65
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positBottom = 65
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positBottom = 65
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positBottom = 65
        } else if totalSize.height <= 670 {
            positBottom = 65
        } else {
            positBottom = 65
        }
        let lbl = UILabel()
        lbl.text = "Фитнес дома".localized()
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 8
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 0.3785803097, green: 0.3785803097, blue: 0.3785803097, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 30)
        lbl.layer.zPosition = 110
        lbl.alpha = 0
        self.view.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.center.equalToSuperview()
//            make.bottom.equalToSuperview().inset(positBottom)
            make.width.equalTo(300)
        }
        
        return lbl
    }()
    
    lazy var whiteBackgroundCircleMenu: UIImageView = {
        let positBottom: CGFloat!
        if totalSize.height >= 920 {
            positBottom = 200
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positBottom = 170
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positBottom = 200
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positBottom = 200
        } else if totalSize.height <= 670 {
            positBottom = 200
        } else {
            positBottom = 200
        }
        let img = UIImageView(image: #imageLiteral(resourceName: "whiteBackgroundCircleMenu"))
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 5
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.2
        img.contentMode = .scaleAspectFit
        img.layer.zPosition = 109
        img.alpha = 0
        self.view.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.center.equalToSuperview()
//            make.bottom.equalToSuperview().inset(positBottom)
            make.width.equalTo(320)
        }
        
        return img
    }()
    func setupCircleMenu() {
        icons.append(contentsOf: ["home", "yoga", "dumbbell", "baby", "bodyGuideIcon", "stopwatch", "complexIcon", "foodRationIcon", "icVideo", "home", "icHDR"])
        
        let circleMenu = CircleMenu()
        circleMenu.layer.zPosition = 101
        circleMenu.attach(to: self)
        circleMenu.delegate = self
        circleMenu.circleMenuItems = createCircleMenuItems(count: 8)
        
        
        let positionY: CGFloat!
        let positionX: CGFloat!
        if totalSize.height >= 920 {
            positionY = -210
            positionX = 50
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positionY = -210
            positionX = 40
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positionY = -210
            positionX = 20
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positionY = -210
            positionX = 40
        } else if totalSize.height <= 670 {
            positionY = -210
            positionX = 10
        } else {
            positionY = -210
            positionX = 5
            //noAds
            //positionY = -300
        }
        
        circleMenu.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(positionY)
            make.leading.equalToSuperview().inset(positionX)
        }
    }
    func menuItemSelected(id: Int) {
//        idLabel.text = "id: \(id)"
        selectedItemId = id
        guard id != 100 else {
            return
        }
        print(id)
        
        destroyBanner()
        
        if id == 0 {
            let vc = MainViewController()
            vc.modalPresentationStyle = .fullScreen
            
            let transition = CATransition()
            transition.duration = 0.4
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromLeft
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
            view.window!.layer.add(transition, forKey: kCATransition)

            present(vc, animated: false, completion: nil)
        } else if id == 1 {
            if !UserDefaults.standard.bool(forKey: "isFirstLaunchYoga") {
                    
                let vc = PreviewYogaViewController()
                vc.modalPresentationStyle = .fullScreen

                let transition = CATransition()
                transition.duration = 0.4
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(vc, animated: false, completion: nil)
                
               } else {
                let vc = YogaMenuViewController()
                vc.modalPresentationStyle = .fullScreen

                let transition = CATransition()
                transition.duration = 0.4
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(vc, animated: false, completion: nil)
               }
               UserDefaults.standard.set(true, forKey: "isFirstLaunchYoga")
        } else if id == 2 {
            if !UserDefaults.standard.bool(forKey: "isFirstLaunchHomeWorkout") {
                    
                let vc = PreviewHomeWorkoutViewController()
                vc.modalPresentationStyle = .fullScreen

                let transition = CATransition()
                transition.duration = 0.4
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(vc, animated: false, completion: nil)
                
               } else {
                let vc = HomeWorkoutMenuViewController()
                vc.modalPresentationStyle = .fullScreen

                let transition = CATransition()
                transition.duration = 0.4
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(vc, animated: false, completion: nil)
               }
               UserDefaults.standard.set(true, forKey: "isFirstLaunchHomeWorkout")
            
        } else if id == 3 {
            
            if !UserDefaults.standard.bool(forKey: "isFirstLaunchPostPregnancyRecovery") {
                    
                let vc = PreviewRecoveryViewController()
                vc.modalPresentationStyle = .fullScreen

                let transition = CATransition()
                transition.duration = 0.4
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(vc, animated: false, completion: nil)
                
               } else {
                let vc = MenuPostPregnancyRecoveryViewController()
                vc.modalPresentationStyle = .fullScreen

                let transition = CATransition()
                transition.duration = 0.4
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(vc, animated: false, completion: nil)
               }
               UserDefaults.standard.set(true, forKey: "isFirstLaunchPostPregnancyRecovery")
            
        } else if id == 4 {
            
            if !UserDefaults.standard.bool(forKey: "isFirstLaunchBodyGuide") {
                    
                let vc = PreviewBodyGuideViewController()
                vc.modalPresentationStyle = .fullScreen

                let transition = CATransition()
                transition.duration = 0.4
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(vc, animated: false, completion: nil)
                
               } else {
                let vc = MenuBodyGuideViewController()
                vc.modalPresentationStyle = .fullScreen

                let transition = CATransition()
                transition.duration = 0.4
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(vc, animated: false, completion: nil)
               }
               UserDefaults.standard.set(true, forKey: "isFirstLaunchBodyGuide")
        } else if id == 5 {
            
            if !UserDefaults.standard.bool(forKey: "isFirstLaunchTimerController") {
                    
                    let vc = PreviewTimerViewController()
                    vc.modalPresentationStyle = .fullScreen
                    
                    let transition = CATransition()
                    transition.duration = 0.4
                    transition.type = CATransitionType.push
                    transition.subtype = CATransitionSubtype.fromRight
                    transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                    self.view.window!.layer.add(transition, forKey: kCATransition)

                    self.present(vc, animated: false, completion: nil)
                
               } else {
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

                    let vc = mainStoryboard.instantiateViewController(withIdentifier: "TimerViewController")

                    vc.modalPresentationStyle = .fullScreen
                    present(vc, animated: true, completion: nil)
               }
               UserDefaults.standard.set(true, forKey: "isFirstLaunchTimerController")
            
        } else if id == 6 {
            if !UserDefaults.standard.bool(forKey: "isFirstLaunchTrainingComplex") {
                let vc = PreviewTrainingComplexViewController()
                vc.modalPresentationStyle = .fullScreen

                let transition = CATransition()
                transition.duration = 0.4
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(vc, animated: false, completion: nil)
                
            } else {
                
                let vc = HomeWorkoutTrainingComplexesViewController()
                vc.modalPresentationStyle = .fullScreen

                let transition = CATransition()
                transition.duration = 0.4
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(vc, animated: false, completion: nil)
            }
            UserDefaults.standard.set(true, forKey: "isFirstLaunchTrainingComplex")
        } else if id == 7 {
            if !UserDefaults.standard.bool(forKey: "isFirstLaunchFoodRation") {
                let vc = PreviewFoodRationViewController()
                vc.modalPresentationStyle = .fullScreen

                let transition = CATransition()
                transition.duration = 0.4
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(vc, animated: false, completion: nil)
                
            } else {
                
                let vc = MenuFoodRationViewController()
                vc.modalPresentationStyle = .fullScreen

                let transition = CATransition()
                transition.duration = 0.4
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(vc, animated: false, completion: nil)
            }
            UserDefaults.standard.set(true, forKey: "isFirstLaunchFoodRation")
        }
    }
    private func createCircleMenuItems(count: Int) -> [CircleMenuItemModel] {
        var menuModels = [CircleMenuItemModel]()
        for i in 0..<count {
            let menuModel = CircleMenuItemModel(id: i, imageSource: UIImage.init(named: icons[i]))
            menuModels.append(menuModel)
        }
        return menuModels
    }
}

//MARK: - ExtensionIronSource
extension StretchingMenuViewController: ISBannerDelegate, ISImpressionDataDelegate {
    
    func bannerDidLoad(_ bannerView: ISBannerView!) {
        self.bannerView = bannerView
        if #available(iOS 11.0, *) {
               
            if totalSize.height >= 801 {
                bannerView.frame = CGRect(x: 0, y: view.frame.size.height - 50, width: view.frame.size.width, height: 0)
                
            } else if totalSize.height <= 800 {
                bannerView.frame = CGRect(x: 0, y: view.frame.size.height - 50, width: view.frame.size.width, height: 0)
            }
        } else {
                bannerView.frame = CGRect(x: 0, y: view.frame.size.height - 50, width: view.frame.size.width, height: 0)
        }


        bannerView.backgroundColor = .clear
        bannerView.layer.zPosition = 100
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
