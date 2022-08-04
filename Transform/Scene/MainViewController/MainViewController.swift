//
//  MainViewController.swift
//  Transform
//
//  Created by Pavel Lyutikov on 26.02.2021.
//

import UIKit
import SnapKit
import EGOCircleMenu
import StoreKit
import SwiftyStoreKit
import AppTrackingTransparency
import AdSupport

class MainViewController: UIViewController, CircleMenuDelegate {
    
    let totalSize = UIScreen.main.bounds.size
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    var icons = [String]()
    let submenuIds = [2]
    let showItemSegueId = "showItem"
    var selectedItemId: Int?
    
    var isFirstOpenMainViewBool: Bool = true
    var activityIndicator = UIActivityIndicatorView()
    
    
    //ironSource
    var bannerView: ISBannerView! = nil
    let kAPPKEY = "11dfcc91d"
    
//MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        backgroundImage.isHidden = false
        mainTitle.isHidden = false
        subTitle.isHidden = false
        mainImage.isHidden = false
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
            self.mainImageRotate.rotate()
        }
        
        feedBackButton.addTarget(self, action: #selector(feedBackButtonAction(sender:)), for: .touchUpInside)
        premiumButton.addTarget(self, action: #selector(premiumButtonAction(sender:)), for: .touchUpInside)
        contactButton.addTarget(self, action: #selector(contactButtonAction(sender:)), for: .touchUpInside)
        
        setupScrollView()
        setupViews()
        
        setupCircleMenu()
        
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
                        UserDefaults.standard.set(true, forKey: "removeAdsPurchased")
                        print("\(productId) is purchased: \(receiptItem)")
                    case .notPurchased:
                        UserDefaults.standard.set(false, forKey: "removeAdsPurchased")
                        print("The user has never purchased \(productId)")
                    }
                case .error(let error):
                    UserDefaults.standard.set(false, forKey: "removeAdsPurchased")
                    print("Receipt verification failed: \(error)")
                }
            }
        
        } else {
            UserDefaults.standard.set(true, forKey: "removeAdsPurchased")
        }
    
        
        if #available(iOS 14.6, *) {
        isFirstLaunchApp()
        }
        isFirstLaunchAppUpdate()
        isFirstOpenMainView()
        
        //Notification
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.rotateCircleMenuLeft), name: NSNotification.Name(rawValue: "rotateCircleMenuLeft"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.rotateCircleMenuRight), name: NSNotification.Name(rawValue: "rotateCircleMenuRight"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.openCircleMenu), name: NSNotification.Name(rawValue: "openCircleMenu"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.closeCircleMenu), name: NSNotification.Name(rawValue: "closeCircleMenu"), object: nil)
        
//        //ads
        if !UserDefaults.standard.bool(forKey: "removeAdsPurchased") {
            setupIronSourceSdk()
            loadBanner()
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
//MARK: - IronSource
    func loadBanner() {
        let BNSize: ISBannerSize = ISBannerSize(description: "BANNER", width: Int(self.view.frame.size.width), height: 50)
           IronSource.loadBanner(with: self, size: BNSize)
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
//MARK: - FirstLaunch
    func isFirstLaunchApp() {
        if !UserDefaults.standard.bool(forKey: "isFirstLaunchAppTransform") {
        backgroundInfo.isHidden = false
        backgroundInfo.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.4) {
            self.backgroundInfo.transform = CGAffineTransform.identity
            self.backgroundInfo.alpha = 1
        }

        scrollView.isHidden = false
        labelYogaInfo.isHidden = false
        labelYogaInfo.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.4) {
            self.labelYogaInfo.transform = CGAffineTransform.identity
            self.labelYogaInfo.alpha = 1
        }


        closeInfoButton.isHidden = false

        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            self.closeInfoButton.zoomInInfo()
        }

        closeInfoButton.addTarget(self, action: #selector(buttonCloseInfoAction(sender:)), for: .touchUpInside)
        } else {
        }
        UserDefaults.standard.set(true, forKey: "isFirstLaunchAppTransform")
    }
//Update
    func isFirstLaunchAppUpdate() {
        if !UserDefaults.standard.bool(forKey: "isFirstLaunchAppTransformUpdate3") {
        backgroundInfoUpdate.isHidden = false
        backgroundInfoUpdate.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.4) {
            self.backgroundInfoUpdate.transform = CGAffineTransform.identity
            self.backgroundInfoUpdate.alpha = 1
        }

        imageUpdate.isHidden = false
        imageUpdate.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.4) {
            self.imageUpdate.transform = CGAffineTransform.identity
            self.imageUpdate.alpha = 1
        }
        
        labelYogaInfoUpdate.isHidden = false
        labelYogaInfoUpdate.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.4) {
            self.labelYogaInfoUpdate.transform = CGAffineTransform.identity
            self.labelYogaInfoUpdate.alpha = 1
        }

            
        labelYogaInfoUpdateTwo.isHidden = false
        labelYogaInfoUpdateTwo.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.4) {
            self.labelYogaInfoUpdateTwo.transform = CGAffineTransform.identity
            self.labelYogaInfoUpdateTwo.alpha = 1
        }

        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            self.closeInfoButtonUpdate.isHidden = false
            self.closeInfoButtonUpdate.zoomInInfo()
            self.closeInfoButtonUpdate.addTarget(self, action: #selector(self.buttonCloseInfoActionUpdate(sender:)), for: .touchUpInside)
        }
            } else {
        }
        UserDefaults.standard.set(true, forKey: "isFirstLaunchAppTransformUpdate3")
    }
    func isFirstOpenMainView() {
        if !UserDefaults.standard.bool(forKey: "isFirstOpenMainView") {
            isFirstOpenMainViewBool = true
            print("1\(isFirstOpenMainViewBool)")
        } else {
            isFirstOpenMainViewBool = false
            print("2\(isFirstOpenMainViewBool)")
        }
        UserDefaults.standard.set(true, forKey: "isFirstOpenMainView")
    }
//MARK: BackgroundImage
    lazy var backgroundImage: UIImageView = {
        var image = UIImageView(image: #imageLiteral(resourceName: "mainBackground"))
        
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
//MARK: - ScrollInfo
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let positTop: CGFloat!
        let positBttm: CGFloat!
        if totalSize.height >= 920 {
            positTop = 227
            positBttm = -280
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positTop = 221
            positBttm = -280
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positTop = 212
            positBttm = -260
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positTop = 155
            positBttm = -190
        } else if totalSize.height <= 670 {
            positTop = 148
            positBttm = -190
        } else {
            positTop = 207
            positBttm = -260
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
        
        let wdth: CGFloat!
        let wdth2: CGFloat!
        let positTop: CGFloat!
        let positBttm: CGFloat!
        if totalSize.height >= 920 {
            wdth = 3.5/4
            wdth2 = 3/4
            positTop = -190
            positBttm = 260
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            wdth = 3.5/4
            wdth2 = 3/4
            positTop = -190
            positBttm = 240
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 3.5/4
            wdth2 = 3/4
            positTop = -190
            positBttm = 260
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 3.2/4
            wdth2 = 2.8/4
            positTop = -120
            positBttm = 140
        } else if totalSize.height <= 670 {
            wdth = 3.2/4
            wdth2 = 2.6/4
            positTop = -120
            positBttm = 160
        } else {
            wdth = 3.5/4
            wdth2 = 3/4
            positTop = -190
            positBttm = 240
        }
        
        contentView.addSubview(labelYogaInfo)
        
        labelYogaInfo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        labelYogaInfo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: positTop).isActive = true
        labelYogaInfo.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: wdth).isActive = true
            
        
        contentView.addSubview(labelEnd)
        
        labelEnd.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        labelEnd.topAnchor.constraint(equalTo: labelYogaInfo.bottomAnchor, constant: 25).isActive = true
        labelEnd.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: wdth2).isActive = true
        labelEnd.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: positBttm).isActive = true
    }

    lazy var labelYogaInfo: UILabel = {
        let fnt: CGFloat!
        if totalSize.height >= 890 {
            fnt = 28
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fnt = 24
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fnt = 24
        } else if totalSize.height <= 670 {
            fnt = 22
        } else {
            fnt = 24
        }
        
       let label = UILabel()
        label.text = "Вы используете iOS 14.6".localized()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: fnt)
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelEnd: UILabel = {
        let label = UILabel()
        label.text = """
                        В этой версии iOS мы обязаны запросить у Вас разрешение на отслеживание на этом устройстве некоторых данных, позволяющих улучшить показ рекламы.

                        Мы используем информацию о ваших действиях, полученную от других приложений и сайтов, чтобы:
                            
                        - Показывать Вам более персонализированную рекламу

                        - Этим Вы помогаете сохранить бесплатную версию приложения

                        - Поддерживаете компании, которым реклама помогает найти клиентов
                        """.localized()
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        @objc lazy var closeInfoButton: UIButton = {
            let positBttm: CGFloat!
            let width: CGFloat!
            if totalSize.height >= 920 {
                positBttm = 240
                width = 310
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                positBttm = 230
                width = 310
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                positBttm = 220
                width = 290
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                positBttm = 165
                width = 290
            } else if totalSize.height <= 670 {
                positBttm = 155
                width = 255
            } else {
                positBttm = 215
                width = 278
            }
            let btn = UIButton()
            btn.setTitle("продолжить".localized(), for: .normal)
            btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            btn.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
            btn.layer.cornerRadius = 15
            btn.titleLabel?.font = .systemFont(ofSize: 24)
            btn.adjustsImageWhenHighlighted = false
            btn.layer.zPosition = 10
            self.view.addSubview(btn)

            btn.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().inset(positBttm)
                make.height.equalTo(50)
                make.width.equalTo(width)
            }
            
            return btn
        }()
        @objc func buttonCloseInfoAction(sender: UIButton) {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
                self.backgroundInfo.isHidden = true
            }
            backgroundInfo.zoomOutInfo()
            
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
                self.labelYogaInfo.isHidden = true
                self.labelEnd.isHidden = true
                self.scrollView.isHidden = true
            }
            labelYogaInfo.zoomOutInfo()
            labelEnd.zoomOutInfo()
            
            closeInfoButton.zoomOutInfo()
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
            self.closeInfoButton.isHidden = true
            }
            
            
            if #available(iOS 14.6, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .notDetermined:
                        break
                    case .restricted:
                        break
                    case .denied:
                        break
                    case .authorized:
                        print("authorized")
                        break
                    @unknown default:
                        break
                    }
                }
            } else {
                // Fallback on earlier versions
            }
            
        }
//MARK: - BackgroundInfo
    lazy var backgroundInfo: UIImageView = {
        let leadtTrail: CGFloat!
        if totalSize.height >= 830 {
            leadtTrail = 40
        } else if totalSize.height <= 800 {
            leadtTrail = 50
        } else {
            leadtTrail = 40
        }
        var image = UIImageView(image: #imageLiteral(resourceName: "darkGrayPanel"))
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
//MARK: - Update
    lazy var backgroundInfoUpdate: UIImageView = {
        let leadtTrail: CGFloat!
        if totalSize.height >= 830 {
            leadtTrail = 20
        } else if totalSize.height <= 800 {
            leadtTrail = 30
        } else {
            leadtTrail = 20
        }
        var image = UIImageView(image: #imageLiteral(resourceName: "darkGrayPanel"))
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
    lazy var labelYogaInfoUpdate: UILabel = {
        let fnt: CGFloat!
        let topPosit: CGFloat!
        if totalSize.height >= 890 {
            fnt = 28
            topPosit = 215
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fnt = 24
            topPosit = 200
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fnt = 24
            topPosit = 140
        } else if totalSize.height <= 670 {
            fnt = 22
            topPosit = 130
        } else {
            fnt = 24
            topPosit = 190
        }
        
       let label = UILabel()
        label.text = "Что нового?".localized()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: fnt)
        label.numberOfLines = 0
        label.layer.zPosition = 9
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(topPosit)
            make.centerX.equalToSuperview()
        }
        return label
    }()
    lazy var labelYogaInfoUpdateTwo: UILabel = {
        let fnt: CGFloat!
        let topPosit: CGFloat!
        if totalSize.height >= 890 {
            fnt = 20
            topPosit = 270
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fnt = 20
            topPosit = 245
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fnt = 18
            topPosit = 195
        } else if totalSize.height <= 670 {
            fnt = 18
            topPosit = 175
        } else {
            fnt = 18
            topPosit = 240
        }
        
       let label = UILabel()
        label.text = "Добавлен раздел: Расчёт суточной нормы калорий / Рационы питания".localized()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: fnt)
        label.numberOfLines = 0
        label.layer.zPosition = 9
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(topPosit)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }
        return label
    }()
    lazy var imageUpdate: UIImageView = {
        let width: CGFloat!
        let positBttn: CGFloat!
        if totalSize.height >= 920 {
            width = 220
            positBttn = -570
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            width = 200
            positBttn = -580
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            width = 190
            positBttn = -600
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            width = 190
            positBttn = -650
        } else if totalSize.height <= 670 {
            width = 170
            positBttn = -670
        } else {
            width = 180
            positBttn = -610
        }
        var image = UIImageView(image: #imageLiteral(resourceName: "previewFoodRationTwo"))
        image.contentMode = .scaleAspectFit
        image.layer.zPosition = 8
        image.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        image.layer.shadowRadius = 50
        image.layer.shadowOffset = CGSize(width: 0, height: 0)
        image.layer.shadowOpacity = 0.4
        self.view.addSubview(image)
        
        image.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(positBttn)
            make.centerX.equalToSuperview()
            make.width.equalTo(width)
        }
        return image
    }()
    @objc lazy var closeInfoButtonUpdate: UIButton = {
        let positBttm: CGFloat!
        let width: CGFloat!
        if totalSize.height >= 920 {
            positBttm = 205
            width = 365
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positBttm = 200
            width = 360
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positBttm = 195
            width = 330
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positBttm = 140
            width = 330
        } else if totalSize.height <= 670 {
            positBttm = 130
            width = 300
        } else {
            positBttm = 190
            width = 320
        }
        let btn = UIButton()
        btn.setTitle("продолжить".localized(), for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.8322479129, green: 0.5383385684, blue: 0.4425687341, alpha: 1)
        btn.layer.cornerRadius = 20
        btn.titleLabel?.font = .systemFont(ofSize: 24)
        btn.adjustsImageWhenHighlighted = false
        btn.layer.zPosition = 10
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(positBttm)
            make.height.equalTo(50)
            make.width.equalTo(width)
        }
        
        return btn
    }()
    @objc func buttonCloseInfoActionUpdate(sender: UIButton) {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            self.backgroundInfoUpdate.isHidden = true
        }
        backgroundInfoUpdate.zoomOutInfo()
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            self.labelYogaInfoUpdate.isHidden = true
            self.labelYogaInfoUpdateTwo.isHidden = true
        }
        labelYogaInfoUpdate.zoomOutInfo()
        labelYogaInfoUpdateTwo.zoomOutInfo()
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            self.imageUpdate.isHidden = true
        }
        imageUpdate.zoomOutInfo()
        
        closeInfoButtonUpdate.zoomOutInfo()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
        self.closeInfoButtonUpdate.isHidden = true
        }

    }
//MARK: - ActivityIndicator
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        activityIndicator.center = self.view.center
        activityIndicator.style = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = #colorLiteral(red: 0.3058452904, green: 0.3059036732, blue: 0.3058416247, alpha: 1)
        activityIndicator.layer.cornerRadius = 15
        activityIndicator.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        activityIndicator.layer.shadowRadius = 3
        activityIndicator.layer.shadowOffset = CGSize(width: 0, height: 0)
        activityIndicator.layer.shadowOpacity = 0.4
    }
//MARK: - Title
    lazy var mainTitle: UILabel = {
        let positX: CGFloat!
        let fontSize: CGFloat!
        if totalSize.height >= 830 {
            positX = 150
            fontSize = 47
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = 150
            fontSize = 47
        } else if totalSize.height <= 670 {
            positX = 150
            fontSize = 47
        } else {
            positX = 150
            fontSize = 43
        }
       let label = UILabel()
        label.text = "Transform-Fit"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.layer.shadowRadius = 5
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowOpacity = 0.5
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
            positX = 210
            fontSize = 28
        } else if totalSize.height <= 800 {
            positX = 200
            fontSize = 28
        } else {
            positX = 200
            fontSize = 26
        }
        
       let label = UILabel()
        label.text = "FITNESS PLATFORM"
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
//MARK: - MainImage
    lazy var mainImage: UIImageView = {
        let positX: CGFloat!
        let size: CGFloat!
        if totalSize.height >= 830 {
            positX = 200
            size = 130
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = 150
            size = 110
        } else if totalSize.height <= 670 {
            positX = 150
            size = 110
        } else {
            positX = 180
            size = 120
        }
        let img = UIImageView(image: #imageLiteral(resourceName: "logoTransformBackground"))
        img.layer.cornerRadius = 20
//        img.clipsToBounds = true
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 6
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.5
        self.view.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(positX)
            make.width.equalTo(size)
            make.height.equalTo(size)
        }
        
       return img
    }()
    lazy var mainImageRotate: UIImageView = {
        let positX: CGFloat!
        let size: CGFloat!
        if totalSize.height >= 830 {
            positX = 200
            size = 130
        } else if totalSize.height <= 800 {
            positX = 150
            size = 110
        } else {
            positX = 180
            size = 120
        }
        let img = UIImageView(image: #imageLiteral(resourceName: "logoTransformCentr"))
        img.layer.cornerRadius = 30
//        img.clipsToBounds = true
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 8
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.5
        self.view.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(positX)
            make.width.equalTo(size)
            make.height.equalTo(size)
        }
        
       return img
    }()
//MARK: - FeedBack
    @objc lazy var feedBackButton: UIButton = {
        let positX: CGFloat!
        let leidTrail: CGFloat!
        if totalSize.height >= 830 {
            positX = 60
            leidTrail = 30
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = 35
            leidTrail = 25
        } else if totalSize.height <= 670 {
            positX = 35
            leidTrail = 25
        } else {
            positX = 50
            leidTrail = 30
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        btn.layer.zPosition = 6
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.3
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positX)
            make.trailing.equalToSuperview().inset(leidTrail)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        return btn
    }()
    @objc func feedBackButtonAction(sender: UIButton) {
        setupActivityIndicator()
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        DispatchQueue.main.async { [weak self] in
            SKStoreReviewController.requestReview()
            self!.activityIndicator.isHidden = true
            }
    }
//MARK: - ContactButton
    @objc lazy var contactButton: UIButton = {
        let positX: CGFloat!
        let leidTrail: CGFloat!
        if totalSize.height >= 830 {
            positX = 62
            leidTrail = 100
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = 35
            leidTrail = 85
        } else if totalSize.height <= 670 {
            positX = 35
            leidTrail = 85
        } else {
            positX = 50
            leidTrail = 90
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "settings"), for: .normal)
        btn.layer.zPosition = 6
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.3
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positX)
            make.trailing.equalToSuperview().inset(leidTrail)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        return btn
    }()
    @objc func contactButtonAction(sender: UIButton) {
        
        destroyBanner()
        
        let vc = SettingsViewController()
        vc.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: false, completion: nil)
    }
//MARK: - Premium
    @objc lazy var premiumButton: UIButton = {
        let positX: CGFloat!
        let leidTrail: CGFloat!
        if totalSize.height >= 830 {
            positX = 60
            leidTrail = 30
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = 35
            leidTrail = 25
        } else if totalSize.height <= 670 {
            positX = 35
            leidTrail = 25
        } else {
            positX = 50
            leidTrail = 30
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "crown"), for: .normal)
        btn.layer.zPosition = 6
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.3
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positX)
            make.leading.equalToSuperview().inset(leidTrail)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        return btn
    }()
    @objc func premiumButtonAction(sender: UIButton) {
        
        destroyBanner()
        
        let vc = PreviewPremiumViewController()
        vc.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: false, completion: nil)
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
                self.labelCircleMenuMoveRight.text = "Body Guide".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 4 {
                self.labelCircleMenuMoveRight.text = "Таймер".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 5 {
                self.labelCircleMenuMoveRight.text = "Комплексы тренировок".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 6 {
                self.labelCircleMenuMoveRight.text = "Рационы питания и Калькулятор".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 7 {
                self.labelCircleMenuMoveRight.text = "Стретчинг".localized()
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
                self.labelCircleMenuMoveRight.text = "Body Guide".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 4 {
                self.labelCircleMenuMoveRight.text = "Таймер".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 5 {
                self.labelCircleMenuMoveRight.text = "Комплексы тренировок".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 6 {
                self.labelCircleMenuMoveRight.text = "Рационы питания и Калькулятор".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 7 {
                self.labelCircleMenuMoveRight.text = "Стретчинг".localized()
            }
            self.labelCircleMenuMoveRight.zoomInCircleMenu()
        }
        
    }
    
    @objc func openCircleMenu() {
        isFirstOpenMainViewBool = false
        print("3\(isFirstOpenMainViewBool)")
        
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
        icons.append(contentsOf: ["stretching", "yoga", "dumbbell", "baby", "bodyGuideIcon", "stopwatch", "complexIcon", "foodRationIcon", "icVideo", "home", "icHDR"])
        
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
        
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { (timer) in
            if self.isFirstOpenMainViewBool == true {
                    circleMenu.zoomCircleMenuIn()
                    
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                        circleMenu.zoomCircleMenuIn()
                    }
            }
        }
    }
    func menuItemSelected(id: Int) {
//      idLabel.text = "id: \(id)"
        selectedItemId = id
        guard id != 100 else {
            return
        }
        print(id)
        
        destroyBanner()
        
        if id == 0 {
            
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
//            if submenuIds.contains(i){
//                for j in  9..<12 {
//                    let submenuModel = CircleMenuItemModel(id: j, imageSource: UIImage.init(named: icons[j]))
//                    menuModel.children!.append(submenuModel)
//                }
//            }
            menuModels.append(menuModel)
        }
        return menuModels
    }
    
    func printIDFA() {
        print("ТУТ\(ASIdentifierManager.shared().advertisingIdentifier.uuidString)")
        }
}
private extension ASIdentifierManager {

    /// IDFA or nil if ad tracking is disabled via iOS system settings
    var advertisingIdentifierIfPresent: String? {
        if isAdvertisingTrackingEnabled {
            return advertisingIdentifier.uuidString
        }

        return nil
    }
}

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
//MARK: - ExtensionIronSource
extension MainViewController: ISBannerDelegate, ISImpressionDataDelegate {
    
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

