//
//  PreviewBodyGuideViewController.swift
//  Transform
//
//  Created by Pavel Lyutikov on 09.05.2021.
//

import UIKit
import EGOCircleMenu
import StoreKit
import SwiftyStoreKit

class MenuBodyGuideViewController: UIViewController, CircleMenuDelegate {
    
    let totalSize = UIScreen.main.bounds.size
    
    var icons = [String]()
    let submenuIds = [2]
    let showItemSegueId = "showItem"
    var selectedItemId: Int?
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        backgroundImage.isHidden = false
        whiteBackgroundView.isHidden = false
        infoBodyGuide.isHidden = false
        mainTitle.isHidden = false
        subTitle.isHidden = false
        
        setupActivityIndicator()
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()

        
        if !UserDefaults.standard.bool(forKey: "guide_purchased") {
            
            buttonBuyBodyGuide.addTarget(self, action: #selector(actionBuyBodyGuide(sender:)), for: .touchUpInside)
            
            buttonRestoredPurchase.addTarget(self, action: #selector(actionButtonRestoredPurchase(sender:)), for: .touchUpInside)
            
            let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: "56e3e9f9829043bb8e404111d191ae2b")
            SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
                switch result {
                case .success(let receipt):
                    let productId = "com.transform.fitness.bodyGuide"
                    // Verify the purchase of Consumable or NonConsumable
                    let purchaseResult = SwiftyStoreKit.verifyPurchase(
                        productId: productId,
                        inReceipt: receipt)
                        
                    switch purchaseResult {
                    case .purchased(let receiptItem):
                        UserDefaults.standard.set(true, forKey: "guide_purchased")
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "successfulPurchaseBodyGuide"), object: nil)
                        
                        print("\(productId) is purchased: \(receiptItem)")
                    case .notPurchased:
                        
                        print("The user has never purchased \(productId)")
                    }
                case .error(let error):
                    
                    print("Receipt verification failed: \(error)")
                }
                self.activityIndicator.stopAnimating()
            }
        
        } else {
            buttonRideBodyGuide.addTarget(self, action: #selector(actionRideBodyGuide(sender:)), for: .touchUpInside)
            
            activityIndicator.stopAnimating()
        }
        
        setupCircleMenu()
        
        //SuccessfulPurchase
        NotificationCenter.default.addObserver(self, selector: #selector(MenuBodyGuideViewController.successfulPurchase), name: NSNotification.Name(rawValue: "successfulPurchaseBodyGuide"), object: nil)

        //Notification
        NotificationCenter.default.addObserver(self, selector: #selector(MenuBodyGuideViewController.rotateCircleMenuLeft), name: NSNotification.Name(rawValue: "rotateCircleMenuLeft"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MenuBodyGuideViewController.rotateCircleMenuRight), name: NSNotification.Name(rawValue: "rotateCircleMenuRight"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MenuBodyGuideViewController.openCircleMenu), name: NSNotification.Name(rawValue: "openCircleMenu"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MenuBodyGuideViewController.closeCircleMenu), name: NSNotification.Name(rawValue: "closeCircleMenu"), object: nil)
        
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            switch Locale.current.languageCode {
            case "ru":
                print("")
                
            case "en":
                let alert = UIAlertController(title: "Info", message: "This section has not yet been translated into your language", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { action in
                    
                    
                }))
                self.present(alert, animated: true, completion: nil)
                
            default:
                let alert = UIAlertController(title: "Info", message: "This section has not yet been translated into your language", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { action in
                    
                    
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
//MARK: - SuccessfulPurchase
    @objc func successfulPurchase() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            self.buttonBuyBodyGuide.isHidden = true
            self.buttonRestoredPurchase.isHidden = true
            self.buttonRideBodyGuide.addTarget(self, action: #selector(self.actionRideBodyGuide(sender:)), for: .touchUpInside)
            
        }
    }
//MARK: - ActivityIndicator
    private func setupActivityIndicator(){
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        activityIndicator.center = self.view.center
        activityIndicator.style = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = #colorLiteral(red: 0.9967606664, green: 0.8057011962, blue: 0.631778121, alpha: 1)
        activityIndicator.layer.cornerRadius = 15
        activityIndicator.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        activityIndicator.layer.shadowRadius = 3
        activityIndicator.layer.shadowOffset = CGSize(width: 0, height: 0)
        activityIndicator.layer.shadowOpacity = 0.4
        activityIndicator.layer.zPosition = 30
    }
//MARK: - MainTitle
    lazy var mainTitle: UILabel = {
        let positX: CGFloat!
        let fontSize: CGFloat!
        if totalSize.height >= 830 {
            positX = 55
            fontSize = 45
        } else if totalSize.height == 812 {
            positX = 45
            fontSize = 35
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = 20
            fontSize = 35
        } else if totalSize.height <= 670 {
            positX = 22
            fontSize = 35
        } else {
            positX = 55
            fontSize = 40
        }
        
       let label = UILabel()
        label.text = "Body Guide"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: fontSize)
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
    lazy var subTitle: UILabel = {
        
        let positX: CGFloat!
        let fontSize: CGFloat!
        if totalSize.height >= 830 {
            positX = 110
            fontSize = 24
        } else if totalSize.height == 812 {
            positX = 95
            fontSize = 20
        } else if totalSize.height <= 800 {
            positX = 65
            fontSize = 20
        } else {
            positX = 110
            fontSize = 24
        }
        
       let label = UILabel()
        label.text = "ГИД ДЛЯ ЖЕНЩИН"
        label.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.layer.shadowRadius = 5
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowOpacity = 0.3
        label.textAlignment = .center
        label.numberOfLines = 10
        self.view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positX)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(40)
        }
        return label
    }()
//MARK: - InfoBodyGuide
    lazy var infoBodyGuide: UIImageView = {
        var leadTrail: CGFloat!
        var topPosit: CGFloat!
        if totalSize.height >= 920 {
            leadTrail = 20
            topPosit = -265
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            leadTrail = 20
            topPosit = -280
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            leadTrail = 30
            topPosit = -300
        } else if totalSize.height == 812 {
            leadTrail = 20
            topPosit = -320
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            leadTrail = 40
            topPosit = -360
        } else if totalSize.height <= 670 {
            leadTrail = 40
            topPosit = -390
        } else {
            leadTrail = 20
            topPosit = -280
        }
        
        let img = UIImageView(image: #imageLiteral(resourceName: "previewBodyGuide"))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 8
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.5
        self.view.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(topPosit)
            make.leading.trailing.equalToSuperview().inset(leadTrail)
        }
        
        return img
    }()
//MARK: - WhiteBackgroundView
    lazy var whiteBackgroundView: UIImageView = {
        var leadTrail: CGFloat!
        var topPosit: CGFloat!
        var height: CGFloat!
        if totalSize.height >= 920 {
            leadTrail = 10
            topPosit = 160
            height = 480
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            leadTrail = 10
            topPosit = 150
            height = 470
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            leadTrail = 20
            topPosit = 160
            height = 410
        } else if totalSize.height == 812 {
            leadTrail = 10
            topPosit = 135
            height = 420
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            leadTrail = 30
            topPosit = 100
            height = 410
        } else if totalSize.height <= 670 {
            leadTrail = 30
            topPosit = 95
            height = 360
        } else {
            leadTrail = 10
            topPosit = 150
            height = 470
        }
        
        let img = UIImageView(image: #imageLiteral(resourceName: "whiteBackgroundView"))
        img.contentMode = .scaleToFill
        img.alpha = 0.4
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 8
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.5
        self.view.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(topPosit)
            make.leading.trailing.equalToSuperview().inset(leadTrail)
            make.height.equalTo(height)
        }
        
        return img
    }()
//MARK: - ButtonWrideBodyGuide
    lazy var buttonRideBodyGuide: UIButton = {
        var width: CGFloat!
        var bttmPosit: CGFloat!
        var height: CGFloat!
        if totalSize.height >= 920 {
            width = 100
            bttmPosit = 110
            height = 140
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            width = 100
            bttmPosit = 110
            height = 140
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            width = 100
            bttmPosit = 110
            height = 140
        } else if totalSize.height == 812 {
            width = 90
            bttmPosit = 100
            height = 130
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            width = 80
            bttmPosit = 90
            height = 120
        } else if totalSize.height <= 670 {
            width = 80
            bttmPosit = 80
            height = 115
        } else {
            width = 100
            bttmPosit = 110
            height = 140
        }
        
        let btn = UIButton()
        btn.setBackgroundImage(#imageLiteral(resourceName: "bodyGuideBook"), for: .normal)
        btn.layer.cornerRadius = 15
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.8
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(bttmPosit)
            make.width.equalTo(width)
            make.height.equalTo(height)
            make.centerX.equalToSuperview()
        }
        
        return btn
    }()
    @objc func actionRideBodyGuide(sender: UIButton) {
            
            let vc = BodyGuideViewController()
            vc.modalPresentationStyle = .fullScreen

            let transition = CATransition()
            transition.duration = 0.4
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
            view.window!.layer.add(transition, forKey: kCATransition)

            present(vc, animated: false, completion: nil)
    }
//MARK: - ButtonBuyBodyGuide
    @objc lazy var buttonBuyBodyGuide: UIButton = {
        var width: CGFloat!
        var bttmPosit: CGFloat!
        var height: CGFloat!
        if totalSize.height >= 920 {
            width = 200
            bttmPosit = 40
            height = 280
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            width = 200
            bttmPosit = 40
            height = 280
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            width = 200
            bttmPosit = 40
            height = 280
        } else if totalSize.height == 812 {
            width = 180
            bttmPosit = 40
            height = 260
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            width = 170
            bttmPosit = 40
            height = 230
        } else if totalSize.height <= 670 {
            width = 170
            bttmPosit = 30
            height = 230
        } else {
            width = 200
            bttmPosit = 40
            height = 280
        }
        let btn = UIButton()
//        switch Locale.current.languageCode {
//        case "ru":
//            btn.setImage(#imageLiteral(resourceName: "bodyGuidePriceRus"), for: .normal)
//        default:
//            btn.setImage(#imageLiteral(resourceName: "bodyGuidePriceRus"), for: .normal)
//        }
        btn.setImage(#imageLiteral(resourceName: "bodyGuidePriceRus"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.8
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(bttmPosit)
            make.height.equalTo(height)
            make.leading.trailing.equalToSuperview().inset(100)
        }
        
        return btn
    }()
    @objc func actionBuyBodyGuide(sender: UIButton) {
        
        activityIndicator.startAnimating()
        
        SwiftyStoreKit.purchaseProduct("com.transform.fitness.bodyGuide", quantity: 1, atomically: true) { result in
            switch result {
            case .success(let purchase):

                UserDefaults.standard.set(true, forKey: "guide_purchased")

                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "successfulPurchaseBodyGuide"), object: nil)

                print("Purchase Success: \(purchase.productId)")

            case .error(let error):
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                case .clientInvalid: print("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                default: print((error as NSError).localizedDescription)
                }
            }

            self.activityIndicator.stopAnimating()
        }
    }
//MARK: - ButtonRestoredPurchase
    lazy var buttonRestoredPurchase: UIButton = {
        var width: CGFloat!
        var bttmPosit: CGFloat!
        var height: CGFloat!
        var lead: CGFloat!
        if totalSize.height >= 920 {
            width = 50
            bttmPosit = 150
            height = 50
            lead = 30
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            width = 50
            bttmPosit = 150
            height = 50
            lead = 30
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            width = 50
            bttmPosit = 150
            height = 50
            lead = 20
        } else if totalSize.height == 812 {
            width = 50
            bttmPosit = 140
            height = 50
            lead = 20
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            width = 50
            bttmPosit = 125
            height = 50
            lead = 35
        } else if totalSize.height <= 670 {
            width = 50
            bttmPosit = 120
            height = 50
            lead = 30
        } else {
            width = 50
            bttmPosit = 150
            height = 50
            lead = 30
        }
        
        let btn = UIButton()
        btn.setBackgroundImage(#imageLiteral(resourceName: "restore"), for: .normal)
        btn.layer.cornerRadius = 15
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.8
        btn.layer.zPosition = 10
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(bttmPosit)
            make.width.equalTo(width)
            make.height.equalTo(height)
            make.leading.equalToSuperview().inset(lead)
        }
        
        return btn
    }()
    @objc func actionButtonRestoredPurchase(sender: UIButton) {
        
        activityIndicator.startAnimating()
        
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            if results.restoreFailedPurchases.count > 0 {
                self.showErrorRestoreAlert()
                
                print("Restore Failed: \(results.restoreFailedPurchases)")
            } else if results.restoredPurchases.count > 0 {
                
                let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: "56e3e9f9829043bb8e404111d191ae2b")
                SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
                    switch result {
                    case .success(let receipt):
                        let productId = "com.transform.fitness.bodyGuide"
                        // Verify the purchase of Consumable or NonConsumable
                        let purchaseResult = SwiftyStoreKit.verifyPurchase(
                            productId: productId,
                            inReceipt: receipt)
                            
                        switch purchaseResult {
                        case .purchased(let receiptItem):
                            UserDefaults.standard.set(true, forKey: "guide_purchased")
                            
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "successfulPurchaseBodyGuide"), object: nil)
                            
                            print("\(productId) is purchased: \(receiptItem)")
                        case .notPurchased:
                            self.showErrorRestoreAlert()
                            
                            print("The user has never purchased \(productId)")
                        }
                    case .error(let error):
                        self.showErrorRestoreAlert()
                        
                        print("Receipt verification failed: \(error)")
                    }
                    self.activityIndicator.stopAnimating()
                }
                print("Restore Success: \(results.restoredPurchases)")
                
            } else {
                self.showErrorRestoreAlert()
                
                print("Nothing to Restore")
            }
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func showErrorRestoreAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "При восстановлении покупки произошла ошибка. Либо её срок действия истек, либо она не была приобретена", preferredStyle: .alert)
            
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        present(alert, animated: true, completion: nil)
    }
//MARK: BackgroundImage
    lazy var backgroundImage: UIImageView = {
        var image = UIImageView(image: #imageLiteral(resourceName: "backgroundGuide"))
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.layer.zPosition = 0
        image.alpha = 0.25
        self.view.addSubview(image)


        image.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(10)
    }
        return image
    }()
//MARK: - CircleMenu
    @objc func rotateCircleMenuLeft() {
        
        labelCircleMenuMoveRight.zoomOutCircleMenu()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
            if UserDefaults.standard.integer(forKey: "idCircleMenu") == 0 {
                self.labelCircleMenuMoveRight.text = "Стретчинг".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 1 {
                self.labelCircleMenuMoveRight.text = "Хатха Йога".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 2 {
                self.labelCircleMenuMoveRight.text = "Фитнес дома".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 3 {
                self.labelCircleMenuMoveRight.text = "Восстановление после родов".localized()
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
                self.labelCircleMenuMoveRight.text = "Фитнес дома".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 3 {
                self.labelCircleMenuMoveRight.text = "Восстановление после родов".localized()
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
        icons.append(contentsOf: ["home", "stretching", "yoga", "dumbbell", "baby", "stopwatch", "complexIcon", "foodRationIcon", "icTimer", "icVideo", "home", "icHDR"])

        let circleMenu = CircleMenu()
        circleMenu.layer.zPosition = 101
        circleMenu.attach(to: self)
        circleMenu.delegate = self
        circleMenu.circleMenuItems = createCircleMenuItems(count: 8)
        
        let positionY: CGFloat!
        let positionX: CGFloat!
        if totalSize.height >= 920 {
            positionY = -220
            positionX = 50
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positionY = -220
            positionX = 50
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positionY = -220
            positionX = 20
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positionY = -220
            positionX = 40
        } else if totalSize.height <= 670 {
            positionY = -220
            positionX = 10
        } else {
            positionY = -220
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
        
        if id == 0 {
            
            let vc = MainViewController()
            vc.modalPresentationStyle = .fullScreen

            let transition = CATransition()
            transition.duration = 0.4
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
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
            
        } else if id == 4 {
            
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
