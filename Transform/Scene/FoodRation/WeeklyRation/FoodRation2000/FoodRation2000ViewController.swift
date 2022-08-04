//
//  FoodRation2000ViewController.swift
//  Transform
//
//  Created by Pavel Lyutikov on 24.11.2021.
//

import UIKit
import AVKit
import AVFoundation
import SwiftyStoreKit

class FoodRation2000ViewController: UIViewController, UIScrollViewDelegate {
    
    let totalSize = UIScreen.main.bounds.size

    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let scrollViewRation = UIScrollView()
    let contentViewRation = UIView()
    
    var foodRation2000_purchased: Bool = false
    
    var activityIndicator = UIActivityIndicatorView()
    
//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        backgroundImage.isHidden = false
        backgroundMainTitle.isHidden = false
        mainTitle.isHidden = false
        rotatePointer.isHidden = false
        
        let dateFormatter = DateFormatter()
        // uncomment to enforce the US locale
        // dateFormatter.locale = Locale(identifier: "en-US")
        dateFormatter.setLocalizedDateFormatFromTemplate("EEE")
        
        
        UserDefaults.standard.set(dateFormatter.string(from: Date()), forKey: "Weekday")
        
        if UserDefaults.standard.string(forKey: "Weekday") == String("Mon") {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                UIView.animate(withDuration: 1.0) {[weak self] in
                    self?.rotatePointer.transform = CGAffineTransform(rotationAngle: CGFloat(-2.52))
                }
            }
            Timer.scheduledTimer(withTimeInterval: 1.1, repeats: false) { (timer) in
                self.button1.backgroundColor = #colorLiteral(red: 1, green: 0.7960101483, blue: 0.3914288896, alpha: 1)
            }
            print("ПОНЕДЕЛЬНИК")
        } else if UserDefaults.standard.string(forKey: "Weekday") == String("Tue") {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                UIView.animate(withDuration: 1.0) {[weak self] in
                    self?.rotatePointer.transform = CGAffineTransform(rotationAngle: CGFloat(-1.57))
                }
            }
            Timer.scheduledTimer(withTimeInterval: 1.1, repeats: false) { (timer) in
                self.button2.backgroundColor = #colorLiteral(red: 1, green: 0.7960101483, blue: 0.3914288896, alpha: 1)
            }
            print("ВТОРНИК")
        } else if UserDefaults.standard.string(forKey: "Weekday") == String("Wed") {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                UIView.animate(withDuration: 1.5) {[weak self] in
                    self?.rotatePointer.transform = CGAffineTransform(rotationAngle: CGFloat(-0.57))
                }
            }
            Timer.scheduledTimer(withTimeInterval: 1.6, repeats: false) { (timer) in
                self.button3.backgroundColor = #colorLiteral(red: 1, green: 0.7960101483, blue: 0.3914288896, alpha: 1)
            }
            print("СРЕДА")
        } else if UserDefaults.standard.string(forKey: "Weekday") == String("Thu") {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                UIView.animate(withDuration: 2.5) {[weak self] in
                    self?.rotatePointer.transform = CGAffineTransform(rotationAngle: CGFloat(-0.57))
                    self?.rotatePointer.transform = CGAffineTransform(rotationAngle: CGFloat(0.23))
                }
            }
            Timer.scheduledTimer(withTimeInterval: 2.6, repeats: false) { (timer) in
                self.button4.backgroundColor = #colorLiteral(red: 1, green: 0.7960101483, blue: 0.3914288896, alpha: 1)
            }
            print("ЧЕТВЕРГ")
        } else if UserDefaults.standard.string(forKey: "Weekday") == String("Fri") {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                UIView.animate(withDuration: 2.5) {[weak self] in
                    self?.rotatePointer.transform = CGAffineTransform(rotationAngle: CGFloat(-0.57))
                    self?.rotatePointer.transform = CGAffineTransform(rotationAngle: CGFloat(1.07))
                }
            }
            Timer.scheduledTimer(withTimeInterval: 2.6, repeats: false) { (timer) in
                self.button5.backgroundColor = #colorLiteral(red: 1, green: 0.7960101483, blue: 0.3914288896, alpha: 1)
            }
            print("ПЯТНИЦА")
        } else if UserDefaults.standard.string(forKey: "Weekday") == String("Sat") {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                UIView.animate(withDuration: 3.0) {[weak self] in
                    self?.rotatePointer.transform = CGAffineTransform(rotationAngle: CGFloat(-0.57))
                    self?.rotatePointer.transform = CGAffineTransform(rotationAngle: CGFloat(2.03))
                }
            }
            Timer.scheduledTimer(withTimeInterval: 3.1, repeats: false) { (timer) in
                self.button6.backgroundColor = #colorLiteral(red: 1, green: 0.7960101483, blue: 0.3914288896, alpha: 1)
            }
            print("СУББОТА")
        } else if UserDefaults.standard.string(forKey: "Weekday") == String("Sun") {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                UIView.animate(withDuration: 3.5) {[weak self] in
                    self?.rotatePointer.transform = CGAffineTransform(rotationAngle: CGFloat(-0.57))
                    self?.rotatePointer.transform = CGAffineTransform(rotationAngle: CGFloat(1.11))
                    self?.rotatePointer.transform = CGAffineTransform(rotationAngle: CGFloat(2.92))
                }
            }
            Timer.scheduledTimer(withTimeInterval: 3.6, repeats: false) { (timer) in
                self.button7.backgroundColor = #colorLiteral(red: 1, green: 0.7960101483, blue: 0.3914288896, alpha: 1)
            }
            print("ВОСКРЕСЕНЬЕ")
        }

        button1.addTarget(self, action: #selector(button1Action(sender:)), for: .touchUpInside)
        button2.addTarget(self, action: #selector(button2Action(sender:)), for: .touchUpInside)
        button3.addTarget(self, action: #selector(button3Action(sender:)), for: .touchUpInside)
        button4.addTarget(self, action: #selector(button4Action(sender:)), for: .touchUpInside)
        button5.addTarget(self, action: #selector(button5Action(sender:)), for: .touchUpInside)
        button6.addTarget(self, action: #selector(button6Action(sender:)), for: .touchUpInside)
        button7.addTarget(self, action: #selector(button7Action(sender:)), for: .touchUpInside)
        
        dismissButton.addTarget(self, action: #selector(buttonDismiss), for: .touchUpInside)
        infoButton.addTarget(self, action: #selector(buttonInfoAction(sender:)), for: .touchUpInside)
        
        setupActivityIndicator()
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        if !UserDefaults.standard.bool(forKey: "foodRation2000_purchased") {
            
            let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: "56e3e9f9829043bb8e404111d191ae2b")
            SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
                switch result {
                case .success(let receipt):
                    let productId = "com.transform.fitness.foodRation2000"
                    // Verify the purchase of Consumable or NonConsumable
                    let purchaseResult = SwiftyStoreKit.verifyPurchase(
                        productId: productId,
                        inReceipt: receipt)
                        
                    switch purchaseResult {
                    case .purchased(let receiptItem):
                        UserDefaults.standard.set(true, forKey: "foodRation2000_purchased")

                        self.foodRation2000_purchased = true
                        
                        print("\(productId) is purchased: \(receiptItem)")
                    case .notPurchased:
                        
                        self.buttonPurchaseFoodRation2000.addTarget(self, action: #selector(self.buttonPurchaseFoodRation2000(sender:)), for: .touchUpInside)
                        self.buttonRestoredPurchase.addTarget(self, action: #selector(self.actionButtonRestoredPurchase(sender:)), for: .touchUpInside)
                        
                        print("The user has never purchased \(productId)")
                    }
                    case .error(let error):
                        
                        self.buttonPurchaseFoodRation2000.addTarget(self, action: #selector(self.buttonPurchaseFoodRation2000(sender:)), for: .touchUpInside)
                        self.buttonRestoredPurchase.addTarget(self, action: #selector(self.actionButtonRestoredPurchase(sender:)), for: .touchUpInside)
                        
                        print("Receipt verification failed: \(error)")
                }
                self.activityIndicator.stopAnimating()
            }
        
        } else {
            
            self.foodRation2000_purchased = true
            
            self.activityIndicator.stopAnimating()
        }
        
        //SuccessfulPurchase
        NotificationCenter.default.addObserver(self, selector: #selector(FoodRation2000ViewController.successfulPurchaseFoodRation2000), name: NSNotification.Name(rawValue: "successfulPurchaseFoodRation2000"), object: nil)
        
        setupScrollView()
        setupViews()
        
        setupScrollViewRation()
        setupViewsRation()

    }
//MARK: - SuccessfulPurchase
    @objc func successfulPurchaseFoodRation2000() {
        
        buttonRestoredPurchase.zoomOutInfo()
        buttonPurchaseFoodRation2000.zoomOutInfo()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.buttonRestoredPurchase.isHidden = true
            self.buttonPurchaseFoodRation2000.isHidden = true
        }
    }
//MARK: - ActivityIndicator
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        activityIndicator.center = self.view.center
        activityIndicator.style = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = #colorLiteral(red: 0.9933875203, green: 0.7789561749, blue: 0.53204602, alpha: 1)
        activityIndicator.layer.cornerRadius = 15
        activityIndicator.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        activityIndicator.layer.shadowRadius = 3
        activityIndicator.layer.shadowOffset = CGSize(width: 0, height: 0)
        activityIndicator.layer.shadowOpacity = 0.4
        activityIndicator.layer.zPosition = 30
//        activityIndicator.layer.position = CGPoint(x: 0, y: 0)
    }
//MARK: - MainTitle
    lazy var mainTitle: UILabel = {
        let topPosit: CGFloat!
        let fontSz: CGFloat!
        if totalSize.height >= 830 {
            topPosit = 150
            fontSz = 40
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            topPosit = 105
            fontSz = 40
        } else if totalSize.height <= 670 {
            topPosit = 90
            fontSz = 40
        } else {
            topPosit = 130
            fontSz = 40
        }
        
        let lbl = UILabel()
        lbl.text = "2000 Ккал"
        lbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: fontSz)
        self.view.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(topPosit)
            make.centerX.equalToSuperview()
        }
        
        return lbl
    }()
    
    lazy var backgroundMainTitle: UIImageView = {
        let topPosit: CGFloat!
        let fontSz: CGFloat!
        let wdth: CGFloat!
        if totalSize.height >= 830 {
            topPosit = 105
            fontSz = 40
            wdth = 250
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            topPosit = 60
            fontSz = 40
            wdth = 230
        } else if totalSize.height <= 670 {
            topPosit = 45
            fontSz = 40
            wdth = 220
        } else {
            topPosit = 85
            fontSz = 40
            wdth = 230
        }
        
        let img = UIImageView(image: #imageLiteral(resourceName: "backgroundMainLabelFoodRation"))
        img.contentMode = .scaleAspectFit
        img.layer.cornerRadius = 40
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 8
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.5
        self.view.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(topPosit)
            make.centerX.equalToSuperview()
            make.width.equalTo(wdth)
        }
        
        return img
    }()
//MARK: - RotatePointer
    lazy var rotatePointer: UIImageView = {
        let positX: CGFloat!
        let size: CGFloat!
        if totalSize.height >= 920 {
            positX = 398
            size = 150
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positX = 373
            size = 150
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = 364
            size = 150
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = 305
            size = 150
        } else if totalSize.height <= 670 {
            positX = 275
            size = 140
        } else {
            positX = 355
            size = 135
        }
        let img = UIImageView(image: #imageLiteral(resourceName: "pointer"))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 8
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.3
        img.transform = CGAffineTransform(rotationAngle: CGFloat(-2.9))
        self.view.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(positX)
            make.width.equalTo(size)
            make.height.equalTo(size)
        }
        
       return img
    }()
//MARK: - ButtonPurchase
    lazy var buttonPurchaseFoodRation2000: UIButton = {
        var width: CGFloat!
        var bttmPosit: CGFloat!
        var height: CGFloat!
        var lead: CGFloat!
        if totalSize.height >= 920 {
            bttmPosit = 50
            height = 120
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            bttmPosit = 60
            height = 120
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            bttmPosit = 60
            height = 110
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            bttmPosit = 30
            height = 110
        } else if totalSize.height <= 670 {
            bttmPosit = 30
            height = 100
        } else {
            bttmPosit = 60
            height = 110
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "buttonBuyFoodRation1500"), for: .normal)
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 9
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.8
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(bttmPosit)
            make.width.equalTo(height)
            make.height.equalTo(height)
        }
        
        return btn
    }()
    
    @objc func buttonPurchaseFoodRation2000(sender: UIButton) {
        activityIndicator.startAnimating()
        
        SwiftyStoreKit.purchaseProduct("com.transform.fitness.foodRation2000", quantity: 1, atomically: true) { result in
            switch result {
            case .success(let purchase):
                
                UserDefaults.standard.set(true, forKey: "foodRation2000_purchased")
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "successfulPurchaseFoodRation2000"), object: nil)
                
                self.foodRation2000_purchased = true
                
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
            bttmPosit = 50
            height = 50
            lead = 30
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            width = 50
            bttmPosit = 50
            height = 50
            lead = 30
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            width = 50
            bttmPosit = 50
            height = 50
            lead = 20
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            width = 50
            bttmPosit = 35
            height = 50
            lead = 35
        } else if totalSize.height <= 670 {
            width = 50
            bttmPosit = 25
            height = 50
            lead = 30
        } else {
            width = 50
            bttmPosit = 50
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
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(bttmPosit)
            make.width.equalTo(width)
            make.height.equalTo(height)
            make.trailing.equalToSuperview().inset(lead)
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
                        let productId = "com.transform.fitness.foodRation2000"
                        // Verify the purchase of Consumable or NonConsumable
                        let purchaseResult = SwiftyStoreKit.verifyPurchase(
                            productId: productId,
                            inReceipt: receipt)
                            
                        switch purchaseResult {
                        case .purchased(let receiptItem):
                            UserDefaults.standard.set(true, forKey: "foodRation2000_purchased")
                            
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "successfulPurchaseFoodRation2000"), object: nil)
                            
                            self.foodRation2000_purchased = true
                            
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
    
//MARK: ScrollInfo
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let positTop: CGFloat!
        let positBttm: CGFloat!
        if totalSize.height >= 920 {
            positTop = 197
            positBttm = -197
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positTop = 195
            positBttm = -195
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positTop = 186
            positBttm = -186
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positTop = 115
            positBttm = -115
        } else if totalSize.height <= 670 {
            positTop = 105
            positBttm = -105
        } else {
            positTop = 167
            positBttm = -167
        }
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: positTop).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: positBttm).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: positTop).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: positBttm).isActive = true
        
        scrollView.layer.zPosition = 9
        scrollView.isHidden = true
        
        }
    func setupViews(){
        contentView.addSubview(labelComplexInfo)
        
        let wdth: CGFloat!
        let positTop: CGFloat!
        let positBttm: CGFloat!
        if totalSize.height >= 890 {
            wdth = 3.5/4
            positTop = -150
            positBttm = 160
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 3.5/4
            positTop = -150
            positBttm = 160
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 3.2/4
            positTop = -70
            positBttm = 140
        } else if totalSize.height <= 670 {
            wdth = 3.2/4
            positTop = -40
            positBttm = 100
        } else {
            wdth = 3.7/4
            positTop = -120
            positBttm = 130
        }
        
        labelComplexInfo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        labelComplexInfo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: positTop).isActive = true
        labelComplexInfo.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: wdth).isActive = true
            
        
        
        contentView.addSubview(labelComplexEnd)
        labelComplexEnd.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        labelComplexEnd.topAnchor.constraint(equalTo: labelComplexInfo.bottomAnchor, constant: 25).isActive = true
        labelComplexEnd.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        labelComplexEnd.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: positBttm).isActive = true
        
        labelComplexInfo.isHidden = true
        labelComplexEnd.isHidden = true
    }
    
    lazy var labelComplexEnd: UILabel = {
        let fnt: CGFloat!
        if totalSize.height >= 890 {
            fnt = 20
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fnt = 18
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fnt = 20
        } else if totalSize.height <= 670 {
            fnt = 18
        } else {
            fnt = 18
        }
        let label = UILabel()
        label.text = """
                        Данная программа питания рассчитана на людей, не имеющих проблем со здоровьем. Если у Вас есть какие-либо проблемы в работе желудочно-кишечного тракта, перед соблюдением программы необходимо проконсультироваться с врачом.
                        Программа предусматривает 6 приемов пищи. Адекватный дефицит калорий и комфортный рацион, состоит из здоровых продуктов.
                        
                        Как часто нужно есть?
                        
                        Распределение продуктов в течении дня должно быть удобным для вас, с соблюдением дефицита калорий.
                        Оптимальные промежутки между приемами пищи 3-4 ч. Не обязательно есть 5-6 раз в день, можно дневную калорийность вместить в 3-4 приема пищи.
                        Вы можете менять время приема пищи в соответствии со своим распорядком дня, соблюдая интервалы между приемами.
                        
                        Питание ДО и ПОСЛЕ тренировки
                        
                        Накопившаяся усталость и низкий уровень сахара в крови из-за продолжительного промежутка без пищи не дадут провести интенсивное занятие. Съешьте углеводы + белки за 1.5-2 ч перед тренировкой или легкий перекус за 30 мин. После тренировки едим сразу, желательно в течении часа, это создаст благоприятные условия для восстановления мышц.
                        
                        Поздний ужин, во сколько должен быть?
                        
                        Поздний ужин должен быть не позднее, чем за 1.5-2 ч до сна, не отказывайтесь от еды после 18:00 это будет только мешать снижению веса.
                        
                        Замена продуктов
                        
                        Вы можете производить замену продуктов исходя из своих вкусовых предпочтений в рамках КБЖУ. Желательно чтобы продукты были родственными между собой, например, в программе указано яблоко - вы можете заменить любым фруктом, курицу - индейкой и тд.
                        
                        Выбор молочных продуктов
                        
                        Не нужно зацикливаться на обезжиренных продуктах и до 5% жирности продуктах, это может только замедлить процесс похудения.
                        
                        Вариативность меню
                        
                        Для каждого блюда указано количество белков, жиров, углеводов и общая калорийность. Вы можете заменять блюда в рамках одинаковых приемов пищи, выбирая схожую калорийность и соотношение БЖУ. Например, завтрак понедельника заменить завтраком среды, только не нужно заменять ужин обедом, полдник завтраком.
                        
                        Как взвешивать продукты
                        
                        Если вы хотите точно соблюдать нужную калорийность вам понадобятся кухонные весы, как правило на глаз, вес определить не получится. Вес продуктов указан в сухом (сыром) виде, это связано с тем, что в процессе приготовления продукты меняют свой вес. Так что, например, если крупы вам нужно 40г в сухом виде, в готовом это будет 80г. Вес мяса же наоборот, уменьшается после приготовления, из 200г сырого мяса, останется только 100г.
                        
                        Приправы и специи
                        
                        Добавляйте соль и перец, так же другие приправы по вкусу.
                        """
        label.numberOfLines = 4000
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: fnt)
        label.sizeToFit()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var labelComplexInfo: UILabel = {
        let fnt: CGFloat!
        if totalSize.height >= 890 {
            fnt = 22
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fnt = 20
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fnt = 22
        } else if totalSize.height <= 670 {
            fnt = 20
        } else {
            fnt = 22
        }
        
       let label = UILabel()
        label.text = """
               Внимание!!!
            """
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: fnt)
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
//MARK: - BackgroundInfo
    lazy var backgroundInfo: UIImageView = {
        let leadtTrail: CGFloat!
        if totalSize.height >= 830 {
            leadtTrail = 20
        } else if totalSize.height <= 800 {
            leadtTrail = 20
        } else {
            leadtTrail = 10
        }
        var image = UIImageView(image: #imageLiteral(resourceName: "infoBackgroundFoodRation"))
        image.contentMode = .scaleAspectFit
        image.layer.zPosition = 8
        image.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        image.layer.shadowRadius = 50
        image.layer.shadowOffset = CGSize(width: 0, height: 0)
        image.layer.shadowOpacity = 0.8
        self.view.addSubview(image)
        
        image.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(leadtTrail)
        }
        return image
    }()
//MARK: InfoButton
        @objc lazy var infoButton: UIButton = {
            let positX: CGFloat!
            let trail: CGFloat!
            if totalSize.height >= 830 {
                positX = 68
                trail = 35
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                positX = 35
                trail = 35
            } else if totalSize.height <= 670 {
                positX = 35
                trail = 35
            } else {
                positX = 50
                trail = 35
            }
            let btn = UIButton()
            btn.setImage(#imageLiteral(resourceName: "informationFoodRation"), for: .normal)
            btn.layer.zPosition = 4
            btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            btn.layer.shadowRadius = 3
            btn.layer.shadowOffset = CGSize(width: 0, height: 0)
            btn.layer.shadowOpacity = 0.4
            btn.adjustsImageWhenHighlighted = false
            self.view.addSubview(btn)

            btn.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(trail)
                make.top.equalToSuperview().inset(positX)
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

            scrollView.isHidden = false
            labelComplexInfo.isHidden = false
            labelComplexInfo.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            UIView.animate(withDuration: 0.4) {
                self.labelComplexInfo.transform = CGAffineTransform.identity
                self.labelComplexInfo.alpha = 1
            }
            labelComplexEnd.isHidden = false
            labelComplexEnd.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            UIView.animate(withDuration: 0.4) {
                self.labelComplexEnd.transform = CGAffineTransform.identity
                self.labelComplexEnd.alpha = 1
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
            let trail: CGFloat!
            let positTop: CGFloat!
            if totalSize.height >= 920 {
                trail = 40
                positTop = 213
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                trail = 35
                positTop = 205
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                trail = 37
                positTop = 205
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                trail = 35
                positTop = 130
            } else if totalSize.height <= 670 {
                trail = 35
                positTop = 120
            } else {
                trail = 35
                positTop = 185
            }
            let btn = UIButton()
            btn.setImage(#imageLiteral(resourceName: "cancelWhite"), for: .normal)
            btn.layer.zPosition = 10
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
                self.labelComplexInfo.isHidden = true
                self.labelComplexEnd.isHidden = true
                self.scrollView.isHidden = true
            }
            labelComplexInfo.zoomOutInfo()
            labelComplexEnd.zoomOutInfo()
            
            closeInfoButton.zoomOutInfo()
            
            self.closeInfoButton.isHidden = true
            
            infoButton.isHidden = false
        }
//MARK: ScrollViewRation
    func setupScrollViewRation(){
        scrollViewRation.translatesAutoresizingMaskIntoConstraints = false
        contentViewRation.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollViewRation)
        scrollViewRation.addSubview(contentViewRation)
        
        var positTop: CGFloat!
        var positBttm: CGFloat!
        if totalSize.height >= 920 {
            positTop = 0
            positBttm = 0
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positTop = 0
            positBttm = 0
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positTop = 0
            positBttm = 0
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positTop = 0
            positBttm = 0
        } else if totalSize.height <= 670 {
            positTop = 0
            positBttm = 0
        } else {
            positTop = 0
            positBttm = 0
        }
        
        scrollViewRation.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollViewRation.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollViewRation.topAnchor.constraint(equalTo: view.topAnchor, constant: positTop).isActive = true
        scrollViewRation.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: positBttm).isActive = true
        
        contentViewRation.centerXAnchor.constraint(equalTo: scrollViewRation.centerXAnchor).isActive = true
        contentViewRation.widthAnchor.constraint(equalTo: scrollViewRation.widthAnchor).isActive = true
        contentViewRation.topAnchor.constraint(equalTo: scrollViewRation.topAnchor, constant: positTop).isActive = true
        contentViewRation.bottomAnchor.constraint(equalTo: scrollViewRation.bottomAnchor, constant: positBttm).isActive = true
        
        scrollViewRation.delegate = self
        scrollViewRation.minimumZoomScale = 1.0
        scrollViewRation.maximumZoomScale = 2.0
        scrollViewRation.layer.zPosition = 9
        scrollViewRation.isHidden = true
        }
    func viewForZooming(in scrollViewRation: UIScrollView) -> UIView? {
        return imageDay1
    }
    func setupViewsRation(){
        contentViewRation.addSubview(labelDay1)
        
        let wdth: CGFloat!
        let positTop: CGFloat!
        let positBttm: CGFloat!
        if totalSize.height >= 920 {
            wdth = 4.2/4
            positTop = -790
            positBttm = 1960
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            wdth = 4.2/4
            positTop = -820
            positBttm = 1980
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 4.2/4
            positTop = -865
            positBttm = 2020
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 3.2/4
            positTop = -795
            positBttm = 1960
        } else if totalSize.height <= 670 {
            wdth = 3.2/4
            positTop = -890
            positBttm = 2040
        } else {
            wdth = 3.7/4
            positTop = -900
            positBttm = 2060
        }
        
        labelDay1.centerXAnchor.constraint(equalTo: contentViewRation.centerXAnchor).isActive = true
        labelDay1.topAnchor.constraint(equalTo: contentViewRation.topAnchor, constant: positTop).isActive = true
        labelDay1.widthAnchor.constraint(equalTo: contentViewRation.widthAnchor, multiplier: wdth).isActive = true
        
        contentViewRation.addSubview(imageDay1)
        imageDay1.centerXAnchor.constraint(equalTo: contentViewRation.centerXAnchor).isActive = true
        imageDay1.topAnchor.constraint(equalTo: labelDay1.bottomAnchor, constant: -1150).isActive = true
        imageDay1.widthAnchor.constraint(equalTo: contentViewRation.widthAnchor, constant: 100).isActive = true
        imageDay1.bottomAnchor.constraint(equalTo: contentViewRation.bottomAnchor, constant: positBttm).isActive = true
        
        labelDay1.isHidden = true
        imageDay1.isHidden = true
    }
    
    lazy var imageDay1: UIImageView = {

        let leadtTrail: CGFloat!
        if totalSize.height >= 830 {
            leadtTrail = -50
        } else if totalSize.height <= 800 {
            leadtTrail = 25
        } else {
            leadtTrail = 10
        }
        
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.zPosition = 8
        image.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        image.layer.shadowRadius = 6
        image.layer.shadowOffset = CGSize(width: 0, height: 0)
        image.layer.shadowOpacity = 0.5
        self.view.addSubview(image)
        
        image.snp.makeConstraints { make in

        }
        return image
    }()

    lazy var labelDay1: UILabel = {
        let fnt: CGFloat!
        if totalSize.height >= 890 {
            fnt = 28
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fnt = 26
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fnt = 28
        } else if totalSize.height <= 670 {
            fnt = 26
        } else {
            fnt = 28
        }
        
       let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: fnt)
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
//MARK: - BackgroundScrollRation
    lazy var backgroundScrollRation: UIImageView = {
        let leadtTrail: CGFloat!
        if totalSize.height >= 830 {
            leadtTrail = 0
        } else if totalSize.height <= 800 {
            leadtTrail = 0
        } else {
            leadtTrail = 0
        }
        var image = UIImageView(image: #imageLiteral(resourceName: "dayRationBackground"))
        image.contentMode = .scaleAspectFit
        image.layer.zPosition = 8
        self.view.addSubview(image)
        
        image.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        return image
    }()
//MARK: CloseScrollRation
        @objc lazy var closeScrollRationButton: UIButton = {
            let trail: CGFloat!
            let positTop: CGFloat!
            if totalSize.height >= 920 {
                trail = 20
                positTop = 60
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                trail = 20
                positTop = 60
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                trail = 20
                positTop = 55
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                trail = 20
                positTop = 30
            } else if totalSize.height <= 670 {
                trail = 20
                positTop = 30
            } else {
                trail = 20
                positTop = 50
            }
            let btn = UIButton()
            btn.setImage(#imageLiteral(resourceName: "closeBlack"), for: .normal)
            btn.layer.zPosition = 10
            self.view.addSubview(btn)

            btn.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(trail)
                make.top.equalToSuperview().inset(positTop)
                make.height.equalTo(30)
                make.width.equalTo(30)
            }
            
            return btn
        }()
        @objc func buttonCloseScrollRationAction(sender: UIButton) {
            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                self.backgroundScrollRation.isHidden = true
            }
            backgroundScrollRation.zoomOutInfo()
            
            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                self.labelDay1.isHidden = true
                self.imageDay1.isHidden = true
                self.scrollViewRation.isHidden = true
            }
            labelDay1.zoomOutInfo()
            imageDay1.zoomOutInfo()
            
            closeScrollRationButton.zoomOutInfo()
            
            self.closeScrollRationButton.isHidden = true
        }
//MARK: BackgroundImage
    lazy var backgroundImage: UIImageView = {
        var image = UIImageView(image: #imageLiteral(resourceName: "foodRationBackground"))
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.layer.zPosition = 0
        image.alpha = 0.17
        self.view.addSubview(image)


        image.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(10)
    }
        return image
    }()
//MARK: - DismissButton
    @objc lazy var dismissButton: UIButton = {

        let top: CGFloat!
        let trail: CGFloat!
        if totalSize.height >= 830 {
            top = 55
            trail = 30
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            top = 25
            trail = 20
        } else if totalSize.height <= 670 {
            top = 30
            trail = 20
        } else {
            top = 45
            trail = 25
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "closeBlack"), for: .normal)
        btn.layer.zPosition = 4
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(top)
            make.leading.equalToSuperview().inset(trail)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        return btn
    }()
    @objc func buttonDismiss(sender: UIButton) {
 
        sender.zoomOut()

        let vc = MenuFoodRationViewController()
        vc.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: false, completion: nil)
    }
//MARK: - ButtonMenu
    //1
    @objc lazy var button1: UIButton = {
        let positX: CGFloat!
        let fontSize: CGFloat!
        let leadTrail: CGFloat!
        let wdthHght: CGFloat!
        if totalSize.height >= 920 {
            fontSize = 25
            positX = 490
            leadTrail = 55
            wdthHght = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 25
            positX = 490
            leadTrail = 55
            wdthHght = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 25
            positX = 441
            leadTrail = 55
            wdthHght = 80
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 25
            positX = 400
            leadTrail = 55
            wdthHght = 80
        } else if totalSize.height <= 670 {
            fontSize = 25
            positX = 355
            leadTrail = 55
            wdthHght = 80
        } else {
            fontSize = 25
            positX = 425
            leadTrail = 50
            wdthHght = 80
        }
        let btn = UIButton()
        btn.setTitle("ПН", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        btn.backgroundColor = #colorLiteral(red: 0.9195359349, green: 0.6071895458, blue: 0.3224741801, alpha: 1)
        btn.layer.cornerRadius = 40
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(positX)
            make.leading.equalToSuperview().inset(leadTrail)
            make.width.equalTo(wdthHght)
            make.height.equalTo(wdthHght)
        }
        
        return btn
    }()
    
    @objc func button1Action(sender: UIButton) {
        
        sender.zoomOutInfo()
        
        imageDay1.image = #imageLiteral(resourceName: "foodRation2000Monday")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            
            if self.totalSize.height >= 920 {
                self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -47.0), animated: false)
            } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -48.0), animated: false)
            } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -47.0), animated: false)
            } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
            } else if self.totalSize.height <= 670 {
                self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
            } else {
                self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -44.0), animated: false)
            }
            
            self.backgroundScrollRation.isHidden = false
            self.backgroundScrollRation.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            UIView.animate(withDuration: 0.4) {
                self.backgroundScrollRation.transform = CGAffineTransform.identity
                self.backgroundScrollRation.alpha = 1
            }

            self.scrollViewRation.isHidden = false
            self.labelDay1.isHidden = false
            self.labelDay1.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            UIView.animate(withDuration: 0.4) {
                self.labelDay1.transform = CGAffineTransform.identity
                self.labelDay1.alpha = 1
            }
            self.imageDay1.isHidden = false
            self.imageDay1.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            UIView.animate(withDuration: 0.4) {
                self.imageDay1.transform = CGAffineTransform.identity
                self.imageDay1.alpha = 1
            }

            self.closeScrollRationButton.isHidden = false

            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
                self.closeScrollRationButton.zoomInInfo()
            }

            self.closeScrollRationButton.addTarget(self, action: #selector(self.buttonCloseScrollRationAction(sender:)), for: .touchUpInside)
            
            sender.zoomInInfo()
        }
    }
    //2
    @objc lazy var button2: UIButton = {
        let positX: CGFloat!
        let fontSize: CGFloat!
        let leadTrail: CGFloat!
        let wdthHght: CGFloat!
        if totalSize.height >= 920 {
            fontSize = 25
            positX = 550
            leadTrail = 90
            wdthHght = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 25
            positX = 543
            leadTrail = 90
            wdthHght = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 25
            positX = 494
            leadTrail = 90
            wdthHght = 80
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 25
            positX = 460
            leadTrail = 90
            wdthHght = 80
        } else if totalSize.height <= 670 {
            fontSize = 25
            positX = 400
            leadTrail = 90
            wdthHght = 80
        } else {
            fontSize = 25
            positX = 475
            leadTrail = 90
            wdthHght = 80
        }
        let btn = UIButton()
        btn.setTitle("ВТ", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        btn.backgroundColor = #colorLiteral(red: 0.9195359349, green: 0.6071895458, blue: 0.3224741801, alpha: 1)
        btn.layer.cornerRadius = 40
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(positX)
            make.centerX.equalToSuperview()
            make.width.equalTo(wdthHght)
            make.height.equalTo(wdthHght)
        }
        
        return btn
    }()
    
    @objc func button2Action(sender: UIButton) {
        
        sender.zoomOutInfo()
        
        imageDay1.image = #imageLiteral(resourceName: "foodRation2000Tuesday")
    
        if !foodRation2000_purchased {
            showinfoRestoreAlert()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                sender.zoomInInfo()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                
                if self.totalSize.height >= 920 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -47.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -48.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -47.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
                } else {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -44.0), animated: false)
                }
                
                self.backgroundScrollRation.isHidden = false
                self.backgroundScrollRation.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    self.backgroundScrollRation.transform = CGAffineTransform.identity
                    self.backgroundScrollRation.alpha = 1
                }

                self.scrollViewRation.isHidden = false
                self.labelDay1.isHidden = false
                self.labelDay1.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    self.labelDay1.transform = CGAffineTransform.identity
                    self.labelDay1.alpha = 1
                }
                self.imageDay1.isHidden = false
                self.imageDay1.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    self.imageDay1.transform = CGAffineTransform.identity
                    self.imageDay1.alpha = 1
                }

                self.closeScrollRationButton.isHidden = false

                Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
                    self.closeScrollRationButton.zoomInInfo()
                }

                self.closeScrollRationButton.addTarget(self, action: #selector(self.buttonCloseScrollRationAction(sender:)), for: .touchUpInside)
                
                sender.zoomInInfo()
            }
        }
        
    }
    //3
    @objc lazy var button3: UIButton = {
        let positX: CGFloat!
        let fontSize: CGFloat!
        let leadTrail: CGFloat!
        let wdthHght: CGFloat!
        if totalSize.height >= 920 {
            fontSize = 25
            positX = 490
            leadTrail = 55
            wdthHght = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 25
            positX = 490
            leadTrail = 55
            wdthHght = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 25
            positX = 441
            leadTrail = 55
            wdthHght = 80
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 25
            positX = 400
            leadTrail = 55
            wdthHght = 80
        } else if totalSize.height <= 670 {
            fontSize = 25
            positX = 355
            leadTrail = 55
            wdthHght = 80
        } else {
            fontSize = 25
            positX = 425
            leadTrail = 50
            wdthHght = 80
        }
        let btn = UIButton()
        btn.setTitle("СР", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        btn.backgroundColor = #colorLiteral(red: 0.9195359349, green: 0.6071895458, blue: 0.3224741801, alpha: 1)
        btn.layer.cornerRadius = 40
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(positX)
            make.trailing.equalToSuperview().inset(leadTrail)
            make.width.equalTo(wdthHght)
            make.height.equalTo(wdthHght)
        }
        
        return btn
    }()
    
    @objc func button3Action(sender: UIButton) {
        
        sender.zoomOutInfo()
        
        imageDay1.image = #imageLiteral(resourceName: "foodRation2000Wednesday")
        
        if !foodRation2000_purchased {
            showinfoRestoreAlert()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                sender.zoomInInfo()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                
                if self.totalSize.height >= 920 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -47.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -48.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -47.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
                } else {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -44.0), animated: false)
                }
                
                self.backgroundScrollRation.isHidden = false
                self.backgroundScrollRation.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    self.backgroundScrollRation.transform = CGAffineTransform.identity
                    self.backgroundScrollRation.alpha = 1
                }

                self.scrollViewRation.isHidden = false
                self.labelDay1.isHidden = false
                self.labelDay1.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    self.labelDay1.transform = CGAffineTransform.identity
                    self.labelDay1.alpha = 1
                }
                self.imageDay1.isHidden = false
                self.imageDay1.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    self.imageDay1.transform = CGAffineTransform.identity
                    self.imageDay1.alpha = 1
                }

                self.closeScrollRationButton.isHidden = false

                Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
                    self.closeScrollRationButton.zoomInInfo()
                }

                self.closeScrollRationButton.addTarget(self, action: #selector(self.buttonCloseScrollRationAction(sender:)), for: .touchUpInside)
                
                sender.zoomInInfo()
            }
        }
        
    }
    //4
    @objc lazy var button4: UIButton = {
        let positX: CGFloat!
        let fontSize: CGFloat!
        let leadTrail: CGFloat!
        let wdthHght: CGFloat!
        if totalSize.height >= 920 {
            fontSize = 25
            positX = 376
            leadTrail = 35
            wdthHght = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 25
            positX = 380
            leadTrail = 35
            wdthHght = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 25
            positX = 335
            leadTrail = 33
            wdthHght = 80
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 25
            positX = 283
            leadTrail = 35
            wdthHght = 80
        } else if totalSize.height <= 670 {
            fontSize = 25
            positX = 258
            leadTrail = 33
            wdthHght = 80
        } else {
            fontSize = 25
            positX = 323
            leadTrail = 30
            wdthHght = 80
        }
        let btn = UIButton()
        btn.setTitle("ЧТ", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        btn.backgroundColor = #colorLiteral(red: 0.9195359349, green: 0.6071895458, blue: 0.3224741801, alpha: 1)
        btn.layer.cornerRadius = 40
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(positX)
            make.trailing.equalToSuperview().inset(leadTrail)
            make.width.equalTo(wdthHght)
            make.height.equalTo(wdthHght)
        }
        
        return btn
    }()
    
    @objc func button4Action(sender: UIButton) {
        
        sender.zoomOutInfo()
        
        imageDay1.image = #imageLiteral(resourceName: "foodRation2000Thursday")
        
        if !foodRation2000_purchased {
            showinfoRestoreAlert()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                sender.zoomInInfo()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                
                if self.totalSize.height >= 920 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -47.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -48.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -47.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
                } else {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -44.0), animated: false)
                }
                
                self.backgroundScrollRation.isHidden = false
                self.backgroundScrollRation.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    self.backgroundScrollRation.transform = CGAffineTransform.identity
                    self.backgroundScrollRation.alpha = 1
                }

                self.scrollViewRation.isHidden = false
                self.labelDay1.isHidden = false
                self.labelDay1.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    self.labelDay1.transform = CGAffineTransform.identity
                    self.labelDay1.alpha = 1
                }
                self.imageDay1.isHidden = false
                self.imageDay1.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    self.imageDay1.transform = CGAffineTransform.identity
                    self.imageDay1.alpha = 1
                }

                self.closeScrollRationButton.isHidden = false

                Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
                    self.closeScrollRationButton.zoomInInfo()
                }

                self.closeScrollRationButton.addTarget(self, action: #selector(self.buttonCloseScrollRationAction(sender:)), for: .touchUpInside)
                
                sender.zoomInInfo()
            }
        }
    }
    //5
    @objc lazy var button5: UIButton = {
        let positX: CGFloat!
        let fontSize: CGFloat!
        let leadTrail: CGFloat!
        let wdthHght: CGFloat!
        if totalSize.height >= 920 {
            fontSize = 25
            positX = 281
            leadTrail = 109
            wdthHght = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 25
            positX = 283
            leadTrail = 105
            wdthHght = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 25
            positX = 241
            leadTrail = 102
            wdthHght = 80
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 25
            positX = 193
            leadTrail = 105
            wdthHght = 80
        } else if totalSize.height <= 670 {
            fontSize = 25
            positX = 173
            leadTrail = 95
            wdthHght = 80
        } else {
            fontSize = 25
            positX = 233
            leadTrail = 95
            wdthHght = 80
        }
        let btn = UIButton()
        btn.setTitle("ПТ", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        btn.backgroundColor = #colorLiteral(red: 0.9195359349, green: 0.6071895458, blue: 0.3224741801, alpha: 1)
        btn.layer.cornerRadius = 40
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(positX)
            make.trailing.equalToSuperview().inset(leadTrail)
            make.width.equalTo(wdthHght)
            make.height.equalTo(wdthHght)
        }
        
        return btn
    }()
    
    @objc func button5Action(sender: UIButton) {
        
        sender.zoomOut()
        
        imageDay1.image = #imageLiteral(resourceName: "foodRation2000Friday")
        
        if !foodRation2000_purchased {
            showinfoRestoreAlert()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                sender.zoomInInfo()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                
                if self.totalSize.height >= 920 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -47.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -48.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -47.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
                } else {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -44.0), animated: false)
                }
                
                self.backgroundScrollRation.isHidden = false
                self.backgroundScrollRation.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    self.backgroundScrollRation.transform = CGAffineTransform.identity
                    self.backgroundScrollRation.alpha = 1
                }

                self.scrollViewRation.isHidden = false
                self.labelDay1.isHidden = false
                self.labelDay1.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    self.labelDay1.transform = CGAffineTransform.identity
                    self.labelDay1.alpha = 1
                }
                self.imageDay1.isHidden = false
                self.imageDay1.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    self.imageDay1.transform = CGAffineTransform.identity
                    self.imageDay1.alpha = 1
                }

                self.closeScrollRationButton.isHidden = false

                Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
                    self.closeScrollRationButton.zoomInInfo()
                }

                self.closeScrollRationButton.addTarget(self, action: #selector(self.buttonCloseScrollRationAction(sender:)), for: .touchUpInside)
                
                sender.zoomInInfo()
            }
        }
    }
    //6
    @objc lazy var button6: UIButton = {
        let positX: CGFloat!
        let fontSize: CGFloat!
        let leadTrail: CGFloat!
        let wdthHght: CGFloat!
        if totalSize.height >= 920 {
            fontSize = 25
            positX = 281
            leadTrail = 109
            wdthHght = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 25
            positX = 283
            leadTrail = 105
            wdthHght = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 25
            positX = 241
            leadTrail = 102
            wdthHght = 80
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 25
            positX = 193
            leadTrail = 105
            wdthHght = 80
        } else if totalSize.height <= 670 {
            fontSize = 25
            positX = 173
            leadTrail = 95
            wdthHght = 80
        } else {
            fontSize = 25
            positX = 233
            leadTrail = 95
            wdthHght = 80
        }
        let btn = UIButton()
        btn.setTitle("СБ", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        btn.backgroundColor = #colorLiteral(red: 0.9195359349, green: 0.6071895458, blue: 0.3224741801, alpha: 1)
        btn.layer.cornerRadius = 40
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(positX)
            make.leading.equalToSuperview().inset(leadTrail)
            make.width.equalTo(wdthHght)
            make.height.equalTo(wdthHght)
        }
        
        return btn
    }()
    
    @objc func button6Action(sender: UIButton) {
        
        sender.zoomOut()
        
        imageDay1.image = #imageLiteral(resourceName: "foodRation2000Saturday")
        
        if !foodRation2000_purchased {
            showinfoRestoreAlert()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                sender.zoomInInfo()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                
                if self.totalSize.height >= 920 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -47.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -48.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -47.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
                } else {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -44.0), animated: false)
                }
                
                self.backgroundScrollRation.isHidden = false
                self.backgroundScrollRation.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    self.backgroundScrollRation.transform = CGAffineTransform.identity
                    self.backgroundScrollRation.alpha = 1
                }

                self.scrollViewRation.isHidden = false
                self.labelDay1.isHidden = false
                self.labelDay1.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    self.labelDay1.transform = CGAffineTransform.identity
                    self.labelDay1.alpha = 1
                }
                self.imageDay1.isHidden = false
                self.imageDay1.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    self.imageDay1.transform = CGAffineTransform.identity
                    self.imageDay1.alpha = 1
                }

                self.closeScrollRationButton.isHidden = false

                Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
                    self.closeScrollRationButton.zoomInInfo()
                }

                self.closeScrollRationButton.addTarget(self, action: #selector(self.buttonCloseScrollRationAction(sender:)), for: .touchUpInside)
                
                sender.zoomInInfo()
            }
        }
    }
    //7
    @objc lazy var button7: UIButton = {
        let wdthHght: CGFloat!
        let positX: CGFloat!
        let fontSize: CGFloat!
        let leadTrail: CGFloat!
        if totalSize.height >= 920 {
            fontSize = 25
            positX = 376
            leadTrail = 35
            wdthHght = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 25
            positX = 380
            leadTrail = 35
            wdthHght = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 25
            positX = 335
            leadTrail = 33
            wdthHght = 80
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 25
            positX = 285
            leadTrail = 33
            wdthHght = 80
        } else if totalSize.height <= 670 {
            fontSize = 25
            positX = 258
            leadTrail = 33
            wdthHght = 80
        } else {
            fontSize = 25
            positX = 323
            leadTrail = 30
            wdthHght = 80
        }
        let btn = UIButton()
        btn.setTitle("ВС", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        btn.backgroundColor = #colorLiteral(red: 0.9195359349, green: 0.6071895458, blue: 0.3224741801, alpha: 1)
        btn.layer.cornerRadius = 40
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(positX)
            make.leading.equalToSuperview().inset(leadTrail)
            make.width.equalTo(wdthHght)
            make.height.equalTo(wdthHght)
        }
        
        return btn
    }()
    
    @objc func button7Action(sender: UIButton) {
        
        sender.zoomOut()
        
        imageDay1.image = #imageLiteral(resourceName: "foodRation2000Sunday")
        
        if !foodRation2000_purchased {
            showinfoRestoreAlert()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                sender.zoomInInfo()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                
                if self.totalSize.height >= 920 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -47.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -48.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -47.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
                } else {
                    self.scrollViewRation.setContentOffset(CGPoint(x: 0.0, y: -44.0), animated: false)
                }
                
                self.backgroundScrollRation.isHidden = false
                self.backgroundScrollRation.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    self.backgroundScrollRation.transform = CGAffineTransform.identity
                    self.backgroundScrollRation.alpha = 1
                }

                self.scrollViewRation.isHidden = false
                self.labelDay1.isHidden = false
                self.labelDay1.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    self.labelDay1.transform = CGAffineTransform.identity
                    self.labelDay1.alpha = 1
                }
                self.imageDay1.isHidden = false
                self.imageDay1.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    self.imageDay1.transform = CGAffineTransform.identity
                    self.imageDay1.alpha = 1
                }

                self.closeScrollRationButton.isHidden = false

                Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
                    self.closeScrollRationButton.zoomInInfo()
                }

                self.closeScrollRationButton.addTarget(self, action: #selector(self.buttonCloseScrollRationAction(sender:)), for: .touchUpInside)
                
                sender.zoomInInfo()
            }
        }
    }
//MARK: - AlertInfo
    private func showinfoRestoreAlert() {
        let alert = UIAlertController(title: "Доступ закрыт", message: "Для ознакомления с рационом, Вам доступен бесплатно только 'Понедельник'.", preferredStyle: .alert)
            
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default))
        alert.addAction(UIAlertAction(title: "Купить", style: .cancel, handler: { action in
            
            self.activityIndicator.startAnimating()
            
            SwiftyStoreKit.purchaseProduct("com.transform.fitness.foodRation2000", quantity: 1, atomically: true) { result in
                switch result {
                case .success(let purchase):
                    
                    UserDefaults.standard.set(true, forKey: "foodRation2000_purchased")
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "successfulPurchaseFoodRation2000"), object: nil)
                    
                    self.foodRation2000_purchased = true
                    
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
        
        }))
        
        present(alert, animated: true, completion: nil)
    }
//MARK: StatusBar
    override var prefersStatusBarHidden: Bool {
        return true
        }
    }


