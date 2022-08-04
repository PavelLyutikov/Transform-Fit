//
//  PreviewRecoveryViewController.swift
//  Transform
//
//  Created by Pavel Lyutikov on 01.07.2021.
//

import UIKit
import SnapKit

class PreviewRecoveryViewController: UIViewController {

    let totalSize = UIScreen.main.bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(false, forKey: "isFirstPressButtonRecoveryOne")
        UserDefaults.standard.set(false, forKey: "isFirstPressButtonRecoveryTwo")
        UserDefaults.standard.set(false, forKey: "isFirstPressButtonRecoveryThree")
        UserDefaults.standard.set(false, forKey: "isFirstPressButtonRecoveryFour")
        
        self.view.backgroundColor = .white

        viewOne.isHidden = false
        imageOne.isHidden = false
        labelOne.isHidden = false
        viewTwo.isHidden = false
        imageTwo.isHidden = false
        labelTwo.isHidden = false
        viewTwoFake.isHidden = false
        labelTwoFake.isHidden = false
        viewThree.isHidden = false
        viewThreeImage.isHidden = false
        imageThree.isHidden = false
        labelThree.isHidden = false
        viewThreeFake.isHidden = false
        labelThreeFake.isHidden = false
        viewFour.isHidden = false
        viewFourImage.isHidden = false
        imageFour.isHidden = false
        labelFour.isHidden = false
        viewFourFake.isHidden = false
        labelFourFake.isHidden = false
        viewSix.isHidden = false
        labelSix.isHidden = false
        viewSix.isHidden = false
        labelSix.isHidden = false
        imageFourFake.isHidden = false
        
        nextButton.addTarget(self, action: #selector(actionNextButton(sender:)), for: .touchUpInside)
            
    }
//MARK: - Button
    lazy var nextButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Далее".localized(), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        btn.setTitleColor(#colorLiteral(red: 0.6968744022, green: 0.4465548704, blue: 0.4550882987, alpha: 1), for: .normal)
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
        
        return btn
    }()
    
    @objc func actionNextButton(sender: UIButton) {
        
        if !UserDefaults.standard.bool(forKey: "isFirstPressButtonRecoveryOne") {
                    viewTwo.alphaLeft()
                    viewTwoImage.alpha()
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                        self.imageOne.fade()
                    }
           } else {
                if !UserDefaults.standard.bool(forKey: "isFirstPressButtonRecoveryTwo") {
                    viewTwo.alpha = 0
                    viewTwoFake.alpha = 1
                    viewTwoFake.fadeLeft()
                    viewThreeImage.alpha()
                        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                            self.viewThree.alphaLeft()
                            self.viewTwoImage.fade()
                        }
                   } else {
                        if !UserDefaults.standard.bool(forKey: "isFirstPressButtonRecoveryThree") {
                            viewThree.alpha = 0
                            viewThreeFake.alpha = 1
                            viewThreeFake.fadeLeft()
                            viewFourImage.alpha()
                                Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                                    self.viewFour.alphaLeft()
                                    self.viewThreeImage.fade()
                                }
                           } else {
                            if !UserDefaults.standard.bool(forKey: "isFirstPressButtonRecoveryFour") {
                                viewFour.alpha = 0
                                viewFourImage.alpha = 0
                                
                                viewFourFake.alpha = 1
                                viewFourFake.fadeLeft()
                                viewOne.fadeLeft()
                                
                                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                                        self.viewSix.alphaLeft()
                                    }
                               } else {
                                        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                                        
                                            let vc = MenuPostPregnancyRecoveryViewController()
                                            vc.modalPresentationStyle = .fullScreen
                                            
                                            let transition = CATransition()
                                            transition.duration = 0.4
                                            transition.type = CATransitionType.push
                                            transition.subtype = CATransitionSubtype.fromRight
                                            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                                            self.view.window!.layer.add(transition, forKey: kCATransition)

                                            self.present(vc, animated: false, completion: nil)
                                        }
                                }
                                UserDefaults.standard.set(true, forKey: "isFirstPressButtonRecoveryFour")
                           }
                           UserDefaults.standard.set(true, forKey: "isFirstPressButtonRecoveryThree")
                   }
                   UserDefaults.standard.set(true, forKey: "isFirstPressButtonRecoveryTwo")
           }
           UserDefaults.standard.set(true, forKey: "isFirstPressButtonRecoveryOne")
        
    }
//MARK: - OneScreen
    lazy var viewOne: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        return vi
    }()
    
    lazy var labelOne: UILabel = {
        var positX: CGFloat!
        var fontSize: CGFloat!
        if totalSize.height >= 890 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -350
            case "en":
                positX = -335
            default:
                positX = -335
            }
            fontSize = 24
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -360
            case "en":
                positX = -340
            default:
                positX = -340
            }
            fontSize = 24
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -330
            case "en":
                positX = -310
            default:
                positX = -310
            }
            fontSize = 22
        } else if totalSize.height <= 670 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -300
            case "en":
                positX = -280
            default:
                positX = -280
            }
            fontSize = 22
        } else {
            positX = -350
            fontSize = 24
        }
        
        let lbl = UILabel()
        lbl.text = "В данном разделе собраны упражнения для восстановления после родов, которые разбиты на группы - по уровню нагрузки".localized()
        lbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: fontSize)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 5
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        self.view.addSubview(lbl)
        viewOne.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(positX)
            make.width.equalTo(300)
        }
        
        return lbl
    }()
    
    lazy var imageOne: UIImageView = {
        var positX: CGFloat!
        var height: CGFloat!
        if totalSize.height >= 890 {
            positX = -100
            height = 500
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -130
            height = 500
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -140
            height = 450
        } else if totalSize.height <= 670 {
            positX = -120
            height = 400
        } else {
            positX = -140
            height = 480
        }
        
        let img = UIImageView(image: #imageLiteral(resourceName: "recoveryPreviewOne"))
        
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        viewOne.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(positX)
            make.height.equalTo(height)
        }
        
        return img
    }()
 
//MARK: - TwoScreen
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
        if totalSize.height >= 890 {
            positX = -160
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -180
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -185
        } else if totalSize.height <= 671 {
            positX = -160
        } else {
            positX = -190
        }
        
        let lbl = UILabel()
        lbl.text = "Слабая нагрузка".localized()
        lbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 5
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        self.view.addSubview(lbl)
        viewTwo.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(positX)
            make.width.equalTo(300)
        }
        
        return lbl
    }()
    lazy var viewTwoImage: UIView = {
        let vi = UIView()
        vi.alpha = 0
        self.view.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        return vi
    }()
    lazy var imageTwo: UIImageView = {
        var positX: CGFloat!
        var height: CGFloat!
        if totalSize.height >= 890 {
            positX = -100
            height = 500
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -130
            height = 500
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -140
            height = 450
        } else if totalSize.height <= 670 {
            positX = -120
            height = 400
        } else {
            positX = -140
            height = 480
        }
        let img = UIImageView(image: #imageLiteral(resourceName: "recoveryPreviewTwo"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        viewTwoImage.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(positX)
            make.height.equalTo(height)
        }
        
        return img
    }()
    
//FAKE
    lazy var viewTwoFake: UIView = {
        let vi = UIView()
        vi.alpha = 0
        self.view.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerXWithinMargins.equalTo(0)
        }
        
        return vi
    }()
    
    lazy var labelTwoFake: UILabel = {
        var positX: CGFloat!
        if totalSize.height >= 890 {
            positX = -160
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -180
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -185
        } else if totalSize.height <= 671 {
            positX = -160
        } else {
            positX = -190
        }
        
        let lbl = UILabel()
        lbl.text = "Слабая нагрузка".localized()
        lbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 5
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        self.view.addSubview(lbl)
        viewTwoFake.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(positX)
            make.width.equalTo(300)
        }
        
        return lbl
    }()
    
//MARK: - ThreeScreen
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
        if totalSize.height >= 890 {
            positX = -160
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -180
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -185
        } else if totalSize.height <= 671 {
            positX = -160
        } else {
            positX = -190
        }
        
        let lbl = UILabel()
        lbl.text = "Средняя".localized()
        lbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 5
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        self.view.addSubview(lbl)
        viewThree.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(positX)
            make.width.equalTo(300)
        }
        
        return lbl
    }()
    lazy var viewThreeImage: UIView = {
        let vi = UIView()
        vi.alpha = 0
        self.view.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        return vi
    }()
    lazy var imageThree: UIImageView = {
        var positX: CGFloat!
        var height: CGFloat!
        if totalSize.height >= 890 {
            positX = -100
            height = 500
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -130
            height = 500
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -140
            height = 450
        } else if totalSize.height <= 670 {
            positX = -120
            height = 400
        } else {
            positX = -140
            height = 480
        }
        let img = UIImageView(image: #imageLiteral(resourceName: "recoveryPreviewThree"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        viewThreeImage.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(positX)
            make.height.equalTo(height)
        }
        
        return img
    }()
//FAKE
    lazy var viewThreeFake: UIView = {
        let vi = UIView()
        vi.alpha = 0
        self.view.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerXWithinMargins.equalTo(0)
        }
        
        return vi
    }()
    
    lazy var labelThreeFake: UILabel = {
        var positX: CGFloat!
        if totalSize.height >= 890 {
            positX = -160
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -180
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -185
        } else if totalSize.height <= 671 {
            positX = -160
        } else {
            positX = -190
        }
        
        let lbl = UILabel()
        lbl.text = "Средняя".localized()
        lbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 5
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        self.view.addSubview(lbl)
        viewThreeFake.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(positX)
            make.width.equalTo(300)
        }
        
        return lbl
    }()
//MARK: - FourScreen
    lazy var viewFour: UIView = {
        let vi = UIView()
        vi.alpha = 0
        self.view.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerXWithinMargins.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var labelFour: UILabel = {
        var positX: CGFloat!
        if totalSize.height >= 890 {
            positX = -160
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -180
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -185
        } else if totalSize.height <= 671 {
            positX = -160
        } else {
            positX = -190
        }
        
        let lbl = UILabel()
        lbl.text = "Тяжелая".localized()
        lbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 5
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        self.view.addSubview(lbl)
        viewFour.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(positX)
            make.width.equalTo(300)
        }
        
        return lbl
    }()
    lazy var viewFourImage: UIView = {
        let vi = UIView()
        vi.alpha = 0
        self.view.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        return vi
    }()
    lazy var imageFour: UIImageView = {
        var positX: CGFloat!
        var height: CGFloat!
        if totalSize.height >= 890 {
            positX = -100
            height = 500
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -130
            height = 500
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -140
            height = 450
        } else if totalSize.height <= 670 {
            positX = -120
            height = 400
        } else {
            positX = -140
            height = 480
        }
        let img = UIImageView(image: #imageLiteral(resourceName: "recoveryPreviewFour"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        viewFourImage.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(positX)
            make.height.equalTo(height)
        }
        
        return img
    }()
//FAKE
    lazy var viewFourFake: UIView = {
        let vi = UIView()
        vi.alpha = 0
        self.view.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerXWithinMargins.equalTo(0)
        }
        
        return vi
    }()
    
    lazy var labelFourFake: UILabel = {
        var positX: CGFloat!
        if totalSize.height >= 890 {
            positX = -160
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -180
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -185
        } else if totalSize.height <= 670 {
            positX = -160
        } else {
            positX = -190
        }
        
        let lbl = UILabel()
        lbl.text = "Тяжелая".localized()
        lbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 5
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        self.view.addSubview(lbl)
        viewFourFake.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(positX)
            make.width.equalTo(300)
        }
        
        return lbl
    }()
    lazy var imageFourFake: UIImageView = {
        var positX: CGFloat!
        var height: CGFloat!
        if totalSize.height >= 890 {
            positX = -100
            height = 500
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -130
            height = 500
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -140
            height = 450
        } else if totalSize.height <= 670 {
            positX = -120
            height = 400
        } else {
            positX = -140
            height = 480
        }
        let img = UIImageView(image: #imageLiteral(resourceName: "recoveryPreviewFour"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        viewFourFake.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(positX)
            make.height.equalTo(height)
        }
        
        return img
    }()
    

//MARK: - SixScreen
    lazy var viewSix: UIView = {
        let vi = UIView()
        vi.alpha = 0
        self.view.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerXWithinMargins.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var labelSix: UILabel = {
        var positX: CGFloat!
        if totalSize.height >= 890 {
            positX = -260
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -300
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -260
        } else if totalSize.height <= 670 {
            positX = -250
        } else {
            positX = -270
        }
        
        let lbl = UILabel()
        lbl.text = "Данные упражнения не являются готовым комплексом, а лишь собраны по уровням сложности, формируйте упражнения в любом удобном для Вас порядке".localized()
        lbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 5
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        self.view.addSubview(lbl)
        viewSix.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
        }
        
        return lbl
    }()
//FAKE
    lazy var viewSixFake: UIView = {
        let vi = UIView()
        vi.alpha = 0
        self.view.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerXWithinMargins.equalTo(0)
        }
        
        return vi
    }()
    
    lazy var labelSixFake: UILabel = {
        var positX: CGFloat!
        if totalSize.height >= 890 {
            positX = -260
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -300
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -260
        } else if totalSize.height <= 670 {
            positX = -250
        } else {
            positX = -270
        }
        
        let lbl = UILabel()
        lbl.text = "Данные упражнения не являются готовым комплексом, а лишь собраны по уровням сложности, формируйте упражнения в любом удобном для Вас порядке".localized()
        lbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 5
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        self.view.addSubview(lbl)
        viewSixFake.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
        }
        
        return lbl
    }()
}

