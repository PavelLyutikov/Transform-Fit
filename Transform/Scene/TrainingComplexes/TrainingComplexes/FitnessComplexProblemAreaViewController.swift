//
//  TrainingTableViewController.swift
//  Transform
//
//  Created by Pavel Lyutikov on 06.07.2021.
//

import UIKit
import AVKit
import AVFoundation
import CachingPlayerItem
import SwiftyStoreKit

var playerOne = AVPlayer()
var playerTwo = AVPlayer()
var playerThree = AVPlayer()
var playerFour = AVPlayer()
var playerFive = AVPlayer()
var playerSix = AVPlayer()
var playerSeven = AVPlayer()
var playerEight = AVPlayer()
var playerNine = AVPlayer()
var playerTen = AVPlayer()
var playerEleven = AVPlayer()
var playerTwelve = AVPlayer()

var openWorkoutOne: Bool = false
var openWorkoutTwo: Bool = false
var openWorkoutThree: Bool = false
var openWorkoutFour: Bool = false
var openWorkoutFive: Bool = false
var openWorkoutSix: Bool = false
var openWorkoutSeven: Bool = false
var openWorkoutEight: Bool = false
var openWorkoutNine: Bool = false
var openWorkoutTen: Bool = false
var openWorkoutEleven: Bool = false
var openWorkoutTwelve: Bool = false

class FitnessComplexProblemAreaViewController: UIViewController {
    
    let totalSize = UIScreen.main.bounds.size

    let scrollView = UIScrollView()
    let contentView = UIView()
    
    var problemAreaComplex_purchased: Bool = false
    
    var activityIndicator = UIActivityIndicatorView()
    
//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        backgroundImage.isHidden = false
        
        button1.addTarget(self, action: #selector(button1Action(sender:)), for: .touchUpInside)
        button2.addTarget(self, action: #selector(button2Action(sender:)), for: .touchUpInside)
        button3.addTarget(self, action: #selector(button3Action(sender:)), for: .touchUpInside)
        button4.addTarget(self, action: #selector(button4Action(sender:)), for: .touchUpInside)
        button5.addTarget(self, action: #selector(button5Action(sender:)), for: .touchUpInside)
        button6.addTarget(self, action: #selector(button6Action(sender:)), for: .touchUpInside)
        button7.addTarget(self, action: #selector(button7Action(sender:)), for: .touchUpInside)
        button8.addTarget(self, action: #selector(button8Action(sender:)), for: .touchUpInside)
        button9.addTarget(self, action: #selector(button9Action(sender:)), for: .touchUpInside)
        button10.addTarget(self, action: #selector(button10Action(sender:)), for: .touchUpInside)
        button11.addTarget(self, action: #selector(button11Action(sender:)), for: .touchUpInside)
        button12.addTarget(self, action: #selector(button12Action(sender:)), for: .touchUpInside)
        
        dismissButton.addTarget(self, action: #selector(buttonDismiss), for: .touchUpInside)
        resetResultButton.addTarget(self, action: #selector(resetResultButtonAction(sender:)), for: .touchUpInside)
        infoButton.addTarget(self, action: #selector(buttonInfoAction(sender:)), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(FitnessComplexProblemAreaViewController.oneButtonUpload), name: NSNotification.Name(rawValue: "oneButtonUpload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FitnessComplexProblemAreaViewController.twoButtonUpload), name: NSNotification.Name(rawValue: "twoButtonUpload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FitnessComplexProblemAreaViewController.threeButtonUpload), name: NSNotification.Name(rawValue: "threeButtonUpload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FitnessComplexProblemAreaViewController.fourButtonUpload), name: NSNotification.Name(rawValue: "fourButtonUpload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FitnessComplexProblemAreaViewController.fiveButtonUpload), name: NSNotification.Name(rawValue: "fiveButtonUpload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FitnessComplexProblemAreaViewController.sixButtonUpload), name: NSNotification.Name(rawValue: "sixButtonUpload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FitnessComplexProblemAreaViewController.sevenButtonUpload), name: NSNotification.Name(rawValue: "sevenButtonUpload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FitnessComplexProblemAreaViewController.eightButtonUpload), name: NSNotification.Name(rawValue: "eightButtonUpload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FitnessComplexProblemAreaViewController.nineButtonUpload), name: NSNotification.Name(rawValue: "nineButtonUpload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FitnessComplexProblemAreaViewController.tenButtonUpload), name: NSNotification.Name(rawValue: "tenButtonUpload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FitnessComplexProblemAreaViewController.elevenButtonUpload), name: NSNotification.Name(rawValue: "elevenButtonUpload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FitnessComplexProblemAreaViewController.twelveButtonUpload), name: NSNotification.Name(rawValue: "twelveButtonUpload"), object: nil)
        
        
        setupActivityIndicator()
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        if !UserDefaults.standard.bool(forKey: "problemAreaComplex_purchased") {
            
            let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: "56e3e9f9829043bb8e404111d191ae2b")
            SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
                switch result {
                case .success(let receipt):
                    let productId = "com.transform.fitness.complexesProblemAreas"
                    // Verify the purchase of Consumable or NonConsumable
                    let purchaseResult = SwiftyStoreKit.verifyPurchase(
                        productId: productId,
                        inReceipt: receipt)
                        
                    switch purchaseResult {
                    case .purchased(let receiptItem):
                        UserDefaults.standard.set(true, forKey: "problemAreaComplex_purchased")

                        self.problemAreaComplex_purchased = true
                        
                        print("\(productId) is purchased: \(receiptItem)")
                    case .notPurchased:
                        
                        self.buttonPurchaseComplex.addTarget(self, action: #selector(self.buttonPurchaseComplexAction(sender:)), for: .touchUpInside)
                        self.buttonRestoredPurchase.addTarget(self, action: #selector(self.actionButtonRestoredPurchase(sender:)), for: .touchUpInside)
                        
                        print("The user has never purchased \(productId)")
                    }
                    case .error(let error):
                        
                        self.buttonPurchaseComplex.addTarget(self, action: #selector(self.buttonPurchaseComplexAction(sender:)), for: .touchUpInside)
                        self.buttonRestoredPurchase.addTarget(self, action: #selector(self.actionButtonRestoredPurchase(sender:)), for: .touchUpInside)
                        
                        print("Receipt verification failed: \(error)")
                }
                self.activityIndicator.stopAnimating()
            }
        
        } else {
            
            self.problemAreaComplex_purchased = true
            
            self.activityIndicator.stopAnimating()
        }
        
        //SuccessfulPurchase
        NotificationCenter.default.addObserver(self, selector: #selector(FitnessComplexProblemAreaViewController.successfulPurchaseProblemArea), name: NSNotification.Name(rawValue: "successfulPurchaseProblemArea"), object: nil)
        
        setupScrollView()
        setupViews()
    }
//MARK: - SuccessfulPurchase
    @objc func successfulPurchaseProblemArea() {
        
        buttonRestoredPurchase.zoomOutInfo()
        buttonPurchaseComplex.zoomOutInfo()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.buttonRestoredPurchase.isHidden = true
            self.buttonPurchaseComplex.isHidden = true
        }
    }
//MARK: - ActivityIndicator
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        activityIndicator.center = self.view.center
        activityIndicator.style = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = #colorLiteral(red: 0.3771294951, green: 0.6631640792, blue: 0.6894379258, alpha: 1)
        activityIndicator.layer.cornerRadius = 15
        activityIndicator.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        activityIndicator.layer.shadowRadius = 3
        activityIndicator.layer.shadowOffset = CGSize(width: 0, height: 0)
        activityIndicator.layer.shadowOpacity = 0.4
        activityIndicator.layer.zPosition = 30
    }
//MARK: - ButtonPurchase
    lazy var buttonPurchaseComplex: UIButton = {
        var width: CGFloat!
        var bttmPosit: CGFloat!
        var height: CGFloat!
        var lead: CGFloat!
        if totalSize.height >= 920 {
            bttmPosit = 70
            height = 120
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            bttmPosit = 60
            height = 120
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            bttmPosit = 80
            height = 110
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            bttmPosit = 50
            height = 120
        } else if totalSize.height <= 670 {
            bttmPosit = 50
            height = 110
        } else {
            bttmPosit = 60
            height = 110
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "buttonBuyProblemArea"), for: .normal)
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
    
    @objc func buttonPurchaseComplexAction(sender: UIButton) {
        activityIndicator.startAnimating()
        
        SwiftyStoreKit.purchaseProduct("com.transform.fitness.complexesProblemAreas", quantity: 1, atomically: true) { result in
            switch result {
            case .success(let purchase):
                
                UserDefaults.standard.set(true, forKey: "problemAreaComplex_purchased")
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "successfulPurchaseProblemArea"), object: nil)
                
                self.problemAreaComplex_purchased = true
                
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
                        let productId = "com.transform.fitness.complexesProblemAreas"
                        // Verify the purchase of Consumable or NonConsumable
                        let purchaseResult = SwiftyStoreKit.verifyPurchase(
                            productId: productId,
                            inReceipt: receipt)
                            
                        switch purchaseResult {
                        case .purchased(let receiptItem):
                            UserDefaults.standard.set(true, forKey: "problemAreaComplex_purchased")
                            
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "successfulPurchaseProblemArea"), object: nil)
                            
                            self.problemAreaComplex_purchased = true
                            
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
//MARK: - UploadButton
    @objc func oneButtonUpload() {
        button1.zoomOut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.button1.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.button1.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
                self.button1.isHidden = false
                self.button1.zoomIn()
            }
        }
    }
    @objc func twoButtonUpload() {
        button2.zoomOut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.button2.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.button2.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
                self.button2.isHidden = false
                self.button2.zoomIn()
            }
        }
    }
    @objc func threeButtonUpload() {
        button3.zoomOut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.button3.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.button3.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
                self.button3.isHidden = false
                self.button3.zoomIn()
            }
        }
    }
    @objc func fourButtonUpload() {
        button4.zoomOut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.button4.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.button4.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
                self.button4.isHidden = false
                self.button4.zoomIn()
            }
        }
    }
    @objc func fiveButtonUpload() {
        button5.zoomOut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.button5.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.button5.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
                self.button5.isHidden = false
                self.button5.zoomIn()
            }
        }
    }
    @objc func sixButtonUpload() {
        button6.zoomOut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.button6.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.button6.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
                self.button6.isHidden = false
                self.button6.zoomIn()
            }
        }
    }
    @objc func sevenButtonUpload() {
        button5.zoomOut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.button7.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.button7.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
                self.button7.isHidden = false
                self.button7.zoomIn()
            }
        }
    }
    @objc func eightButtonUpload() {
        button8.zoomOut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.button8.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.button8.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
                self.button8.isHidden = false
                self.button8.zoomIn()
            }
        }
    }
    @objc func nineButtonUpload() {
        button9.zoomOut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.button9.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.button9.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
                self.button9.isHidden = false
                self.button9.zoomIn()
            }
        }
    }
    @objc func tenButtonUpload() {
        button10.zoomOut()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.button10.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.button10.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
                self.button10.isHidden = false
                self.button10.zoomIn()
            }
        }
    }
    @objc func elevenButtonUpload() {
        button11.zoomOut()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.button11.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.button11.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
                self.button11.isHidden = false
                self.button11.zoomIn()
            }
        }
    }
    @objc func twelveButtonUpload() {
        button12.zoomOut()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.button12.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.button12.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
                self.button12.isHidden = false
                self.button12.zoomIn()
            }
        }
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
            positTop = 250
            positBttm = -250
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positTop = 245
            positBttm = -245
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positTop = 233
            positBttm = -233
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positTop = 165
            positBttm = -165
        } else if totalSize.height <= 670 {
            positTop = 152
            positBttm = -152
        } else {
            positTop = 215
            positBttm = -215
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
            positTop = -190
            positBttm = 200
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 3.5/4
            positTop = -190
            positBttm = 200
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 3.2/4
            positTop = -110
            positBttm = 120
        } else if totalSize.height <= 670 {
            wdth = 3.2/4
            positTop = -80
            positBttm = 90
        } else {
            wdth = 3.7/4
            positTop = -150
            positBttm = 160
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
                        Укрепляющий комплекс с акцентом на ягодицы, пресс, ноги, руки и коррекцию осанки.
                        Полноценные видео тренировки с подробным объяснением по технике, а так же полезными комментариями от тренера. Это позволит вам полностью погрузиться в тренировочный процесс, а голос тренера будет только мотивировать и подбадривать в процессе занятия.
                        
                        Каждая тренировка  длительностью 20-60 мин.
                        Рассчитаны на месяц занятий.
                        Каждая тренировка состоит из:
                        - Разминки;
                        - Основной части;
                        - Заминки (растяжка).
                        
                        Уровень сложности: подойдёт новичкам и опытным.
                        
                        Дополнительное оборудование: не требуется, но возможно использовать любые отягощения для дополнительной нагрузки. В случая не достаточной нагрузки, с использованием дополнительного отягощения вы можете выполнять комплекс повторно.
                        
                        Противопоказания: не рекомендуется выполнять людям с нарушением О.Д.А. Если у вас есть противопоказания, проконсультируйтесь со специалистом.
                        """
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.textAlignment = .natural
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
            Комплекс тренировок на  «Проблемные зоны»
            """
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: fnt)
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
//MARK: InfoButton
        @objc lazy var infoButton: UIButton = {
            let positX: CGFloat!
            let trail: CGFloat!
            if totalSize.height >= 830 {
                positX = 68
                trail = 105
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                positX = 35
                trail = 100
            } else if totalSize.height <= 670 {
                positX = 35
                trail = 100
            } else {
                positX = 50
                trail = 110
            }
            let btn = UIButton()
            btn.setImage(#imageLiteral(resourceName: "informationComplex"), for: .normal)
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
                trail = 35
                positTop = 265
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                trail = 35
                positTop = 260
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                trail = 35
                positTop = 245
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                trail = 40
                positTop = 180
            } else if totalSize.height <= 670 {
                trail = 40
                positTop = 165
            } else {
                trail = 30
                positTop = 227
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
        var image = UIImageView(image: #imageLiteral(resourceName: "infoBackgroundTurquoise"))
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
//MARK: BackgroundImage
    lazy var backgroundImage: UIImageView = {
        var image = UIImageView(image: #imageLiteral(resourceName: "backgroundProblemAreaComplex"))
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.layer.zPosition = 0
        image.alpha = 0.15
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

        let vc = HomeWorkoutTrainingComplexesViewController()
        vc.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: false, completion: nil)
    }
//MARK: - ResetResultButton
    @objc lazy var resetResultButton: UIButton = {

        let top: CGFloat!
        let trail: CGFloat!
        if totalSize.height >= 830 {
            top = 65
            trail = 30
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            top = 30
            trail = 25
        } else if totalSize.height <= 670 {
            top = 30
            trail = 25
        } else {
            top = 45
            trail = 35
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "resetButton"), for: .normal)
        btn.layer.zPosition = 4
        btn.layer.cornerRadius = 5
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(top)
            make.trailing.equalToSuperview().inset(trail)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        return btn
    }()
    @objc func resetResultButtonAction(sender: UIButton) {
        sender.zoomOutInfo()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.zoomInInfo()
            
            let alert = UIAlertController(title: "Сброс прогресса", message: "Вы действительно хотите сбросить прогресс выполнения тренировок?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: { action in

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.button1.zoomOutInfo()
                
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        self.button1.isHidden = true
                        
                        self.button2.zoomOutInfo()
                        self.button4.zoomOutInfo()
                        self.button5.zoomOutInfo()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            self.button1.backgroundColor = #colorLiteral(red: 0.4567757249, green: 0.8083776832, blue: 0.8391091228, alpha: 0.85)
                            self.button1.isHidden = false
                            self.button1.zoomInInfo()
                            
                            self.button2.isHidden = true
                            self.button4.isHidden = true
                            self.button5.isHidden = true
                            
                            self.button3.zoomOutInfo()
                            self.button6.zoomOutInfo()
                            self.button7.zoomOutInfo()
                            self.button8.zoomOutInfo()
                            self.button9.zoomOutInfo()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                self.button2.backgroundColor = #colorLiteral(red: 0.4567757249, green: 0.8083776832, blue: 0.8391091228, alpha: 0.85)
                                self.button4.backgroundColor = #colorLiteral(red: 0.4567757249, green: 0.8083776832, blue: 0.8391091228, alpha: 0.85)
                                self.button5.backgroundColor = #colorLiteral(red: 0.4567757249, green: 0.8083776832, blue: 0.8391091228, alpha: 0.85)
                                self.button2.isHidden = false
                                self.button4.isHidden = false
                                self.button5.isHidden = false
                                self.button2.zoomInInfo()
                                self.button4.zoomInInfo()
                                self.button5.zoomInInfo()
                                
                                
                                self.button3.isHidden = true
                                self.button6.isHidden = true
                                self.button7.isHidden = true
                                self.button8.isHidden = true
                                self.button9.isHidden = true
                                
                                self.button10.zoomOutInfo()
                                self.button11.zoomOutInfo()
                                self.button12.zoomOutInfo()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    self.button3.backgroundColor = #colorLiteral(red: 0.4567757249, green: 0.8083776832, blue: 0.8391091228, alpha: 0.85)
                                    self.button6.backgroundColor = #colorLiteral(red: 0.4567757249, green: 0.8083776832, blue: 0.8391091228, alpha: 0.85)
                                    self.button7.backgroundColor = #colorLiteral(red: 0.4567757249, green: 0.8083776832, blue: 0.8391091228, alpha: 0.85)
                                    self.button8.backgroundColor = #colorLiteral(red: 0.4567757249, green: 0.8083776832, blue: 0.8391091228, alpha: 0.85)
                                    self.button9.backgroundColor = #colorLiteral(red: 0.4567757249, green: 0.8083776832, blue: 0.8391091228, alpha: 0.85)
                                    self.button3.isHidden = false
                                    self.button6.isHidden = false
                                    self.button7.isHidden = false
                                    self.button8.isHidden = false
                                    self.button9.isHidden = false
                                    self.button3.zoomInInfo()
                                    self.button6.zoomInInfo()
                                    self.button7.zoomInInfo()
                                    self.button8.zoomInInfo()
                                    self.button9.zoomInInfo()
                                    
                                    
                                    self.button10.isHidden = true
                                    self.button11.isHidden = true
                                    self.button12.isHidden = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        self.button10.backgroundColor = #colorLiteral(red: 0.4567757249, green: 0.8083776832, blue: 0.8391091228, alpha: 0.85)
                                        self.button11.backgroundColor = #colorLiteral(red: 0.4567757249, green: 0.8083776832, blue: 0.8391091228, alpha: 0.85)
                                        self.button12.backgroundColor = #colorLiteral(red: 0.4567757249, green: 0.8083776832, blue: 0.8391091228, alpha: 0.85)
                                        self.button10.isHidden = false
                                        self.button11.isHidden = false
                                        self.button12.isHidden = false
                                        self.button10.zoomInInfo()
                                        self.button11.zoomInInfo()
                                        self.button12.zoomInInfo()
                                    }
                                }
                            }
                        }
                    }
                }

            }))
            alert.addAction(UIAlertAction(title: "Закрыть", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        UserDefaults.standard.set(false, forKey: "oneWorkoutOver")
        UserDefaults.standard.set(false, forKey: "twoWorkoutOver")
        UserDefaults.standard.set(false, forKey: "threeWorkoutOver")
        UserDefaults.standard.set(false, forKey: "fourWorkoutOver")
        UserDefaults.standard.set(false, forKey: "fiveWorkoutOver")
        UserDefaults.standard.set(false, forKey: "sixWorkoutOver")
        UserDefaults.standard.set(false, forKey: "sevenWorkoutOver")
        UserDefaults.standard.set(false, forKey: "eightWorkoutOver")
        UserDefaults.standard.set(false, forKey: "nineWorkoutOver")
        UserDefaults.standard.set(false, forKey: "tenWorkoutOver")
        UserDefaults.standard.set(false, forKey: "elevenWorkoutOver")
        UserDefaults.standard.set(false, forKey: "twelveWorkoutOver")
    }
//MARK: - ButtonMenu
    //1
    @objc lazy var button1: UIButton = {
        let positX: CGFloat!
        let fontSize: CGFloat!
        let leadTrail: CGFloat!
        let wdthHght: CGFloat!
        if totalSize.height >= 920 {
            fontSize = 24
            positX = 600
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 25
            positX = 600
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 27
            positX = 570
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 27
            positX = 490
            leadTrail = 60
            wdthHght = 70
        } else if totalSize.height <= 670 {
            fontSize = 27
            positX = 470
            leadTrail = 50
            wdthHght = 70
        } else {
            fontSize = 27
            positX = 540
            leadTrail = 40
            wdthHght = 80
        }
        let btn = UIButton()
        btn.setTitle("1", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        if !UserDefaults.standard.bool(forKey: "oneWorkoutOver") {
            btn.backgroundColor = #colorLiteral(red: 0.4567757249, green: 0.8083776832, blue: 0.8391091228, alpha: 0.85)
        } else {
            btn.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
        }
        btn.layer.cornerRadius = 5
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let videoURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/GoodFit%2F1.mp4?alt=media&token=d71f67c0-9282-4e8f-8c83-8227ca9d435d")
            playerOne = AVPlayer(url: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = playerOne
            
            playerViewController.modalPresentationStyle = .fullScreen
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
                openWorkoutOne = true
                
                sender.zoomInInfo()
            }
        }
    }
    //2
    @objc lazy var button2: UIButton = {
        let positX: CGFloat!
        let fontSize: CGFloat!
        let leadTrail: CGFloat!
        let wdthHght: CGFloat!
        if totalSize.height >= 920 {
            fontSize = 24
            positX = 600
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 25
            positX = 600
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 27
            positX = 570
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 27
            positX = 490
            leadTrail = 60
            wdthHght = 70
        } else if totalSize.height <= 670 {
            fontSize = 27
            positX = 470
            leadTrail = 50
            wdthHght = 70
        } else {
            fontSize = 27
            positX = 540
            leadTrail = 40
            wdthHght = 80
        }
        let btn = UIButton()
        btn.setTitle("2", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        if !UserDefaults.standard.bool(forKey: "twoWorkoutOver") {
            btn.backgroundColor = #colorLiteral(red: 0.4567757249, green: 0.8083776832, blue: 0.8391091228, alpha: 0.85)
        } else {
            btn.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
        }
        btn.layer.cornerRadius = 5
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
        
        if !problemAreaComplex_purchased {
            showinfoRestoreAlert()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                sender.zoomInInfo()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let videoURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/GoodFit%2F2.mp4?alt=media&token=70b393a3-532f-400f-a860-6a3e1af49f1f")
                playerTwo = AVPlayer(url: videoURL!)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = playerTwo
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                    
                    openWorkoutTwo = true
                    sender.zoomInInfo()
                }
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
            fontSize = 24
            positX = 600
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 25
            positX = 600
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 27
            positX = 570
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 27
            positX = 490
            leadTrail = 60
            wdthHght = 70
        } else if totalSize.height <= 670 {
            fontSize = 27
            positX = 470
            leadTrail = 50
            wdthHght = 70
        } else {
            fontSize = 27
            positX = 540
            leadTrail = 40
            wdthHght = 80
        }
        let btn = UIButton()
        btn.setTitle("3", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        if !UserDefaults.standard.bool(forKey: "threeWorkoutOver") {
            btn.backgroundColor = #colorLiteral(red: 0.4567757249, green: 0.8083776832, blue: 0.8391091228, alpha: 0.85)
        } else {
            btn.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
        }
        btn.layer.cornerRadius = 5
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
        
        if !problemAreaComplex_purchased {
            showinfoRestoreAlert()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                sender.zoomInInfo()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let videoURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/GoodFit%2F3.mp4?alt=media&token=303ec91f-7522-4ac3-8d3f-69f2883e5a00")
                playerThree = AVPlayer(url: videoURL!)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = playerThree
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                    
                    openWorkoutThree = true
                    sender.zoomInInfo()
                }
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
            fontSize = 24
            positX = 470
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 25
            positX = 470
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 27
            positX = 440
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 27
            positX = 380
            leadTrail = 60
            wdthHght = 70
        } else if totalSize.height <= 670 {
            fontSize = 27
            positX = 360
            leadTrail = 50
            wdthHght = 70
        } else {
            fontSize = 27
            positX = 420
            leadTrail = 40
            wdthHght = 80
        }
        let btn = UIButton()
        btn.setTitle("4", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        if !UserDefaults.standard.bool(forKey: "fourWorkoutOver") {
            btn.backgroundColor = #colorLiteral(red: 0.4567757249, green: 0.8083776832, blue: 0.8391091228, alpha: 0.85)
        } else {
            btn.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
        }
        btn.layer.cornerRadius = 5
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
    
    @objc func button4Action(sender: UIButton) {
        
        sender.zoomOutInfo()
        
        if !problemAreaComplex_purchased {
            showinfoRestoreAlert()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                sender.zoomInInfo()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let videoURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/GoodFit%2F4.mp4?alt=media&token=c772efd5-61e8-4c75-a930-c603dd5b5c2f")
                playerFour = AVPlayer(url: videoURL!)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = playerFour
                
                playerViewController.modalPresentationStyle = .fullScreen
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                    
                    openWorkoutFour = true
                    sender.zoomInInfo()
                }
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
            fontSize = 24
            positX = 470
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 25
            positX = 470
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 27
            positX = 440
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 27
            positX = 380
            leadTrail = 60
            wdthHght = 70
        } else if totalSize.height <= 670 {
            fontSize = 27
            positX = 360
            leadTrail = 50
            wdthHght = 70
        } else {
            fontSize = 27
            positX = 420
            leadTrail = 40
            wdthHght = 80
        }
        let btn = UIButton()
        btn.setTitle("5", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        if !UserDefaults.standard.bool(forKey: "fiveWorkoutOver") {
            btn.backgroundColor = #colorLiteral(red: 0.4567757249, green: 0.8083776832, blue: 0.8391091228, alpha: 0.85)
        } else {
            btn.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
        }
        btn.layer.cornerRadius = 5
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
    
    @objc func button5Action(sender: UIButton) {
        
        sender.zoomOut()
        
        if !problemAreaComplex_purchased {
            showinfoRestoreAlert()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                sender.zoomIn()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let videoURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/GoodFit%2F5.mp4?alt=media&token=2b817779-5ccf-4d1d-a0cb-0fe4b3eaead7")
                playerFive = AVPlayer(url: videoURL!)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = playerFive
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                    
                    openWorkoutFive = true
                    sender.zoomIn()
                }
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
            fontSize = 24
            positX = 470
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 25
            positX = 470
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 27
            positX = 440
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 27
            positX = 380
            leadTrail = 60
            wdthHght = 70
        } else if totalSize.height <= 670 {
            fontSize = 27
            positX = 360
            leadTrail = 50
            wdthHght = 70
        } else {
            fontSize = 27
            positX = 420
            leadTrail = 40
            wdthHght = 80
        }
        let btn = UIButton()
        btn.setTitle("6", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        if !UserDefaults.standard.bool(forKey: "sixWorkoutOver") {
            btn.backgroundColor = #colorLiteral(red: 0.4567757249, green: 0.8083776832, blue: 0.8391091228, alpha: 0.85)
        } else {
            btn.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
        }
        btn.layer.cornerRadius = 5
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
    
    @objc func button6Action(sender: UIButton) {
        
        sender.zoomOut()
        
        if !problemAreaComplex_purchased {
            showinfoRestoreAlert()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                sender.zoomIn()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let videoURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/GoodFit%2F6.mp4?alt=media&token=33f3a298-0fbf-4a2a-9c31-fc6b5431d4f9")
                playerSix = AVPlayer(url: videoURL!)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = playerSix
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                    
                    openWorkoutSix = true
                    sender.zoomIn()
                }
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
            fontSize = 24
            positX = 340
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 25
            positX = 340
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 27
            positX = 310
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 27
            positX = 270
            leadTrail = 60
            wdthHght = 70
        } else if totalSize.height <= 670 {
            fontSize = 27
            positX = 250
            leadTrail = 50
            wdthHght = 70
        } else {
            fontSize = 27
            positX = 300
            leadTrail = 40
            wdthHght = 80
        }
        let btn = UIButton()
        btn.setTitle("7", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        if !UserDefaults.standard.bool(forKey: "sevenWorkoutOver") {
            btn.backgroundColor = #colorLiteral(red: 0.4567757249, green: 0.8083776832, blue: 0.8391091228, alpha: 0.85)
        } else {
            btn.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
        }
        btn.layer.cornerRadius = 5
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
        
        if !problemAreaComplex_purchased {
            showinfoRestoreAlert()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                sender.zoomIn()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let videoURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/GoodFit%2F7.mp4?alt=media&token=4b66fde5-d0fa-41bd-80c6-903e86e1a1e0")
                playerSeven = AVPlayer(url: videoURL!)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = playerSeven
                
                playerViewController.modalPresentationStyle = .fullScreen
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                    
                    openWorkoutSeven = true
                    sender.zoomIn()
                }
            }
        }
    }
    //8
    @objc lazy var button8: UIButton = {
        let wdthHght: CGFloat!
        let positX: CGFloat!
        let fontSize: CGFloat!
        let leadTrail: CGFloat!
        if totalSize.height >= 920 {
            fontSize = 24
            positX = 340
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 25
            positX = 340
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 27
            positX = 310
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 27
            positX = 270
            leadTrail = 60
            wdthHght = 70
        } else if totalSize.height <= 670 {
            fontSize = 27
            positX = 250
            leadTrail = 50
            wdthHght = 70
        } else {
            fontSize = 27
            positX = 300
            leadTrail = 40
            wdthHght = 80
        }
        let btn = UIButton()
        btn.setTitle("8", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        if !UserDefaults.standard.bool(forKey: "eightWorkoutOver") {
            btn.backgroundColor = #colorLiteral(red: 0.4567757249, green: 0.8083776832, blue: 0.8391091228, alpha: 0.85)
        } else {
            btn.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
        }
        btn.layer.cornerRadius = 5
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
    
    @objc func button8Action(sender: UIButton) {
        
        sender.zoomOut()
        
        if !problemAreaComplex_purchased {
            showinfoRestoreAlert()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                sender.zoomIn()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let videoURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/GoodFit%2F8.mp4?alt=media&token=e5074868-ccc1-4d0f-a604-9376c2f3b024")
                playerEight = AVPlayer(url: videoURL!)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = playerEight
                
                playerViewController.modalPresentationStyle = .fullScreen
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                    
                    openWorkoutEight = true
                    sender.zoomIn()
                }
            }
        }
    }
    //9
    @objc lazy var button9: UIButton = {
        let wdthHght: CGFloat!
        let positX: CGFloat!
        let fontSize: CGFloat!
        let leadTrail: CGFloat!
        if totalSize.height >= 920 {
            fontSize = 24
            positX = 340
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 25
            positX = 340
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 27
            positX = 310
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 27
            positX = 270
            leadTrail = 60
            wdthHght = 70
        } else if totalSize.height <= 670 {
            fontSize = 27
            positX = 250
            leadTrail = 50
            wdthHght = 70
        } else {
            fontSize = 27
            positX = 300
            leadTrail = 40
            wdthHght = 80
        }
        let btn = UIButton()
        btn.setTitle("9", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        if !UserDefaults.standard.bool(forKey: "nineWorkoutOver") {
            btn.backgroundColor = #colorLiteral(red: 0.4567757249, green: 0.8083776832, blue: 0.8391091228, alpha: 0.85)
        } else {
            btn.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
        }
        btn.layer.cornerRadius = 5
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
    
    @objc func button9Action(sender: UIButton) {
        
        sender.zoomOut()
        
        if !problemAreaComplex_purchased {
            showinfoRestoreAlert()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                sender.zoomIn()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let videoURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/GoodFit%2F9.mp4?alt=media&token=20fcb80f-2754-4b5c-8990-bd5bb4ac18a2")
                playerNine = AVPlayer(url: videoURL!)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = playerNine
                
                playerViewController.modalPresentationStyle = .fullScreen
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                    
                    openWorkoutNine = true
                    sender.zoomIn()
                }
            }
        }
    }
    //10
    @objc lazy var button10: UIButton = {
        let positX: CGFloat!
        let fontSize: CGFloat!
        let leadTrail: CGFloat!
        let wdthHght: CGFloat!
        if totalSize.height >= 920 {
            fontSize = 24
            positX = 210
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 25
            positX = 210
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 27
            positX = 180
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 27
            positX = 160
            leadTrail = 60
            wdthHght = 70
        } else if totalSize.height <= 670 {
            fontSize = 27
            positX = 140
            leadTrail = 50
            wdthHght = 70
        } else {
            fontSize = 27
            positX = 180
            leadTrail = 40
            wdthHght = 80
        }
        let btn = UIButton()
        btn.setTitle("10", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        if !UserDefaults.standard.bool(forKey: "tenWorkoutOver") {
            btn.backgroundColor = #colorLiteral(red: 0.4567757249, green: 0.8083776832, blue: 0.8391091228, alpha: 0.85)
        } else {
            btn.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
        }
        btn.layer.cornerRadius = 5
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
    
    @objc func button10Action(sender: UIButton) {
        
        sender.zoomOut()
        
        if !problemAreaComplex_purchased {
            showinfoRestoreAlert()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                sender.zoomIn()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let videoURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/GoodFit%2F10.mp4?alt=media&token=3c6a25df-07e7-4a25-ac0f-d270a16bd9a6")
                playerTen = AVPlayer(url: videoURL!)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = playerTen
                
                playerViewController.modalPresentationStyle = .fullScreen
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                    
                    openWorkoutTen = true
                    sender.zoomIn()
                }
            }
        }
    }
    //11
    @objc lazy var button11: UIButton = {
        let positX: CGFloat!
        let fontSize: CGFloat!
        let leadTrail: CGFloat!
        let wdthHght: CGFloat!
        if totalSize.height >= 920 {
            fontSize = 24
            positX = 210
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 25
            positX = 210
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 27
            positX = 180
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 27
            positX = 160
            leadTrail = 60
            wdthHght = 70
        } else if totalSize.height <= 670 {
            fontSize = 27
            positX = 140
            leadTrail = 50
            wdthHght = 70
        } else {
            fontSize = 27
            positX = 180
            leadTrail = 40
            wdthHght = 80
        }
        let btn = UIButton()
        btn.setTitle("11", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        if !UserDefaults.standard.bool(forKey: "elevenWorkoutOver") {
            btn.backgroundColor = #colorLiteral(red: 0.4567757249, green: 0.8083776832, blue: 0.8391091228, alpha: 0.85)
        } else {
            btn.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
        }
        btn.layer.cornerRadius = 5
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
    
    @objc func button11Action(sender: UIButton) {
        
        sender.zoomOut()
        
        if !problemAreaComplex_purchased {
            showinfoRestoreAlert()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                sender.zoomIn()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let videoURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/GoodFit%2F11.mp4?alt=media&token=71944a3a-2ca4-44ff-aa01-d195082003de")
                playerEleven = AVPlayer(url: videoURL!)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = playerEleven
                
                playerViewController.modalPresentationStyle = .fullScreen
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                    
                    openWorkoutEleven = true
                    sender.zoomIn()
                }
            }
        }
    }
    //12
    @objc lazy var button12: UIButton = {
        let positX: CGFloat!
        let fontSize: CGFloat!
        let leadTrail: CGFloat!
        let wdthHght: CGFloat!
        if totalSize.height >= 920 {
            fontSize = 24
            positX = 210
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 25
            positX = 210
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 27
            positX = 180
            leadTrail = 50
            wdthHght = 80
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 27
            positX = 160
            leadTrail = 60
            wdthHght = 70
        } else if totalSize.height <= 670 {
            fontSize = 27
            positX = 140
            leadTrail = 50
            wdthHght = 70
        } else {
            fontSize = 27
            positX = 180
            leadTrail = 40
            wdthHght = 80
        }
        let btn = UIButton()
        btn.setTitle("12", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        if !UserDefaults.standard.bool(forKey: "twelveWorkoutOver") {
            btn.backgroundColor = #colorLiteral(red: 0.4567757249, green: 0.8083776832, blue: 0.8391091228, alpha: 0.85)
        } else {
            btn.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
        }
        btn.layer.cornerRadius = 5
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
    
    @objc func button12Action(sender: UIButton) {
        
        sender.zoomOut()
        
        if !problemAreaComplex_purchased {
            showinfoRestoreAlert()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                sender.zoomIn()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let videoURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/GoodFit%2F12.mp4?alt=media&token=d86de98c-3245-47d4-8d6c-8b3f14b4fe33")
                playerTwelve = AVPlayer(url: videoURL!)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = playerTwelve
                
                playerViewController.modalPresentationStyle = .fullScreen
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                    
                    openWorkoutTwelve = true
                    sender.zoomIn()
                }
            }
        }
    }
//MARK: - AlertInfo
    private func showinfoRestoreAlert() {
        let alert = UIAlertController(title: "Доступ закрыт", message: "Вам доступна бесплатно только первая тренировка, для ознакомления с комплексом.", preferredStyle: .alert)
            
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default))
        alert.addAction(UIAlertAction(title: "Купить", style: .cancel, handler: { action in
            
            self.activityIndicator.startAnimating()
            
            SwiftyStoreKit.purchaseProduct("com.transform.fitness.complexesProblemAreas", quantity: 1, atomically: true) { result in
                switch result {
                case .success(let purchase):
                    
                    UserDefaults.standard.set(true, forKey: "problemAreaComplex_purchased")
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "successfulPurchaseProblemArea"), object: nil)
                    
                    self.problemAreaComplex_purchased = true
                    
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

//MARK: - CurrentTimeAVPlayer
extension Notification.Name {
    static let kAVPlayerViewControllerDismissingNotification = Notification.Name.init("dismissing")
    
    }

extension AVPlayerViewController {
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isBeingDismissed == false {
            return
        }
    
        //1
        if openWorkoutOne == true {
        let currentTimeInSecs = CMTimeGetSeconds(playerOne.currentTime())
        if currentTimeInSecs >= 3080 {
            
            UserDefaults.standard.set(true, forKey: "oneWorkoutOver")
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "oneButtonUpload"), object: nil)
            }
            openWorkoutOne = false
        }
        //2
        if openWorkoutTwo == true {
        let currentTimeInSecsTwo = CMTimeGetSeconds(playerTwo.currentTime())
        if currentTimeInSecsTwo >= 3100 {

            UserDefaults.standard.set(true, forKey: "twoWorkoutOver")
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "twoButtonUpload"), object: nil)
            }
            openWorkoutTwo = false
        }
        //3
        if openWorkoutThree == true {
        let currentTimeInSecsThree = CMTimeGetSeconds(playerThree.currentTime())
        if currentTimeInSecsThree >= 3180 {
            
            UserDefaults.standard.set(true, forKey: "threeWorkoutOver")
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "threeButtonUpload"), object: nil)
            }
            openWorkoutThree = false
        }
        //4
        if openWorkoutFour == true {
        let currentTimeInSecsFour = CMTimeGetSeconds(playerFour.currentTime())
        if currentTimeInSecsFour >= 2380 {
            
            UserDefaults.standard.set(true, forKey: "fourWorkoutOver")
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fourButtonUpload"), object: nil)
            }
            openWorkoutFour = false
        }
        //5
        if openWorkoutFive == true {
        let currentTimeInSecsFive = CMTimeGetSeconds(playerFive.currentTime())
        if currentTimeInSecsFive >= 1960 {
            
            UserDefaults.standard.set(true, forKey: "fiveWorkoutOver")
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fiveButtonUpload"), object: nil)
            }
            openWorkoutFive = false
        }
        //6
        if openWorkoutSix == true {
        let currentTimeInSecsSix = CMTimeGetSeconds(playerSix.currentTime())
        if currentTimeInSecsSix >= 1630 {
            
            UserDefaults.standard.set(true, forKey: "sixWorkoutOver")
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sixButtonUpload"), object: nil)
            }
            openWorkoutSix = false
        }
        //7
        if openWorkoutSeven == true {
        let currentTimeInSecsSeven = CMTimeGetSeconds(playerSeven.currentTime())
        if currentTimeInSecsSeven >= 1600 {
            
            UserDefaults.standard.set(true, forKey: "sevenWorkoutOver")
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sevenButtonUpload"), object: nil)
            }
            openWorkoutSeven = false
        }
        //8
        if openWorkoutEight == true {
        let currentTimeInSecsEight = CMTimeGetSeconds(playerEight.currentTime())
        if currentTimeInSecsEight >= 1420 {
            
            UserDefaults.standard.set(true, forKey: "eightWorkoutOver")
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "eightButtonUpload"), object: nil)
            }
            openWorkoutEight = false
        }
        //9
        if openWorkoutNine == true {
        let currentTimeInSecsNine = CMTimeGetSeconds(playerNine.currentTime())
        if currentTimeInSecsNine >= 2120 {
            
            UserDefaults.standard.set(true, forKey: "nineWorkoutOver")
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "nineButtonUpload"), object: nil)
            }
            openWorkoutNine = false
        }
        //10
        if openWorkoutTen == true {
        let currentTimeInSecsTen = CMTimeGetSeconds(playerTen.currentTime())
        if currentTimeInSecsTen >= 1600 {
            
            UserDefaults.standard.set(true, forKey: "tenWorkoutOver")
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tenButtonUpload"), object: nil)
            }
            openWorkoutTen = false
        }
        //11
        if openWorkoutEleven == true {
        let currentTimeInSecsEleven = CMTimeGetSeconds(playerEleven.currentTime())
        if currentTimeInSecsEleven >= 1100 {
            
            UserDefaults.standard.set(true, forKey: "elevenWorkoutOver")
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "elevenButtonUpload"), object: nil)
            }
            openWorkoutEleven = false
        }
        //12
        if openWorkoutTwelve == true {
        let currentTimeInSecsTwelve = CMTimeGetSeconds(playerTwelve.currentTime())
        if currentTimeInSecsTwelve >= 1820 {
            
            UserDefaults.standard.set(true, forKey: "twelveWorkoutOver")
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "twelveButtonUpload"), object: nil)
            }
            openWorkoutTwelve = false
        }
        
        NotificationCenter.default.post(name: .kAVPlayerViewControllerDismissingNotification, object: nil)
    }
}
