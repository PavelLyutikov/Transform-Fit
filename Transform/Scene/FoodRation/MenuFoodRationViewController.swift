//
//  MenuFoodRationViewController.swift
//  Transform
//
//  Created by Pavel Lyutikov on 20.07.2021.
//

import UIKit
import SnapKit
import EGOCircleMenu

class MenuFoodRationViewController: UIViewController, CircleMenuDelegate {
    
    let totalSize = UIScreen.main.bounds.size
    
    var icons = [String]()
    let submenuIds = [2]
    let showItemSegueId = "showItem"
    var selectedItemId: Int?
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
//MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        backgroundImage.isHidden = false
        mainLabel.isHidden = false
        subLabel.isHidden = false
        
        
        calorieCalculatorButton.addTarget(self, action: #selector(calorieCalculatorButtonAction(sender:)), for: .touchUpInside)
        
        //Notification
        NotificationCenter.default.addObserver(self, selector: #selector(MenuFoodRationViewController.rotateCircleMenuLeft), name: NSNotification.Name(rawValue: "rotateCircleMenuLeft"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MenuFoodRationViewController.rotateCircleMenuRight), name: NSNotification.Name(rawValue: "rotateCircleMenuRight"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MenuFoodRationViewController.openCircleMenu), name: NSNotification.Name(rawValue: "openCircleMenu"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MenuFoodRationViewController.closeCircleMenu), name: NSNotification.Name(rawValue: "closeCircleMenu"), object: nil)
        
        //FirstLaunch
        if !UserDefaults.standard.bool(forKey: "isFirstLaunchMenuFoodRation") {
            firstLaunchImage.isHidden = false
        } else {
            
        }
        UserDefaults.standard.set(true, forKey: "isFirstLaunchMenuFoodRation")
        
        setupScrollGeneralList()
        setupViews()
        
        
        if !UserDefaults.standard.bool(forKey: "calculationBmr") {
        } else {
            
            showIndividualFoodRation()
            
            recommendedCalorage.isHidden = false
            
            switchButtonGeneralList.addTarget(self, action: #selector(actionSwitchButtonGeneralList(sender:)), for: .touchUpInside)
            switchButtonIndividualList.addTarget(self, action: #selector(actionSwitchButtonIndividualList(sender:)), for: .touchUpInside)
        }
            
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
            self.showAlertKcal()
        }
        
        setupCircleMenu()
        
        
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
//MARK: - ShowUI
    func showAlertKcal() {
        if UserDefaults.standard.double(forKey: "bmrResultDouble") >= 2051 {
            if !UserDefaults.standard.bool(forKey: "isFirstLaunchMaxFoodRation") {
                alertMaxFoodRation()
            }
            UserDefaults.standard.set(true, forKey: "isFirstLaunchMaxFoodRation")
        }
        
        if UserDefaults.standard.double(forKey: "bmrResultDouble") >= 50 && UserDefaults.standard.double(forKey: "bmrResultDouble") <= 1449 {
            if !UserDefaults.standard.bool(forKey: "isFirstLaunchMinFoodRation") {
                alertMinFoodRation()
            }
            UserDefaults.standard.set(true, forKey: "isFirstLaunchMinFoodRation")
        }
    }
    //IndividualFoodRation
    func showIndividualFoodRation() {
        if UserDefaults.standard.double(forKey: "bmrResultDouble") <= 1550 {
            individualFoodRation1500Button.isHidden = false
            individualFoodRation1500Button.addTarget(self, action: #selector(individualFoodRation1500ButtonAction(sender:)), for: .touchUpInside)
        } else if UserDefaults.standard.double(forKey: "bmrResultDouble") >= 1551 && UserDefaults.standard.double(forKey: "bmrResultDouble") <= 1650 {
            individualFoodRation1600Button.isHidden = false
            individualFoodRation1600Button.addTarget(self, action: #selector(individualFoodRation1600ButtonAction(sender:)), for: .touchUpInside)
        } else if UserDefaults.standard.double(forKey: "bmrResultDouble") >= 1651 && UserDefaults.standard.double(forKey: "bmrResultDouble") <= 1750 {
            individualFoodRation1700Button.isHidden = false
            individualFoodRation1700Button.addTarget(self, action: #selector(individualFoodRation1700ButtonAction(sender:)), for: .touchUpInside)
        } else if UserDefaults.standard.double(forKey: "bmrResultDouble") >= 1751 && UserDefaults.standard.double(forKey: "bmrResultDouble") <= 1850 {
            individualFoodRation1800Button.isHidden = false
            individualFoodRation1800Button.addTarget(self, action: #selector(individualFoodRation1800ButtonAction(sender:)), for: .touchUpInside)
        } else if UserDefaults.standard.double(forKey: "bmrResultDouble") >= 1851 && UserDefaults.standard.double(forKey: "bmrResultDouble") <= 1950 {
            individualFoodRation1900Button.isHidden = false
            individualFoodRation1900Button.addTarget(self, action: #selector(individualFoodRation1900ButtonAction(sender:)), for: .touchUpInside)
        } else if UserDefaults.standard.double(forKey: "bmrResultDouble") >= 1951 {
            individualFoodRation2000Button.isHidden = false
            individualFoodRation2000Button.addTarget(self, action: #selector(individualFoodRation2000ButtonAction(sender:)), for: .touchUpInside)
        }
    }
//MARK: - FirstLaunchImage
    lazy var firstLaunchImage: UIImageView = {
        let topBottom: CGFloat!
        if totalSize.height >= 830 {
            topBottom = 0
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            topBottom = -30
        } else if totalSize.height <= 670 {
            topBottom = 0
        } else {
            topBottom = 0
        }
        
        var image = UIImageView(image: #imageLiteral(resourceName: "isFirstLaunchMenuRation"))
        image.clipsToBounds = true
//        image.contentMode = .scaleAspectFit
        image.layer.zPosition = 50
        image.alpha = 1
        self.view.addSubview(image)


        image.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(0)
            make.leading.trailing.equalToSuperview().inset(0)
    }
        return image
    }()
//MARK: - MainLabel
    lazy var mainLabel: UILabel = {
        let font: CGFloat!
        let top: CGFloat!
        let lead: CGFloat!
        if totalSize.height >= 920 {
            top = 80
            font = 29
            lead = -40
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            top = 80
            font = 28
            lead = -40
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            top = 80
            font = 26
            lead = -45
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            top = 55
            font = 24
            lead = -40
        } else if totalSize.height <= 670 {
            top = 40
            font = 24
            lead = -40
        } else {
            top = 70
            font = 24
            lead = -40
        }
        let lbl = UILabel()
        lbl.text = "Рационы Питания"
        lbl.font = UIFont.systemFont(ofSize: font)
        lbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 8
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.7
        self.view.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(lead)
            make.top.equalToSuperview().inset(top)
        }
        
        return lbl
    }()

//MARK: - SubLabel
    lazy var subLabel: UILabel = {
        let font: CGFloat!
        let top: CGFloat!
        let lead: CGFloat!
        if totalSize.height >= 920 {
            top = 108
            font = 39
            lead = -40
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            top = 108
            font = 39
            lead = -40
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            top = 110
            font = 36
            lead = -45
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            top = 85
            font = 33
            lead = -40
        } else if totalSize.height <= 670 {
            top = 70
            font = 33
            lead = -40
        } else {
            top = 100
            font = 33
            lead = -40
        }
        let lbl = UILabel()
        lbl.text = "НА НЕДЕЛЮ"
        lbl.font = UIFont.systemFont(ofSize: font)
        lbl.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 5
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.5
        self.view.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(lead)
            make.top.equalToSuperview().inset(top)
        }
        
        return lbl
    }()
    
//MARK: - RecommendedCalorage
    lazy var recommendedCalorage: UILabel = {
        let topPosit: CGFloat!
        let fontSz: CGFloat!
        if totalSize.height >= 920 {
            topPosit = 170
            fontSz = 24
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            topPosit = 170
            fontSz = 24
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            topPosit = 170
            fontSz = 24
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            topPosit = 140
            fontSz = 20
        } else if totalSize.height <= 670 {
            topPosit = 120
            fontSz = 20
        } else {
            topPosit = 150
            fontSz = 20
        }
        let lbl = UILabel()
        lbl.text = "Дневная норма калорий - \(String(UserDefaults.standard.string(forKey: "bmrResult")!))"
        lbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: fontSz)
        lbl.backgroundColor = #colorLiteral(red: 1, green: 0.6713232895, blue: 0.351200978, alpha: 0.9453315994)
        lbl.layer.zPosition = 5
        self.view.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(topPosit)
            make.width.equalTo(500)
            make.height.equalTo(45)
            make.leading.trailing.equalToSuperview().inset(0)
        }
        return lbl
    }()
//MARK: - GeneralListFoodRation
    
    
    
//MARK: - SwitchButton
        lazy var switchButtonGeneralList: UIButton = {
            let topPosit: CGFloat!
            if totalSize.height >= 920 {
                topPosit = 250
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                topPosit = 250
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                topPosit = 250
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                topPosit = 210
            } else if totalSize.height <= 670 {
                topPosit = 190
            } else {
                topPosit = 230
            }
            let btn = UIButton()
            btn.setImage(UIImage(named: "generalListButton"), for: .normal)
            btn.layer.shadowColor = #colorLiteral(red: 0.1263487511, green: 0.1263487511, blue: 0.1263487511, alpha: 1)
            btn.layer.shadowRadius = 6
            btn.layer.shadowOffset = CGSize(width: 0, height: 0)
            btn.layer.shadowOpacity = 0.5
            btn.alpha = 0.7
            btn.layer.zPosition = 5
            self.view.addSubview(btn)
            
            btn.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(100)
                make.top.equalToSuperview().inset(topPosit)
                make.width.equalTo(50)
                make.height.equalTo(50)
            }
            return btn
        }()
        @objc func actionSwitchButtonGeneralList (sender: UIButton) {

            switchButtonGeneralList.setImage(UIImage(named: "generalListButtonPress"), for: .normal)
            switchButtonGeneralList.alpha = 1
            
            switchButtonIndividualList.setImage(UIImage(named: "individualButton"), for: .normal)
            switchButtonIndividualList.alpha = 0.7


            recommendedCalorage.textColor = #colorLiteral(red: 1, green: 0.6713232895, blue: 0.351200978, alpha: 0.9453315994)
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                self.recommendedCalorage.text = "Общий список рационов"
                self.recommendedCalorage.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

                Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
                    self.recommendedCalorage.textColor = #colorLiteral(red: 1, green: 0.6713232895, blue: 0.351200978, alpha: 0.9453315994)
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                        self.recommendedCalorage.text = "Дневная норма калорий - \(String(UserDefaults.standard.string(forKey: "bmrResult")!))"
                        self.recommendedCalorage.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    }
                }
            }
            

            scrollView.isHidden = false
            foodRation1500Button.isHidden = false
            foodRation1500Button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            UIView.animate(withDuration: 0.4) {
                self.foodRation1500Button.transform = CGAffineTransform.identity
                self.foodRation1500Button.alpha = 1
            }
            foodRation1600Button.isHidden = false
            foodRation1600Button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            UIView.animate(withDuration: 0.4) {
                self.foodRation1600Button.transform = CGAffineTransform.identity
                self.foodRation1600Button.alpha = 1
            }
            foodRation1700Button.isHidden = false
            foodRation1700Button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            UIView.animate(withDuration: 0.4) {
                self.foodRation1700Button.transform = CGAffineTransform.identity
                self.foodRation1700Button.alpha = 1
            }
            foodRation1800Button.isHidden = false
            foodRation1800Button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            UIView.animate(withDuration: 0.4) {
                self.foodRation1800Button.transform = CGAffineTransform.identity
                self.foodRation1800Button.alpha = 1
            }
            foodRation1900Button.isHidden = false
            foodRation1900Button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            UIView.animate(withDuration: 0.4) {
                self.foodRation1900Button.transform = CGAffineTransform.identity
                self.foodRation1900Button.alpha = 1
            }
            foodRation2000Button.isHidden = false
            foodRation2000Button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            UIView.animate(withDuration: 0.4) {
                self.foodRation2000Button.transform = CGAffineTransform.identity
                self.foodRation2000Button.alpha = 1
            }
            
            foodRation1500Button.addTarget(self, action: #selector(foodRation1500ButtonAction(sender:)), for: .touchUpInside)
            foodRation1600Button.addTarget(self, action: #selector(foodRation1600ButtonAction(sender:)), for: .touchUpInside)
            foodRation1700Button.addTarget(self, action: #selector(foodRation1700ButtonAction(sender:)), for: .touchUpInside)
            foodRation1800Button.addTarget(self, action: #selector(foodRation1800ButtonAction(sender:)), for: .touchUpInside)
            foodRation1900Button.addTarget(self, action: #selector(foodRation1900ButtonAction(sender:)), for: .touchUpInside)
            foodRation2000Button.addTarget(self, action: #selector(foodRation2000ButtonAction(sender:)), for: .touchUpInside)
            
            
            if UserDefaults.standard.double(forKey: "bmrResultDouble") <= 1550 {
                
                Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                    self.individualFoodRation1500Button.isHidden = true
                }
                individualFoodRation1500Button.zoomOutInfo()
            } else if UserDefaults.standard.double(forKey: "bmrResultDouble") >= 1551 && UserDefaults.standard.double(forKey: "bmrResultDouble") <= 1650 {
                
                Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                    self.individualFoodRation1600Button.isHidden = true
                }
                individualFoodRation1600Button.zoomOutInfo()
            } else if UserDefaults.standard.double(forKey: "bmrResultDouble") >= 1651 && UserDefaults.standard.double(forKey: "bmrResultDouble") <= 1750 {
                
                Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                    self.individualFoodRation1700Button.isHidden = true
                }
                individualFoodRation1700Button.zoomOutInfo()
            } else if UserDefaults.standard.double(forKey: "bmrResultDouble") >= 1751 && UserDefaults.standard.double(forKey: "bmrResultDouble") <= 1850 {
                
                Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                    self.individualFoodRation1800Button.isHidden = true
                }
                individualFoodRation1800Button.zoomOutInfo()
            } else if UserDefaults.standard.double(forKey: "bmrResultDouble") >= 1851 && UserDefaults.standard.double(forKey: "bmrResultDouble") <= 1950 {
                
                Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                    self.individualFoodRation1900Button.isHidden = true
                }
                individualFoodRation1900Button.zoomOutInfo()
            } else if UserDefaults.standard.double(forKey: "bmrResultDouble") >= 1951 {
                
                Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                    self.individualFoodRation2000Button.isHidden = true
                }
                individualFoodRation2000Button.zoomOutInfo()
            }
        }
//MARK: - IndividualList
        lazy var switchButtonIndividualList: UIButton = {
            let topPosit: CGFloat!
            if totalSize.height >= 920 {
                topPosit = 250
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                topPosit = 250
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                topPosit = 250
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                topPosit = 210
            } else if totalSize.height <= 670 {
                topPosit = 190
            } else {
                topPosit = 230
            }
            let btn = UIButton()
            btn.setImage(UIImage(named: "individualButtonPress"), for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            btn.layer.shadowColor = #colorLiteral(red: 0.1263487511, green: 0.1263487511, blue: 0.1263487511, alpha: 1)
            btn.layer.shadowRadius = 6
            btn.layer.shadowOffset = CGSize(width: 0, height: 0)
            btn.layer.shadowOpacity = 0.5
            btn.layer.zPosition = 5
            self.view.addSubview(btn)
            
            btn.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(100)
                make.top.equalToSuperview().inset(topPosit)
                make.width.equalTo(50)
                make.height.equalTo(50)
            }
            return btn
        }()
        @objc func actionSwitchButtonIndividualList (sender: UIButton) {

            switchButtonIndividualList.setImage(UIImage(named: "individualButtonPress"), for: .normal)
            switchButtonIndividualList.alpha = 1

            switchButtonGeneralList.setImage(UIImage(named: "generalListButton"), for: .normal)
            switchButtonGeneralList.alpha = 0.7
            
            recommendedCalorage.textColor = #colorLiteral(red: 1, green: 0.6713232895, blue: 0.351200978, alpha: 0.9453315994)
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                self.recommendedCalorage.text = "Рассчитанный рацион"
                self.recommendedCalorage.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

                Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
                    self.recommendedCalorage.textColor = #colorLiteral(red: 1, green: 0.6713232895, blue: 0.351200978, alpha: 0.9453315994)
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                        self.recommendedCalorage.text = "Дневная норма калорий - \(String(UserDefaults.standard.string(forKey: "bmrResult")!))"
                        self.recommendedCalorage.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    }
                }
            }
            
            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                self.foodRation1500Button.isHidden = true
                self.foodRation1600Button.isHidden = true
                self.foodRation1700Button.isHidden = true
                self.foodRation1800Button.isHidden = true
                self.foodRation1900Button.isHidden = true
                self.foodRation2000Button.isHidden = true
                self.scrollView.isHidden = true
            }
            
            foodRation1500Button.zoomOutInfo()
            foodRation1600Button.zoomOutInfo()
            foodRation1700Button.zoomOutInfo()
            foodRation1800Button.zoomOutInfo()
            foodRation1900Button.zoomOutInfo()
            foodRation2000Button.zoomOutInfo()
            
            
            if UserDefaults.standard.double(forKey: "bmrResultDouble") <= 1550 {
                
                individualFoodRation1500Button.isHidden = false
                individualFoodRation1500Button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    self.individualFoodRation1500Button.transform = CGAffineTransform.identity
                    self.individualFoodRation1500Button.alpha = 1
                }
                individualFoodRation1500Button.addTarget(self, action: #selector(individualFoodRation1500ButtonAction(sender:)), for: .touchUpInside)
            } else if UserDefaults.standard.double(forKey: "bmrResultDouble") >= 1551 && UserDefaults.standard.double(forKey: "bmrResultDouble") <= 1650 {
                
                individualFoodRation1600Button.isHidden = false
                individualFoodRation1600Button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    self.individualFoodRation1600Button.transform = CGAffineTransform.identity
                    self.individualFoodRation1600Button.alpha = 1
                }
                individualFoodRation1600Button.addTarget(self, action: #selector(individualFoodRation1600ButtonAction(sender:)), for: .touchUpInside)
            } else if UserDefaults.standard.double(forKey: "bmrResultDouble") >= 1651 && UserDefaults.standard.double(forKey: "bmrResultDouble") <= 1750 {
                
                individualFoodRation1700Button.isHidden = false
                individualFoodRation1700Button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    self.individualFoodRation1700Button.transform = CGAffineTransform.identity
                    self.individualFoodRation1700Button.alpha = 1
                }
                individualFoodRation1700Button.addTarget(self, action: #selector(individualFoodRation1700ButtonAction(sender:)), for: .touchUpInside)
            } else if UserDefaults.standard.double(forKey: "bmrResultDouble") >= 1751 && UserDefaults.standard.double(forKey: "bmrResultDouble") <= 1850 {
                
                individualFoodRation1800Button.isHidden = false
                individualFoodRation1800Button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    self.individualFoodRation1800Button.transform = CGAffineTransform.identity
                    self.individualFoodRation1800Button.alpha = 1
                }
                individualFoodRation1800Button.addTarget(self, action: #selector(individualFoodRation1800ButtonAction(sender:)), for: .touchUpInside)
            } else if UserDefaults.standard.double(forKey: "bmrResultDouble") >= 1851 && UserDefaults.standard.double(forKey: "bmrResultDouble") <= 1950 {
                
                individualFoodRation1900Button.isHidden = false
                individualFoodRation1900Button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    self.individualFoodRation1900Button.transform = CGAffineTransform.identity
                    self.individualFoodRation1900Button.alpha = 1
                }
                individualFoodRation1900Button.addTarget(self, action: #selector(individualFoodRation1900ButtonAction(sender:)), for: .touchUpInside)
            } else if UserDefaults.standard.double(forKey: "bmrResultDouble") >= 1951 {
                
                individualFoodRation2000Button.isHidden = false
                individualFoodRation2000Button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    self.individualFoodRation2000Button.transform = CGAffineTransform.identity
                    self.individualFoodRation2000Button.alpha = 1
                }
                individualFoodRation2000Button.addTarget(self, action: #selector(individualFoodRation2000ButtonAction(sender:)), for: .touchUpInside)
            }
            
        }
//MARK: ScrollGeneralList
    func setupScrollGeneralList(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let positTop: CGFloat!
        let positBttm: CGFloat!
        if totalSize.height >= 920 {
            positTop = 190
            positBttm = 0
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positTop = 190
            positBttm = 0
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positTop = 186
            positBttm = 0
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positTop = 150
            positBttm = 0
        } else if totalSize.height <= 670 {
            positTop = 150
            positBttm = 0
        } else {
            positTop = 167
            positBttm = 0
        }
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: positTop).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: positBttm).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: positTop).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: positBttm).isActive = true
        
        scrollView.layer.zPosition = 2
        scrollView.isHidden = true
        
        }
    func setupViews(){
        contentView.addSubview(foodRation1500Button)
        contentView.addSubview(foodRation1600Button)
        contentView.addSubview(foodRation1700Button)
        contentView.addSubview(foodRation1800Button)
        contentView.addSubview(foodRation1900Button)
        contentView.addSubview(foodRation2000Button)
        
        let wdth: CGFloat!
        let positTop: CGFloat!
        let positBttm: CGFloat!
        if totalSize.height >= 890 {
            wdth = 3.5/4
            positTop = 10
            positBttm = -160
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 3.5/4
            positTop = 10
            positBttm = -160
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 3.2/4
            positTop = 10
            positBttm = -160
        } else if totalSize.height <= 670 {
            wdth = 3.2/4
            positTop = -10
            positBttm = -160
        } else {
            wdth = 3.7/4
            positTop = 10
            positBttm = -160
        }
//button1500
        foodRation1500Button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        foodRation1500Button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: positTop).isActive = true
        foodRation1500Button.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: wdth).isActive = true
//button1600
        contentView.addSubview(foodRation1600Button)
        foodRation1600Button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        foodRation1600Button.topAnchor.constraint(equalTo: foodRation1500Button.bottomAnchor, constant: 50).isActive = true
        foodRation1600Button.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
//button1700
        contentView.addSubview(foodRation1700Button)
        foodRation1700Button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        foodRation1700Button.topAnchor.constraint(equalTo: foodRation1600Button.bottomAnchor, constant: 50).isActive = true
        foodRation1700Button.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
//button1800
        contentView.addSubview(foodRation1800Button)
        foodRation1800Button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        foodRation1800Button.topAnchor.constraint(equalTo: foodRation1700Button.bottomAnchor, constant: 50).isActive = true
        foodRation1800Button.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
//button1900
        contentView.addSubview(foodRation1900Button)
        foodRation1900Button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        foodRation1900Button.topAnchor.constraint(equalTo: foodRation1800Button.bottomAnchor, constant: 50).isActive = true
        foodRation1900Button.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
//button2000
        contentView.addSubview(foodRation2000Button)
        foodRation2000Button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        foodRation2000Button.topAnchor.constraint(equalTo: foodRation1900Button.bottomAnchor, constant: 50).isActive = true
        foodRation2000Button.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        foodRation2000Button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: positBttm).isActive = true
        
        
        foodRation1500Button.isHidden = true
        foodRation1600Button.isHidden = true
        foodRation1700Button.isHidden = true
        foodRation1800Button.isHidden = true
        foodRation1900Button.isHidden = true
        foodRation2000Button.isHidden = true
    }
    
//MARK: - FoodRation1500Button
    lazy var foodRation1500Button: UIButton = {
        let hght: CGFloat!
        let top: CGFloat!
        if totalSize.height >= 920 {
            hght = 150
            top = 300
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            hght = 150
            top = 300
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            hght = 140
            top = 300
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            hght = 140
            top = 260
        } else if totalSize.height <= 670 {
            hght = 130
            top = 240
        } else {
            hght = 130
            top = 340
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "foodRation1500Button"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 9
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 1
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.height.equalTo(hght)
        }
        
        return btn
    }()
    @objc func foodRation1500ButtonAction(sender: UIButton) {
        sender.zoomOut()
        
        let vc = FoodRation1500ViewController()
        vc.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: false, completion: nil)
    }
//MARK: - FoodRation1600Button
    lazy var foodRation1600Button: UIButton = {
        let hght: CGFloat!
        let top: CGFloat!
        if totalSize.height >= 920 {
            hght = 150
            top = 500
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            hght = 150
            top = 500
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            hght = 140
            top = 500
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            hght = 140
            top = 440
        } else if totalSize.height <= 670 {
            hght = 130
            top = 390
        } else {
            hght = 130
            top = 340
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "foodRation1600Button"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 9
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 1
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.height.equalTo(hght)
        }
        
        return btn
    }()
    @objc func foodRation1600ButtonAction(sender: UIButton) {
        sender.zoomOut()
        
        let vc = FoodRation1600ViewController()
        vc.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: false, completion: nil)
    }
    
//MARK: - FoodRation1700Button
    lazy var foodRation1700Button: UIButton = {
        let hgth: CGFloat!
        let top: CGFloat!
        if totalSize.height >= 920 {
            hgth = 150
            top = 500
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            hgth = 150
            top = 500
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            hgth = 140
            top = 500
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            hgth = 140
            top = 440
        } else if totalSize.height <= 670 {
            hgth = 130
            top = 390
        } else {
            hgth = 130
            top = 340
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "foodRation1700Button"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 9
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 1
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.height.equalTo(hgth)
        }
        
        return btn
    }()
    @objc func foodRation1700ButtonAction(sender: UIButton) {
        sender.zoomOut()
        
        let vc = FoodRation1700ViewController()
        vc.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: false, completion: nil)
    }
//MARK: - FoodRation1800Button
    lazy var foodRation1800Button: UIButton = {
        let hgth: CGFloat!
        let top: CGFloat!
        if totalSize.height >= 920 {
            hgth = 150
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            hgth = 150
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            hgth = 140
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            hgth = 140
        } else if totalSize.height <= 670 {
            hgth = 130
        } else {
            hgth = 130
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "foodRation1800Button"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 9
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 1
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.height.equalTo(160)
        }
        
        return btn
    }()
    @objc func foodRation1800ButtonAction(sender: UIButton) {
        sender.zoomOut()
        
        let vc = FoodRation1800ViewController()
        vc.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: false, completion: nil)
    }
//MARK: - FoodRation1900Button
    lazy var foodRation1900Button: UIButton = {
        let hgth: CGFloat!
        let top: CGFloat!
        if totalSize.height >= 920 {
            hgth = 150
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            hgth = 150
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            hgth = 140
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            hgth = 140
        } else if totalSize.height <= 670 {
            hgth = 130
        } else {
            hgth = 130
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "foodRation1900Button"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 9
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 1
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.height.equalTo(160)
        }
        
        return btn
    }()
    @objc func foodRation1900ButtonAction(sender: UIButton) {
        sender.zoomOut()
        
        let vc = FoodRation1900ViewController()
        vc.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: false, completion: nil)
    }
//MARK: - FoodRation2000Button
    lazy var foodRation2000Button: UIButton = {
        let hgth: CGFloat!
        let top: CGFloat!
        if totalSize.height >= 920 {
            hgth = 150
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            hgth = 150
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            hgth = 140
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            hgth = 140
        } else if totalSize.height <= 670 {
            hgth = 130
        } else {
            hgth = 130
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "foodRation2000Button"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 9
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 1
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.height.equalTo(160)
        }
        
        return btn
    }()
    @objc func foodRation2000ButtonAction(sender: UIButton) {
        sender.zoomOut()
        
        let vc = FoodRation2000ViewController()
        vc.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: false, completion: nil)
    }
//MARK: - IndividualFoodRation1500Button
    lazy var individualFoodRation1500Button: UIButton = {
        let hght: CGFloat!
        let top: CGFloat!
        if totalSize.height >= 920 {
            hght = 150
            top = 390
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            hght = 150
            top = 380
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            hght = 140
            top = 380
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            hght = 140
            top = 310
        } else if totalSize.height <= 670 {
            hght = 130
            top = 290
        } else {
            hght = 130
            top = 340
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "foodRation1500Button"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 9
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 1
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(top)
            make.height.equalTo(hght)
        }
        
        return btn
    }()
    @objc func individualFoodRation1500ButtonAction(sender: UIButton) {
        
        sender.zoomOut()
        let vc = FoodRation1500ViewController()
        vc.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: false, completion: nil)
    }
//MARK: - IndividualFoodRation1600Button
    lazy var individualFoodRation1600Button: UIButton = {
        let hght: CGFloat!
        let top: CGFloat!
        if totalSize.height >= 920 {
            hght = 150
            top = 390
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            hght = 150
            top = 380
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            hght = 140
            top = 380
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            hght = 140
            top = 310
        } else if totalSize.height <= 670 {
            hght = 130
            top = 290
        } else {
            hght = 130
            top = 340
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "foodRation1600Button"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 9
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 1
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(top)
            make.height.equalTo(160)
        }
        
        return btn
    }()
    @objc func individualFoodRation1600ButtonAction(sender: UIButton) {
        
        sender.zoomOut()
        
        let vc = FoodRation1600ViewController()
        vc.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: false, completion: nil)
    }
    
//MARK: - IndividualFoodRation1700Button
    lazy var individualFoodRation1700Button: UIButton = {
        let hght: CGFloat!
        let top: CGFloat!
        if totalSize.height >= 920 {
            hght = 150
            top = 390
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            hght = 150
            top = 380
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            hght = 140
            top = 380
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            hght = 140
            top = 310
        } else if totalSize.height <= 670 {
            hght = 130
            top = 290
        } else {
            hght = 130
            top = 340
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "foodRation1700Button"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 9
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 1
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(top)
            make.height.equalTo(160)
        }
        
        return btn
    }()
    @objc func individualFoodRation1700ButtonAction(sender: UIButton) {
        sender.zoomOut()
        
        let vc = FoodRation1700ViewController()
        vc.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: false, completion: nil)
    }
//MARK: - IndividualFoodRation1800Button
    lazy var individualFoodRation1800Button: UIButton = {
        let hght: CGFloat!
        let top: CGFloat!
        if totalSize.height >= 920 {
            hght = 150
            top = 390
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            hght = 150
            top = 380
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            hght = 140
            top = 380
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            hght = 140
            top = 310
        } else if totalSize.height <= 670 {
            hght = 130
            top = 290
        } else {
            hght = 130
            top = 340
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "foodRation1800Button"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 9
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 1
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(top)
            make.height.equalTo(160)
        }
        
        return btn
    }()
    @objc func individualFoodRation1800ButtonAction(sender: UIButton) {
        sender.zoomOut()
        
        let vc = FoodRation1800ViewController()
        vc.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: false, completion: nil)
    }
//MARK: - IndividualFoodRation1900Button
    lazy var individualFoodRation1900Button: UIButton = {
        let hght: CGFloat!
        let top: CGFloat!
        if totalSize.height >= 920 {
            hght = 150
            top = 390
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            hght = 150
            top = 380
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            hght = 140
            top = 380
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            hght = 140
            top = 310
        } else if totalSize.height <= 670 {
            hght = 130
            top = 290
        } else {
            hght = 130
            top = 340
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "foodRation1900Button"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 9
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 1
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(top)
            make.height.equalTo(hght)
        }
        
        return btn
    }()
    @objc func individualFoodRation1900ButtonAction(sender: UIButton) {
        
        sender.zoomOut()
        let vc = FoodRation1900ViewController()
        vc.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: false, completion: nil)
    }
//MARK: - IndividualFoodRation2000Button
    lazy var individualFoodRation2000Button: UIButton = {
        let hght: CGFloat!
        let top: CGFloat!
        if totalSize.height >= 920 {
            hght = 150
            top = 390
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            hght = 150
            top = 380
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            hght = 140
            top = 380
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            hght = 140
            top = 310
        } else if totalSize.height <= 670 {
            hght = 130
            top = 290
        } else {
            hght = 130
            top = 340
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "foodRation2000Button"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 9
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 1
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(top)
            make.height.equalTo(hght)
        }
        
        return btn
    }()
    @objc func individualFoodRation2000ButtonAction(sender: UIButton) {
        
        sender.zoomOut()
        let vc = FoodRation2000ViewController()
        vc.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: false, completion: nil)
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
//MARK: - СalorieCalculatorButton
    @objc lazy var calorieCalculatorButton: UIButton = {

        let top: CGFloat!
        let trail: CGFloat!
        if totalSize.height >= 830 {
            top = 65
            trail = 20
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            top = 45
            trail = 25
        } else if totalSize.height <= 670 {
            top = 40
            trail = 15
        } else {
            top = 55
            trail = 15
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "calculatorButton"), for: .normal)
        btn.layer.zPosition = 4
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.3
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(top)
            make.trailing.equalToSuperview().inset(trail)
            make.height.equalTo(65)
            make.width.equalTo(65)
        }
        
        return btn
    }()
    @objc func calorieCalculatorButtonAction(sender: UIButton) {
 
        sender.zoomOut()

        let vc = CalorieCalculatorViewController()
        vc.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: false, completion: nil)
    }
//MARK: - DismissButton
    @objc lazy var dismissButton: UIButton = {

        let top: CGFloat!
        let trail: CGFloat!
        if totalSize.height >= 830 {
            top = 55
            trail = 20
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            top = 30
            trail = 25
        } else if totalSize.height <= 670 {
            top = 30
            trail = 15
        } else {
            top = 45
            trail = 15
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "closeBlack"), for: .normal)
        btn.layer.zPosition = 4
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(top)
            make.trailing.equalToSuperview().inset(trail)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        return btn
    }()
    @objc func buttonDismiss(sender: UIButton) {
 
        sender.zoomOut()

        let vc = MenuTrainingComplexesViewController()
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
                self.labelCircleMenuMoveRight.text = "Стретчинг".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 1 {
                self.labelCircleMenuMoveRight.text = "Хатха Йога".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 2 {
                self.labelCircleMenuMoveRight.text = "Фитнес дома".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 3 {
                self.labelCircleMenuMoveRight.text = "Восстановление после родов".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 4 {
                self.labelCircleMenuMoveRight.text = "Body Guide"
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 5 {
                self.labelCircleMenuMoveRight.text = "Комплексы тренировок".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 6 {
                self.labelCircleMenuMoveRight.text = "Таймер".localized()
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
                self.labelCircleMenuMoveRight.text = "Body Guide"
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 5 {
                self.labelCircleMenuMoveRight.text = "Комплексы тренировок".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 6 {
                self.labelCircleMenuMoveRight.text = "Таймер".localized()
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
        icons.append(contentsOf: ["home", "stretching", "yoga", "dumbbell", "baby", "bodyGuideIcon", "complexIcon", "stopwatch", "icVideo", "home", "icHDR"])
        
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
                    transition.subtype = CATransitionSubtype.fromLeft
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
                transition.subtype = CATransitionSubtype.fromLeft
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
                transition.subtype = CATransitionSubtype.fromLeft
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
                transition.subtype = CATransitionSubtype.fromLeft
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(vc, animated: false, completion: nil)
               }
               UserDefaults.standard.set(true, forKey: "isFirstLaunchPostPregnancyRecovery")
            
        } else if id == 5 {
            
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
                transition.subtype = CATransitionSubtype.fromLeft
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(vc, animated: false, completion: nil)
               }
               UserDefaults.standard.set(true, forKey: "isFirstLaunchBodyGuide")
            
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
                transition.subtype = CATransitionSubtype.fromLeft
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(vc, animated: false, completion: nil)
            }
            UserDefaults.standard.set(true, forKey: "isFirstLaunchTrainingComplex")
            
        } else if id == 7 {
            
            if !UserDefaults.standard.bool(forKey: "isFirstLaunchTimerController") {
                    
                    let vc = PreviewTimerViewController()
                    vc.modalPresentationStyle = .fullScreen
                    
                    let transition = CATransition()
                    transition.duration = 0.4
                    transition.type = CATransitionType.push
                    transition.subtype = CATransitionSubtype.fromLeft
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
    
//MARK: - Alert
    private func alertMaxFoodRation() {
        let alert = UIAlertController(title: "Внимание", message: "На данный момент рацион на 2000 Ккал является максимальным, извините за неудобство.", preferredStyle: .alert)
            
        alert.addAction(UIAlertAction(title: "Досадно", style: .default))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func alertMinFoodRation() {
        let alert = UIAlertController(title: "Внимание", message: "На данный момент рацион на 1500 Ккал является минимальным, извините за неудобство.", preferredStyle: .alert)
            
        alert.addAction(UIAlertAction(title: "Досадно", style: .default))
        
        present(alert, animated: true, completion: nil)
    }
}
