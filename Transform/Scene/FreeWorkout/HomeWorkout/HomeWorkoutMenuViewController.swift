//
//  WomenMuscleViewController.swift
//  Transform
//
//  Created by mac on 30.09.2020.
//

import UIKit
import SnapKit
import EGOCircleMenu

class HomeWorkoutMenuViewController: UIViewController, CircleMenuDelegate {

    let totalSize = UIScreen.main.bounds.size
    
    var icons = [String]()
    let submenuIds = [2]
    let showItemSegueId = "showItem"
    var selectedItemId: Int?
    
    //ironSource
    var bannerView: ISBannerView! = nil
    let kAPPKEY = "11dfcc91d"
    
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        backgroundImage.isHidden = false

        mainTitle.isHidden = false
        
        buttonFootMuscle.addTarget(self, action: #selector(buttonFootMuscleAction(sender:)), for: .touchUpInside)
        buttonCorMuscle.addTarget(self, action: #selector(buttonCorMuscleAction(sender:)), for: .touchUpInside)
        buttonHendMuscle.addTarget(self, action: #selector(buttonHendMuscleAction(sender:)), for: .touchUpInside)
        buttonHend2Muscle.addTarget(self, action: #selector(buttonHend2MuscleAction(sender:)), for: .touchUpInside)
        buttonShoulderMuscle.addTarget(self, action: #selector(buttonShoulderMuscleAction(sender:)), for: .touchUpInside)
        buttonBreastMuscle.addTarget(self, action: #selector(buttonBreastMuscleAction(sender:)), for: .touchUpInside)
        buttonBackMuscle.addTarget(self, action: #selector(buttonBackMuscleAction(sender:)), for: .touchUpInside)
        buttonGlutesMuscle.addTarget(self, action: #selector(buttonGlutesMuscleAction(sender:)), for: .touchUpInside)
        
        favoritesButton.addTarget(self, action: #selector(favoritesButtonAction(sender:)), for: .touchUpInside)
        
        setupUI()
        
        
        setupCircleMenu()
        
        //Notification
        NotificationCenter.default.addObserver(self, selector: #selector(HomeWorkoutMenuViewController.rotateCircleMenuLeft), name: NSNotification.Name(rawValue: "rotateCircleMenuLeft"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(HomeWorkoutMenuViewController.rotateCircleMenuRight), name: NSNotification.Name(rawValue: "rotateCircleMenuRight"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(HomeWorkoutMenuViewController.openCircleMenu), name: NSNotification.Name(rawValue: "openCircleMenu"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(HomeWorkoutMenuViewController.closeCircleMenu), name: NSNotification.Name(rawValue: "closeCircleMenu"), object: nil)
        
        //ads
        if !UserDefaults.standard.bool(forKey: "removeAdsPurchased") {
            setupIronSourceSdk()
            loadBanner()
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
//MARK: BackgroundImage
    lazy var backgroundImage: UIImageView = {
        var image = UIImageView(image: #imageLiteral(resourceName: "homeWorkoutBackground"))
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.layer.zPosition = 0
        image.alpha = 0.1
        self.view.addSubview(image)


        image.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(10)
    }
        return image
    }()
//MARK: MainTitle
    lazy var mainTitle: UILabel = {
        
        let positX: CGFloat!
        let sizeFnt: CGFloat!
        if totalSize.height >= 920 {
            positX = 70
            sizeFnt = 25
        } else if totalSize.height >= 830 && totalSize.height <= 919 {
            positX = 60
            sizeFnt = 25
        } else if totalSize.height == 812 {
            positX = 70
            sizeFnt = 20
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = 60
            sizeFnt = 20
        } else if totalSize.height <= 670 {
            positX = 40
            sizeFnt = 20
        } else {
            positX = 150
            sizeFnt = 20
        }
       let label = UILabel()
        label.text = "Жми на мышцы".localized()
        label.textColor = #colorLiteral(red: 0.556738019, green: 0.5565260053, blue: 0.577188611, alpha: 1)
        label.font = UIFont.systemFont(ofSize: sizeFnt)
        label.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.layer.shadowRadius = 5
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowOpacity = 0.3
        self.view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positX)
            make.centerX.equalToSuperview()
        }
        return label
    }()
//MARK: - FavoritesButton
    @objc lazy var favoritesButton: UIButton = {
        let positX: CGFloat!
        let leidTrail: CGFloat!
        if totalSize.height >= 830 {
            positX = 110
            leidTrail = 40
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = 70
            leidTrail = 25
        } else if totalSize.height <= 670 {
            positX = 35
            leidTrail = 25
        } else {
            positX = 90
            leidTrail = 30
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
        btn.layer.zPosition = 6
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.4
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
        
        if !UserDefaults.standard.bool(forKey: "isFirstLaunchFavoriteHomeWorkout") {
                
                destroyBanner()
            
                let vc = PreviewChosenHomeWorkoutViewController()
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

                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ChosenHomeWorkoutTableViewController")

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
           UserDefaults.standard.set(true, forKey: "isFirstLaunchFavoriteHomeWorkout")
        
    }
//MARK: - CircleMenu
    @objc func rotateCircleMenuLeft() {
        
        labelCircleMenuMoveRight.zoomOutCircleMenu()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
            if UserDefaults.standard.integer(forKey: "idCircleMenu") == 0 {
                self.labelCircleMenuMoveRight.text = "Стретчинг".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 1 {
                self.labelCircleMenuMoveRight.text = "Хатха Йога".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 2 {
                self.labelCircleMenuMoveRight.text = "Восстановление после родов".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 3 {
                self.labelCircleMenuMoveRight.text = "Body Guide".localized()
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
                self.labelCircleMenuMoveRight.text = "Стретчинг".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 1 {
                self.labelCircleMenuMoveRight.text = "Хатха Йога".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 2 {
                self.labelCircleMenuMoveRight.text = "Восстановление после родов".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 3 {
                self.labelCircleMenuMoveRight.text = "Body Guide".localized()
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
        labelCircleMenuMoveRight.text = "Хатха Йога".localized()
        
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
        lbl.text = "Хатха Йога".localized()
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
        icons.append(contentsOf: ["home", "stretching", "yoga", "baby", "bodyGuideIcon", "stopwatch", "complexIcon", "foodRationIcon", "icVideo", "home", "icHDR"])
        
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
            if !UserDefaults.standard.bool(forKey: "isFirstLaunchStretching") {
                    
                    let vc = PreviewStretchingViewController()
                    vc.modalPresentationStyle = .fullScreen
                    
                    let transition = CATransition()
                    transition.duration = 0.4
                    transition.type = CATransitionType.push
                    transition.subtype = CATransitionSubtype.fromRight
                    transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                    self.view.window!.layer.add(transition, forKey: kCATransition)

                    self.present(vc, animated: false, completion: nil)
                
               } else {
                    let vc = StretchingMenuViewController()
                    vc.modalPresentationStyle = .fullScreen
                    
                    let transition = CATransition()
                    transition.duration = 0.4
                    transition.type = CATransitionType.push
                    transition.subtype = CATransitionSubtype.fromRight
                    transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                    view.window!.layer.add(transition, forKey: kCATransition)

                    present(vc, animated: false, completion: nil)
               }
               UserDefaults.standard.set(true, forKey: "isFirstLaunchStretching")
        } else if id == 2 {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    private func createCircleMenuItems(count: Int) -> [CircleMenuItemModel] {
        var menuModels = [CircleMenuItemModel]()
        for i in 0..<count {
            let menuModel = CircleMenuItemModel(id: i, imageSource: UIImage.init(named: icons[i]))
            menuModels.append(menuModel)
        }
        return menuModels
    }
    
    func setupUI() {
        imagePhoto.isHidden = false
    }
//MARK: - ImagePhoto
    lazy var imagePhoto: UIImageView =  {
            var positX: CGFloat!
            var positY: CGFloat!
            var height: CGFloat!
            if totalSize.height >= 889 {
                height = 700
                positX = 15
                positY = 10
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                height = 650
                positX = 10
                positY = 10
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                height = 570
                positX = 15
                positY = 5
            } else if totalSize.height <= 670 {
                height = 530
                positX = 10
                positY = -5
             } else {
                height = 620
                positX = 10
                positY = 10
            }
            
            var image = UIImageView(image: #imageLiteral(resourceName: "womenMuscle"))
            image.clipsToBounds = true
            image.contentMode = .scaleAspectFit
            image.layer.zPosition = 0
            image.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            image.layer.shadowRadius = 5
            image.layer.shadowOffset = CGSize(width: 0, height: 0)
            image.layer.shadowOpacity = 0.4
            self.view.addSubview(image)


            image.snp.makeConstraints { make in
                make.centerXWithinMargins.equalTo(positX)
                make.centerYWithinMargins.equalTo(positY)
                make.height.equalTo(height)
        }
            return image
        }()
    
//MARK: CorButton
            @objc lazy var buttonCorMuscle: UIButton = {
                
                let hght: CGFloat!
                let wdth: CGFloat!
                let cnrtY: CGFloat!
                let cnrtX: CGFloat!
                if totalSize.height >= 920 {
                    hght = 65
                    wdth = 90
                    cnrtY = 375
                    cnrtX = 15
                } else if totalSize.height >= 890 && totalSize.height <= 919 {
                    hght = 70
                    wdth = 90
                    cnrtY = 360
                    cnrtX = 15
                } else if totalSize.height >= 830 && totalSize.height <= 889 {
                    hght = 60
                    wdth = 90
                    cnrtY = 340
                    cnrtX = 10
                 } else if totalSize.height >= 671 && totalSize.height <= 800 {
                    hght = 55
                    wdth = 75
                    cnrtY = 300
                    cnrtX = 15
                } else if totalSize.height <= 670 {
                    hght = 50
                    wdth = 75
                    cnrtY = 260
                    cnrtX = 10
                 } else {
                    hght = 55
                    wdth = 85
                    cnrtY = 325
                    cnrtX = 10
                }
                
                let btn = UIButton()
                btn.setTitle("", for: .normal)
//                btn.alpha = 0.3
                btn.backgroundColor = .clear
                btn.layer.cornerRadius = 25
                btn.layer.zPosition = 2
                self.view.addSubview(btn)

                btn.snp.makeConstraints { make in
                    make.centerXWithinMargins.equalTo(cnrtX)
                    make.centerY.equalTo(cnrtY)
                    make.height.equalTo(hght)
                    make.width.equalTo(wdth)
                }
                
                return btn
            }()
            
            @objc func buttonCorMuscleAction(sender: UIButton) {

                destroyBanner()
                UserDefaults.standard.set(4, forKey: "choiceMuscle")
                
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeWorkoutTableViewController")

                viewController.modalPresentationStyle = .fullScreen

                let transition = CATransition()
                transition.duration = 0.4
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(viewController, animated: false, completion: nil)
                
            }
//MARK: BreastButton
                @objc lazy var buttonBreastMuscle: UIButton = {
                    
                    let hght: CGFloat!
                    let wdth: CGFloat!
                    let cnrtX: CGFloat!
                    let cnrtY: CGFloat!
                    if totalSize.height >= 920 {
                        hght = 75
                        wdth = 110
                        cnrtX = 230
                        cnrtY = 305
                    } else if totalSize.height >= 890 && totalSize.height <= 919 {
                        hght = 80
                        wdth = 110
                        cnrtX = 225
                        cnrtY = 285
                    } else if totalSize.height >= 830 && totalSize.height <= 889 {
                        hght = 80
                        wdth = 100
                        cnrtX = 205
                        cnrtY = 265
                     } else if totalSize.height >= 671 && totalSize.height <= 800 {
                        hght = 55
                        wdth = 90
                        cnrtX = 225
                        cnrtY = 245
                    } else if totalSize.height <= 670 {
                        hght = 55
                        wdth = 90
                        cnrtX = 200
                        cnrtY = 210
                     } else {
                        hght = 60
                        wdth = 95
                        cnrtX = 200
                        cnrtY = 265
                    }
                    
                    let btn = UIButton()
                    btn.setTitle("", for: .normal)
//                    btn.alpha = 0.3
                    btn.backgroundColor = .clear
                    btn.layer.cornerRadius = 25
                    btn.layer.zPosition = 3
                    self.view.addSubview(btn)

                    btn.snp.makeConstraints { make in
                        make.centerX.equalTo(cnrtX)
                        make.centerY.equalTo(cnrtY)
                        make.height.equalTo(hght)
                        make.width.equalTo(wdth)
                    }
                    
                    return btn
                }()
                
                @objc func buttonBreastMuscleAction(sender: UIButton) {

                    destroyBanner()
                    UserDefaults.standard.set(1, forKey: "choiceMuscle")
                    
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeWorkoutTableViewController")
                    
                    viewController.modalPresentationStyle = .fullScreen

                    let transition = CATransition()
                    transition.duration = 0.4
                    transition.type = CATransitionType.push
                    transition.subtype = CATransitionSubtype.fromRight
                    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
                    view.window!.layer.add(transition, forKey: kCATransition)

                    present(viewController, animated: false, completion: nil)
                }
//MARK: ShoulderButton
                @objc lazy var buttonShoulderMuscle: UIButton = {
                    
                    let hght: CGFloat!
                    let wdth: CGFloat!
                    let cnrtX: CGFloat!
                    let cnrtY: CGFloat!
                    if totalSize.height >= 920 {
                        hght = 65
                        wdth = 175
                        cnrtX = 235
                        cnrtY = 285
                    } else if totalSize.height >= 890 && totalSize.height <= 919 {
                        hght = 65
                        wdth = 170
                        cnrtX = 225
                        cnrtY = 270
                    } else if totalSize.height >= 830 && totalSize.height <= 889 {
                        hght = 60
                        wdth = 160
                        cnrtX = 210
                        cnrtY = 255
                     } else if totalSize.height >= 671 && totalSize.height <= 800 {
                        hght = 50
                        wdth = 140
                        cnrtX = 225
                        cnrtY = 220
                    } else if totalSize.height <= 670 {
                        hght = 45
                        wdth = 140
                        cnrtX = 200
                        cnrtY = 190
                     } else {
                        hght = 50
                        wdth = 155
                        cnrtX = 200
                        cnrtY = 245
                    }
                    
                    let btn = UIButton()
                    btn.setTitle("", for: .normal)
//                    btn.alpha = 0.3
                    btn.backgroundColor = .clear
                    btn.layer.cornerRadius = 25
                    btn.layer.zPosition = 2
                    self.view.addSubview(btn)

                    btn.snp.makeConstraints { make in
                        make.centerX.equalTo(cnrtX)
                        make.centerY.equalTo(cnrtY)
                        make.height.equalTo(hght)
                        make.width.equalTo(wdth)
                    }
                    
                    return btn
                }()
                
                @objc func buttonShoulderMuscleAction(sender: UIButton) {

                    destroyBanner()
                    UserDefaults.standard.set(2, forKey: "choiceMuscle")
                    
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeWorkoutTableViewController")
                    
                    viewController.modalPresentationStyle = .fullScreen

                    let transition = CATransition()
                    transition.duration = 0.4
                    transition.type = CATransitionType.push
                    transition.subtype = CATransitionSubtype.fromRight
                    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
                    view.window!.layer.add(transition, forKey: kCATransition)

                    present(viewController, animated: false, completion: nil)
                }
//MARK: HendButton
                @objc lazy var buttonHendMuscle: UIButton = {
                    
                    let hght: CGFloat!
                    let wdth: CGFloat!
                    let cnrtX: CGFloat!
                    let cnrtY: CGFloat!
                    if totalSize.height >= 920 {
                        hght = 150
                        wdth = 50
                        cnrtX = 315
                        cnrtY = 375
                    } else if totalSize.height >= 890 && totalSize.height <= 919 {
                        hght = 160
                        wdth = 40
                        cnrtX = 310
                        cnrtY = 370
                    } else if totalSize.height >= 830 && totalSize.height <= 889 {
                        hght = 150
                        wdth = 40
                        cnrtX = 285
                        cnrtY = 360
                     } else if totalSize.height >= 671 && totalSize.height <= 800 {
                        hght = 150
                        wdth = 40
                        cnrtX = 295
                        cnrtY = 300
                    } else if totalSize.height <= 670 {
                        hght = 135
                        wdth = 35
                        cnrtX = 265
                        cnrtY = 270
                     } else {
                        hght = 150
                        wdth = 40
                        cnrtX = 275
                        cnrtY = 330
                    }
                    
                    let btn = UIButton()
                    btn.setTitle("", for: .normal)
//                    btn.alpha = 0.3
                    btn.backgroundColor = .clear
                    btn.layer.cornerRadius = 25
                    btn.layer.zPosition = 1
                    self.view.addSubview(btn)

                    btn.snp.makeConstraints { make in
                        make.centerX.equalTo(cnrtX)
                        make.centerY.equalTo(cnrtY)
                        make.height.equalTo(hght)
                        make.width.equalTo(wdth)
                    }
                    
                    return btn
                }()
                
                @objc func buttonHendMuscleAction(sender: UIButton) {

                    destroyBanner()
                    UserDefaults.standard.set(3, forKey: "choiceMuscle")
                    
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeWorkoutTableViewController")
                    
                    viewController.modalPresentationStyle = .fullScreen

                    let transition = CATransition()
                    transition.duration = 0.4
                    transition.type = CATransitionType.push
                    transition.subtype = CATransitionSubtype.fromRight
                    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
                    view.window!.layer.add(transition, forKey: kCATransition)

                    present(viewController, animated: false, completion: nil)
                }
//MARK: Hend2Button
                @objc lazy var buttonHend2Muscle: UIButton = {
                    
                    let hght: CGFloat!
                    let wdth: CGFloat!
                    let cnrtX: CGFloat!
                    let cnrtY: CGFloat!
                    if totalSize.height >= 920 {
                        hght = 90
                        wdth = 50
                        cnrtX = 150
                        cnrtY = 345
                    } else if totalSize.height >= 890 && totalSize.height <= 919 {
                        hght = 100
                        wdth = 55
                        cnrtX = 140
                        cnrtY = 330
                    } else if totalSize.height >= 830 && totalSize.height <= 889 {
                        hght = 100
                        wdth = 50
                        cnrtX = 130
                        cnrtY = 325
                     } else if totalSize.height >= 671 && totalSize.height <= 800 {
                        hght = 80
                        wdth = 40
                        cnrtX = 155
                        cnrtY = 275
                    } else if totalSize.height <= 670 {
                        hght = 80
                        wdth = 40
                        cnrtX = 140
                        cnrtY = 240
                     } else {
                        hght = 90
                        wdth = 50
                        cnrtX = 130
                        cnrtY = 305
                    }
                    
                    let btn = UIButton()
                    btn.setTitle("", for: .normal)
//                    btn.alpha = 0.3
                    btn.backgroundColor = .clear
                    btn.layer.cornerRadius = 25
                    btn.layer.zPosition = 1
                    self.view.addSubview(btn)

                    btn.snp.makeConstraints { make in
                        make.centerX.equalTo(cnrtX)
                        make.centerY.equalTo(cnrtY)
                        make.height.equalTo(hght)
                        make.width.equalTo(wdth)
                    }
                    
                    return btn
                }()
                
                @objc func buttonHend2MuscleAction(sender: UIButton) {

                    destroyBanner()
                    UserDefaults.standard.set(3, forKey: "choiceMuscle")
                    
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeWorkoutTableViewController")
                    
                    viewController.modalPresentationStyle = .fullScreen

                    let transition = CATransition()
                    transition.duration = 0.4
                    transition.type = CATransitionType.push
                    transition.subtype = CATransitionSubtype.fromRight
                    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
                    view.window!.layer.add(transition, forKey: kCATransition)

                    present(viewController, animated: false, completion: nil)
                }
//MARK: FootButton
            @objc lazy var buttonFootMuscle: UIButton = {
                
                let hght: CGFloat!
                let wdth: CGFloat!
                let cnrtX: CGFloat!
                let cnrtY: CGFloat!
                if totalSize.height >= 920 {
                    hght = 290
                    wdth = 130
                    cnrtX = 225
                    cnrtY = 560
                } else if totalSize.height >= 890 && totalSize.height <= 919 {
                    hght = 290
                    wdth = 130
                    cnrtX = 220
                    cnrtY = 560
                } else if totalSize.height >= 830 && totalSize.height <= 889 {
                    hght = 280
                    wdth = 120
                    cnrtX = 205
                    cnrtY = 520
                 } else if totalSize.height >= 671 && totalSize.height <= 800 {
                    hght = 220
                    wdth = 100
                    cnrtX = 220
                    cnrtY = 445
                } else if totalSize.height <= 670 {
                    hght = 220
                    wdth = 100
                    cnrtX = 195
                    cnrtY = 410
                 } else {
                    hght = 260
                    wdth = 120
                    cnrtX = 200
                    cnrtY = 505
                }
                
                let btn = UIButton()
                btn.setTitle("", for: .normal)
                btn.backgroundColor = .clear
//                btn.alpha = 0.3
                btn.layer.cornerRadius = 25
                btn.layer.zPosition = 2
                self.view.addSubview(btn)

                btn.snp.makeConstraints { make in
                    make.centerX.equalTo(cnrtX)
                    make.centerY.equalTo(cnrtY)
                    make.height.equalTo(hght)
                    make.width.equalTo(wdth)
                }
                
                return btn
            }()
            
            @objc func buttonFootMuscleAction(sender: UIButton) {

                destroyBanner()
                UserDefaults.standard.set(5, forKey: "choiceMuscle")
                
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeWorkoutTableViewController")
                
                viewController.modalPresentationStyle = .fullScreen

                let transition = CATransition()
                transition.duration = 0.4
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(viewController, animated: false, completion: nil)
            }
//MARK: BackButton
                @objc lazy var buttonBackMuscle: UIButton = {
                    
                    let positY: CGFloat!
                     if totalSize.height >= 830 {
                        positY = 200
                     } else if totalSize.height >= 671 && totalSize.height <= 800 {
                        positY = 200
                     } else if totalSize.height <= 671 {
                        positY = 150
                     } else {
                        positY = 200
                     }
                    
                    let btn = UIButton()
                    btn.setTitle("Спина".localized(), for: .normal)
                    btn.tintColor = .white
                    btn.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1) //.systemGray
                    btn.layer.cornerRadius = 20
                    btn.layer.zPosition = 1
                    btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    btn.layer.shadowRadius = 5
                    btn.layer.shadowOffset = CGSize(width: 0, height: 0)
                    btn.layer.shadowOpacity = 0.4
                    self.view.addSubview(btn)

                    btn.snp.makeConstraints { make in
                        make.centerX.equalTo(70)
                        make.centerY.equalTo(positY)
                        make.height.equalTo(40)
                        make.width.equalTo(100)
                    }
                    
                    return btn
                }()
                
                @objc func buttonBackMuscleAction(sender: UIButton) {

                    destroyBanner()
                    UserDefaults.standard.set(6, forKey: "choiceMuscle")
                    
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeWorkoutTableViewController")
                    
                    viewController.modalPresentationStyle = .fullScreen

                    let transition = CATransition()
                    transition.duration = 0.4
                    transition.type = CATransitionType.push
                    transition.subtype = CATransitionSubtype.fromRight
                    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
                    view.window!.layer.add(transition, forKey: kCATransition)

                    present(viewController, animated: false, completion: nil)
                }
//MARK: GlutesButton
                @objc lazy var buttonGlutesMuscle: UIButton = {
                    
                    let positY: CGFloat!
                    let positX: CGFloat!
                    
                    
                     if totalSize.height >= 890 {
                        positY = 550
                        positX = 80
                     } else if totalSize.height >= 830 && totalSize.height <= 889 {
                        positY = 540
                        positX = 75
                     } else if totalSize.height >= 671 && totalSize.height <= 800 {
                        positY = 370
                        positX = 75
                     } else if totalSize.height <= 670 {
                        positY = 410
                        positX = 75
                     } else {
                        positY = 520
                        positX = 70
                     }
                    
                    let btn = UIButton()
                    btn.setTitle("Ягодицы".localized(), for: .normal)
                    btn.tintColor = .white
                    btn.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1) //.systemGray
                    btn.layer.cornerRadius = 20
                    btn.layer.zPosition = 1
                    btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    btn.layer.shadowRadius = 5
                    btn.layer.shadowOffset = CGSize(width: 0, height: 0)
                    btn.layer.shadowOpacity = 0.4
                    self.view.addSubview(btn)

                    btn.snp.makeConstraints { make in
                        make.centerX.equalTo(positX)
                        make.centerY.equalTo(positY)
                        make.height.equalTo(40)
                        make.width.equalTo(120)
                    }
                    
                    return btn
                }()
                
                @objc func buttonGlutesMuscleAction(sender: UIButton) {

                    destroyBanner()
                    UserDefaults.standard.set(7, forKey: "choiceMuscle")
                    
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeWorkoutTableViewController")
                    
                    viewController.modalPresentationStyle = .fullScreen

                    let transition = CATransition()
                    transition.duration = 0.4
                    transition.type = CATransitionType.push
                    transition.subtype = CATransitionSubtype.fromRight
                    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
                    view.window!.layer.add(transition, forKey: kCATransition)

                    present(viewController, animated: false, completion: nil)
                }
}

//MARK: - ExtensionIronSource
extension HomeWorkoutMenuViewController: ISBannerDelegate, ISImpressionDataDelegate {
    
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
