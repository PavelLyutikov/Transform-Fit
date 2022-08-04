//
//  PreviewPremiumViewController.swift
//  Transform
//
//  Created by Pavel Lyutikov on 18.06.2021.
//

import UIKit
import SafariServices
import SwiftyStoreKit

class PreviewPremiumViewController: UIViewController {

    let totalSize = UIScreen.main.bounds.size
    
//    private let sharedSecret = "56e3e9f9829043bb8e404111d191ae2b"
//    private let productID = "com.transform.fitness.premium"
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupActivityIndicator()
        view.addSubview(activityIndicator)
        
        mainImage.isHidden = false
        mainTitle.isHidden = false
        
        viewOne.isHidden = false
        imageOne.isHidden = false
        labelOne.isHidden = false
        viewTwo.isHidden = false
        imageTwo.isHidden = false
        labelTwo.isHidden = false
        viewThree.isHidden = false
        imageThree.isHidden = false
        labelThree.isHidden = false
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            self.viewOne.alphaLeft()
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (timer) in
            self.viewTwo.alphaLeft()
        }
        
        Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { (timer) in
            self.viewThree.alphaLeft()
        }
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (timer) in
            self.nextButton.alpha()
        }
        
        
        if !UserDefaults.standard.bool(forKey: "removeAdsPurchased") {
            
            let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: "56e3e9f9829043bb8e404111d191ae2b")
            SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
                switch result {
                case .success(let receipt):
                    let productId = "com.transform.fitness.premium"
                    // Verify the purchase of Consumable or NonConsumable
                    let purchaseResult = SwiftyStoreKit.verifyPurchase(
                        productId: productId,
                        inReceipt: receipt)
                        
                    switch purchaseResult {
                    case .purchased(let receiptItem):
                        self.buttonBuyPremiumPurchased.addTarget(self, action: #selector(self.actionBuyPremiumPurchased(sender:)), for: .touchUpInside)
                        
                        print("\(productId) is purchased: \(receiptItem)")
                    case .notPurchased:
                        self.buttonBuyPremium.addTarget(self, action: #selector(self.actionBuyPremium(sender:)), for: .touchUpInside)
                        self.restoreButton.addTarget(self, action: #selector(self.buttonRestoreAction(sender:)), for: .touchUpInside)
                        
                        print("The user has never purchased \(productId)")
                    }
                case .error(let error):
                    self.buttonBuyPremium.addTarget(self, action: #selector(self.actionBuyPremium(sender:)), for: .touchUpInside)
                    self.restoreButton.addTarget(self, action: #selector(self.buttonRestoreAction(sender:)), for: .touchUpInside)
                    
                    print("Receipt verification failed: \(error)")
                }
                self.activityIndicator.stopAnimating()
            }
        
        } else {
            self.buttonBuyPremiumPurchased.addTarget(self, action: #selector(self.actionBuyPremiumPurchased(sender:)), for: .touchUpInside)
            
            self.activityIndicator.stopAnimating()
        }
        
        
        politickButton.addTarget(self, action: #selector(buttonPolitickAction(sender:)), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(actionNextButton(sender:)), for: .touchUpInside)
        
        //SuccessfulPurchase
        NotificationCenter.default.addObserver(self, selector: #selector(PreviewPremiumViewController.successfulPurchase), name: NSNotification.Name(rawValue: "successfulPurchasePremium"), object: nil)
    }
    //MARK: - SuccessfulPurchase
        @objc func successfulPurchase() {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                self.buttonBuyPremium.isHidden = true
                self.restoreButton.isHidden = true
                
                self.buttonBuyPremiumPurchased.addTarget(self, action: #selector(self.actionBuyPremiumPurchased(sender:)), for: .touchUpInside)
                
            }
        }
//MARK: - ActivityIndicator
    private func setupActivityIndicator(){
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        activityIndicator.center = self.view.center
        activityIndicator.style = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = #colorLiteral(red: 0.4889930484, green: 0.4889930484, blue: 0.4889930484, alpha: 1)
        activityIndicator.layer.cornerRadius = 15
        activityIndicator.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        activityIndicator.layer.shadowRadius = 3
        activityIndicator.layer.shadowOffset = CGSize(width: 0, height: 0)
        activityIndicator.layer.shadowOpacity = 0.4
        activityIndicator.layer.zPosition = 30
    }
//MARK: - MainTitle/Image
    lazy var mainImage: UIImageView = {
        var width: CGFloat!
        var topPosit: CGFloat!
        if totalSize.height >= 920 {
            width = 150
            topPosit = -130
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            width = 150
            topPosit = -130
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            width = 150
            topPosit = -130
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            width = 150
            topPosit = -170
        } else if totalSize.height <= 670 {
            width = 120
            topPosit = -180
        } else {
            width = 150
            topPosit = -150
        }
        
        let img = UIImageView(image: #imageLiteral(resourceName: "crown"))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 5
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.3
        self.view.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(topPosit)
            make.width.equalTo(width)
        }
        
        return img
    }()
    lazy var mainTitle: UILabel = {
        var fontSize: CGFloat!
        var topPosit: CGFloat!
        if totalSize.height >= 920 {
            fontSize = 27
            topPosit = 180
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 27
            topPosit = 180
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 27
            topPosit = 180
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 27
            topPosit = 140
        } else if totalSize.height <= 670 {
            fontSize = 21
            topPosit = 120
        } else {
            fontSize = 27
            topPosit = 160
        }
        
        let lbl = UILabel()
        lbl.text = "PREMIUM"
        lbl.textColor = #colorLiteral(red: 0.289646424, green: 0.289646424, blue: 0.289646424, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: fontSize)
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 5
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        self.view.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(topPosit)
        }
        return lbl
    }()
//MARK: - Info
    lazy var viewOne: UIView = {
        let vi = UIView()
        vi.alpha = 0
        self.view.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerXWithinMargins.equalTo(200)
        }
        
        return vi
    }()

    lazy var labelOne: UILabel = {
        var positX: CGFloat!
        var positY: CGFloat!
        var fontSz: CGFloat!
        if totalSize.height >= 890 {
            positX = -170
            positY = 40
            fontSz = 20
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -165
            positY = 30
            fontSz = 20
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -155
            positY = 40
            fontSz = 20
        } else if totalSize.height <= 670 {
            positX = -152
            positY = 30
            fontSz = 18
        } else {
            positX = -180
            positY = 30
            fontSz = 19
        }
        
        switch Locale.current.languageCode {
        case "en":
            if totalSize.height >= 890 {
                positX = -160
            } else  if totalSize.height >= 830 && totalSize.height <= 889 {
                positX = -155
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                positX = -145
            } else if totalSize.height <= 670 {
                positX = -142
            } else {
                positX = -170
            }
        default:
            if totalSize.height >= 890 {
                positX = -160
            } else  if totalSize.height >= 830 && totalSize.height <= 889 {
                positX = -155
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                positX = -145
            } else if totalSize.height <= 670 {
                positX = -142
            } else {
                positX = -170
            }
        }
        
        let lbl = UILabel()
        lbl.text = "Наше приложение бесплатно, поэтому оно содержит рекламу.".localized()
        lbl.textColor = #colorLiteral(red: 0.4312377615, green: 0.4312377615, blue: 0.4312377615, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: fontSz)
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 5
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        self.view.addSubview(lbl)
        viewOne.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(positY)
            make.top.equalToSuperview().inset(positX)
            make.width.equalTo(300)
        }
        
        return lbl
    }()

    lazy var imageOne: UIImageView = {
        var positX: CGFloat!
        var positY: CGFloat!
        var height: CGFloat!
        if totalSize.height >= 890 {
            positX = -170
            positY = -160
            height = 50
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -165
            positY = -160
            height = 50
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -155
            positY = -160
            height = 50
        } else if totalSize.height <= 670 {
            positX = -150
            positY = -160
            height = 40
        } else {
            positX = -175
            positY = -160
            height = 40
        }

        let img = UIImageView(image: #imageLiteral(resourceName: "shout"))

        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        viewOne.addSubview(img)

        img.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(positY)
            make.top.equalToSuperview().inset(positX)

            make.height.equalTo(height)
        }

        return img
    }()
//Two
    lazy var viewTwo: UIView = {
        let vi = UIView()
        vi.alpha = 0
        self.view.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerXWithinMargins.equalTo(200)
        }
        
        return vi
    }()

    lazy var labelTwo: UILabel = {
        var positX: CGFloat!
        var positY: CGFloat!
        var fontSz: CGFloat!
        if totalSize.height >= 890 {
            positX = -70
            positY = 40
            fontSz = 20
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -70
            positY = 30
            fontSz = 20
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -56
            positY = 40
            fontSz = 20
        } else if totalSize.height <= 670 {
            positX = -62
            positY = 30
            fontSz = 18
        } else {
            positX = -78
            positY = 30
            fontSz = 19
        }
        
        switch Locale.current.languageCode {
        case "en":
            if totalSize.height >= 890 {
                positX = -60
            } else  if totalSize.height >= 830 && totalSize.height <= 889 {
                positX = -60
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                positX = -46
            } else if totalSize.height <= 670 {
                positX = -52
            } else {
                positX = -68
            }
        default:
            print("")
        }
        
        let lbl = UILabel()
        lbl.text = "Premium предоставит Вам полный доступ к продукту с отсутствием рекламы.".localized()
        lbl.textColor = #colorLiteral(red: 0.4312377615, green: 0.4312377615, blue: 0.4312377615, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: fontSz)
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 5
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        self.view.addSubview(lbl)
        viewTwo.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(positY)
            make.top.equalToSuperview().inset(positX)
            make.width.equalTo(300)
        }
        
        return lbl
    }()

    lazy var imageTwo: UIImageView = {
        var positX: CGFloat!
        var positY: CGFloat!
        var height: CGFloat!
        if totalSize.height >= 890 {
            positX = -60
            positY = -160
            height = 50
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -60
            positY = -160
            height = 50
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -45
            positY = -160
            height = 50
        } else if totalSize.height <= 670 {
            positX = -50
            positY = -160
            height = 40
        } else {
            positX = -63
            positY = -160
            height = 40
        }

        let img = UIImageView(image: #imageLiteral(resourceName: "crown2"))

        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        viewTwo.addSubview(img)

        img.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(positY)
            make.top.equalToSuperview().inset(positX)

            make.height.equalTo(height)
        }

        return img
    }()

//Three
    lazy var viewThree: UIView = {
        let vi = UIView()
        vi.alpha = 0
        self.view.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerXWithinMargins.equalTo(200)
        }
        
        return vi
    }()

    lazy var labelThree: UILabel = {
        var positX: CGFloat!
        var positY: CGFloat!
        var fontSz: CGFloat!
        if totalSize.height >= 890 {
            positX = 50
            positY = 40
            fontSz = 20
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = 40
            positY = 30
            fontSz = 20
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = 60
            positY = 40
            fontSz = 20
        } else if totalSize.height <= 670 {
            positX = 48
            positY = 30
            fontSz = 18
        } else {
            positX = 33
            positY = 30
            fontSz = 20
        }
        
        let lbl = UILabel()
        lbl.text = "Бесплатный пробный период 3 дня / далее 3.99$ - Месяц".localized()
        lbl.textColor = #colorLiteral(red: 0.4312377615, green: 0.4312377615, blue: 0.4312377615, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: fontSz)
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 5
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        self.view.addSubview(lbl)
        viewThree.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(positY)
            make.top.equalToSuperview().inset(positX)
            make.width.equalTo(300)
        }
        
        return lbl
    }()

    lazy var imageThree: UIImageView = {
        var positX: CGFloat!
        var positY: CGFloat!
        var height: CGFloat!
        if totalSize.height >= 890 {
            positX = 50
            positY = -160
            height = 50
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = 40
            positY = -160
            height = 50
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = 60
            positY = -160
            height = 50
        } else if totalSize.height <= 670 {
            positX = 50
            positY = -160
            height = 40
        } else {
            positX = 40
            positY = -160
            height = 40
        }

        let img = UIImageView(image: #imageLiteral(resourceName: "dollar"))

        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        viewThree.addSubview(img)

        img.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(positY)
            make.top.equalToSuperview().inset(positX)

            make.height.equalTo(height)
        }

        return img
    }()
//MARK: - ButtonBuyPremiumPurchased
    lazy var buttonBuyPremiumPurchased: UIButton = {
        var width: CGFloat!
        var bttmPosit: CGFloat!
        var height: CGFloat!
        if totalSize.height >= 920 {
            width = 230
            bttmPosit = 200
            height = 40
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            width = 230
            bttmPosit = 200
            height = 40
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            width = 230
            bttmPosit = 200
            height = 40
        } else if totalSize.height == 812 {
            width = 230
            bttmPosit = 200
            height = 40
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            width = 230
            bttmPosit = 170
            height = 40
        } else if totalSize.height <= 670 {
            width = 230
            bttmPosit = 160
            height = 40
        } else {
            width = 230
            bttmPosit = 200
            height = 40
        }
        
        let btn = UIButton()
        btn.backgroundColor = #colorLiteral(red: 0.8322479129, green: 0.5383385684, blue: 0.4425687341, alpha: 1)
        btn.setTitle("Подписка оформленна".localized(), for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18)
        btn.layer.cornerRadius = 20
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
    @objc func actionBuyPremiumPurchased(sender: UIButton) {

    }
//MARK: - ButtonBuyPremium
    lazy var buttonBuyPremium: UIButton = {
        var width: CGFloat!
        var bttmPosit: CGFloat!
        var height: CGFloat!
        if totalSize.height >= 920 {
            width = 160
            bttmPosit = 200
            height = 40
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            width = 160
            bttmPosit = 200
            height = 40
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            width = 160
            bttmPosit = 200
            height = 40
        } else if totalSize.height == 812 {
            width = 160
            bttmPosit = 200
            height = 40
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            width = 160
            bttmPosit = 170
            height = 40
        } else if totalSize.height <= 670 {
            width = 160
            bttmPosit = 160
            height = 40
        } else {
            width = 160
            bttmPosit = 200
            height = 40
        }
        
        let btn = UIButton()
        btn.backgroundColor = #colorLiteral(red: 0.8322479129, green: 0.5383385684, blue: 0.4425687341, alpha: 1)
        btn.setTitle("Оформить".localized(), for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 22)
        btn.layer.cornerRadius = 20
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
    @objc func actionBuyPremium(sender: UIButton) {
        
        activityIndicator.startAnimating()
        
        SwiftyStoreKit.purchaseProduct("com.transform.fitness.premium", quantity: 1, atomically: true) { result in
            switch result {
            case .success(let purchase):
                UserDefaults.standard.set(true, forKey: "removeAdsPurchased")

                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "successfulPurchasePremium"), object: nil)
                
                let alert = UIAlertController(title: "Успех".localized(), message: "Premium версия успешно оформлена".localized(), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Продолжить".localized(), style: .cancel, handler: { action in

                    let vc = MainViewController()
                    vc.modalPresentationStyle = .fullScreen

                    let transition = CATransition()
                    transition.duration = 0.4
                    transition.type = CATransitionType.push
                    transition.subtype = CATransitionSubtype.fromRight
                    transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                    self.view.window!.layer.add(transition, forKey: kCATransition)

                    self.present(vc, animated: false, completion: nil)

                }))
                self.activityIndicator.stopAnimating()
                
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
                
                self.activityIndicator.stopAnimating()
            }
        }
    
        
    }
//MARK: - Restore
    @objc lazy var restoreButton: UIButton = {

            var constant: CGFloat!
             if totalSize.height >= 815 {
                constant = 150
             } else if totalSize.height >= 810 {
             constant = 145
             } else if totalSize.height >= 700 {
             constant = 120
             } else if totalSize.height >= 600 {
                 constant = 110
             } else {
                constant = 140
            }
    
            let btn = UIButton()
            
        btn.setTitle("Восстановление покупок".localized(), for: .normal)
            btn.setAttributedTitle(.none, for: .normal)
            btn.setTitleColor(#colorLiteral(red: 0.8322479129, green: 0.5383385684, blue: 0.4425687341, alpha: 1), for: .normal)
            self.view.addSubview(btn)

            btn.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().inset(constant)
            }
            
            return btn
        }()
        
        @objc func buttonRestoreAction(sender: UIButton) {
            
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
                            let productId = "com.transform.fitness.premium"
                            // Verify the purchase of Consumable or NonConsumable
                            let purchaseResult = SwiftyStoreKit.verifyPurchase(
                                productId: productId,
                                inReceipt: receipt)
                                
                            switch purchaseResult {
                            case .purchased(let receiptItem):
                                UserDefaults.standard.set(true, forKey: "removeAdsPurchased")
                                
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "successfulPurchasePremium"), object: nil)
                                
                                let alert = UIAlertController(title: "Успех", message: "Premium версия успешно восстановлена", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Продолжить", style: .cancel, handler: { action in
                                    
                                    let vc = MainViewController()
                                    vc.modalPresentationStyle = .fullScreen

                                    let transition = CATransition()
                                    transition.duration = 0.4
                                    transition.type = CATransitionType.push
                                    transition.subtype = CATransitionSubtype.fromRight
                                    transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                                    self.view.window!.layer.add(transition, forKey: kCATransition)

                                    self.present(vc, animated: false, completion: nil)
                                    
                                }))
                                
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
        let alert = UIAlertController(title: "Ошибка".localized(), message: "При восстановлении покупки произошла ошибка. Либо её срок действия истек, либо она не была приобретена".localized(), preferredStyle: .alert)
            
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        present(alert, animated: true, completion: nil)
    }
//MARK: - Politick
    @objc lazy var politickButton: UIButton = {
        
            var constant: CGFloat!
            if totalSize.height >= 920 {
                constant = 90
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                constant = 90
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                constant = 90
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                constant = 70
            } else if totalSize.height <= 670 {
                constant = 55
            } else {
                constant = 80
            }
            
        
            let btn = UIButton()
            btn.setTitle("""
                        Политика конфиденциальности
                        и Условия обслуживания
                        """.localized(), for: .normal)
            btn.setAttributedTitle(.none, for: .normal)
            btn.titleLabel?.textAlignment = .center
            btn.titleLabel?.numberOfLines = 0
            btn.setTitleColor(#colorLiteral(red: 0.8322479129, green: 0.5383385684, blue: 0.4425687341, alpha: 1), for: .normal)
            self.view.addSubview(btn)

            btn.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().inset(constant)
            }
            
            return btn
        }()
        
        @objc func buttonPolitickAction(sender: UIButton) {
           showSafariVC(for: "http://savage-developer-team.ru/transform-politics/")
        }
    
        func showSafariVC(for url: String) {
        guard let url = URL(string: url) else {
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
//MARK: - NextButton
    lazy var nextButton: UIButton = {
        var constant: CGFloat!
        if totalSize.height >= 830 {
            constant = 20
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            constant = 10
        } else if totalSize.height <= 670 {
            constant = 10
        } else {
            constant = 20
        }
        
        let btn = UIButton()
        btn.setTitle("Далее".localized(), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        btn.setTitleColor(#colorLiteral(red: 0.8322479129, green: 0.5383385684, blue: 0.4425687341, alpha: 1), for: .normal)
        btn.alpha = 0
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(constant)
        }
        
        return btn
    }()

    @objc func actionNextButton(sender: UIButton) {
        let vc = MainViewController()
        vc.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: false, completion: nil)
    }
}
