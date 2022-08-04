//
//  PreviewStretchingViewController.swift
//  Transform
//
//  Created by Pavel Lyutikov on 25.05.2021.
//

import UIKit
import SnapKit

class PreviewStretchingViewController: UIViewController {

    let totalSize = UIScreen.main.bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(false, forKey: "isFirstPressButtonStretchingFive")
        UserDefaults.standard.set(false, forKey: "isFirstPressButtonStretchingFour")
        UserDefaults.standard.set(false, forKey: "isFirstPressButtonStretchingThree")
        UserDefaults.standard.set(false, forKey: "isFirstPressButtonStretchingTwo")
        UserDefaults.standard.set(false, forKey: "isFirstPressButtonStretchingOne")

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
        viewFiveImage.isHidden = false
        labelFourFake.isHidden = false
        viewFive.isHidden = false
        imageFive.isHidden = false
        labelFive.isHidden = false
        viewFiveFake.isHidden = false
        imageFiveFake.isHidden = false
        labelFiveFake.isHidden = false
        viewSix.isHidden = false
        labelSix.isHidden = false
        viewSix.isHidden = false
        labelSix.isHidden = false
        
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
        
        if !UserDefaults.standard.bool(forKey: "isFirstPressButtonStretchingOne") {
                    viewTwo.alphaLeft()
                    viewTwoImage.alpha()
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                        self.imageOne.fade()
                    }
           } else {
                if !UserDefaults.standard.bool(forKey: "isFirstPressButtonStretchingTwo") {
                    viewTwo.alpha = 0
                    viewTwoFake.alpha = 1
                    viewTwoFake.fadeLeft()
                    viewThreeImage.alpha()
                        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                            self.viewThree.alphaLeft()
                            self.viewTwoImage.fade()
                        }
                   } else {
                        if !UserDefaults.standard.bool(forKey: "isFirstPressButtonStretchingThree") {
                            viewThree.alpha = 0
                            viewThreeFake.alpha = 1
                            viewThreeFake.fadeLeft()
                            viewFourImage.alpha()
                                Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                                    self.viewFour.alphaLeft()
                                    self.viewThreeImage.fade()
                                }
                           } else {
                            if !UserDefaults.standard.bool(forKey: "isFirstPressButtonStretchingFour") {
                                viewFour.alpha = 0
                                viewFourFake.alpha = 1
                                viewFourFake.fadeLeft()
                                viewFiveImage.alpha()
                                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                                        self.viewFive.alphaLeft()
                                        self.viewFourImage.fade()
                                    }
                               } else {
                            
                                if !UserDefaults.standard.bool(forKey: "isFirstPressButtonStretchingFive") {
                                    
                                    viewFive.alpha = 0
                                    viewFiveImage.alpha = 0
                                    viewFiveFake.alpha = 1
                                    viewFiveFake.fadeLeft()
                                    viewOne.fadeLeft()
                                    
                                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                                            self.viewSix.alphaLeft()
                                        }
                                   } else {
                                        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                                        
                                            let vc = StretchingMenuViewController()
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
                                    UserDefaults.standard.set(true, forKey: "isFirstPressButtonStretchingFive")
                                }
                                UserDefaults.standard.set(true, forKey: "isFirstPressButtonStretchingFour")
                           }
                           UserDefaults.standard.set(true, forKey: "isFirstPressButtonStretchingThree")
                   }
                   UserDefaults.standard.set(true, forKey: "isFirstPressButtonStretchingTwo")
           }
           UserDefaults.standard.set(true, forKey: "isFirstPressButtonStretchingOne")
        
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
        if totalSize.height >= 890 {
            positX = -330
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -330
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -320
        } else if totalSize.height <= 670 {
            positX = -300
        } else {
            positX = -320
        }
        
        let lbl = UILabel()
        lbl.text = "В данном разделе собраны упражнения на растяжку, которые разбиты на группы - по направлениям".localized()
        lbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
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
        
        var nameImage: String!
        switch Locale.current.languageCode {
        case "ru":
            nameImage = "stretchingPreview"
        case "en":
            nameImage = "stretchingPreviewEn"
        default:
            nameImage = "stretchingPreviewEn"
        }
        
        let img = UIImageView(image: UIImage(named: nameImage))
        
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
            positX = -180
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -190
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -190
        } else if totalSize.height <= 671 {
            positX = -170
        } else {
            positX = -190
        }
        
        let lbl = UILabel()
        lbl.text = "Разминка".localized()
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
        var nameImage: String!
        switch Locale.current.languageCode {
        case "ru":
            nameImage = "stretchingPreviewOne"
        case "en":
            nameImage = "stretchingPreviewOneEn"
        default:
            nameImage = "stretchingPreviewOneEn"
        }
        
        let img = UIImageView(image: UIImage(named: nameImage))
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
            positX = -180
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -190
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -190
        } else if totalSize.height <= 671 {
            positX = -170
        } else {
            positX = -190
        }
        
        let lbl = UILabel()
        lbl.text = "Разминка".localized()
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
            positX = -180
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -190
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -190
        } else if totalSize.height <= 671 {
            positX = -170
        } else {
            positX = -190
        }
        
        let lbl = UILabel()
        lbl.text = "Для гибкости спины".localized()
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
        var nameImage: String!
        switch Locale.current.languageCode {
        case "ru":
            nameImage = "stretchingPreviewTwo"
        case "en":
            nameImage = "stretchingPreviewTwoEn"
        default:
            nameImage = "stretchingPreviewTwoEn"
        }
        
        let img = UIImageView(image: UIImage(named: nameImage))
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
            positX = -180
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -190
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -190
        } else if totalSize.height <= 671 {
            positX = -170
        } else {
            positX = -190
        }
        
        let lbl = UILabel()
        lbl.text = "Для гибкости спины".localized()
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
            positX = -180
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -190
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -190
        } else if totalSize.height <= 671 {
            positX = -170
        } else {
            positX = -190
        }
        
        let lbl = UILabel()
        lbl.text = "Для продольного шпагата".localized()
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
        var nameImage: String!
        switch Locale.current.languageCode {
        case "ru":
            nameImage = "stretchingPreviewThree"
        case "en":
            nameImage = "stretchingPreviewThreeEn"
        default:
            nameImage = "stretchingPreviewThreeEn"
        }
        
        let img = UIImageView(image: UIImage(named: nameImage))
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
            positX = -180
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -190
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -190
        } else if totalSize.height <= 670 {
            positX = -170
        } else {
            positX = -190
        }
        
        let lbl = UILabel()
        lbl.text = "Для продольного шпагата".localized()
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
    
//MARK: - FiveScreen
    lazy var viewFive: UIView = {
        let vi = UIView()
        vi.alpha = 0
        self.view.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerXWithinMargins.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var labelFive: UILabel = {
        var positX: CGFloat!
        if totalSize.height >= 890 {
            positX = -180
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -190
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -190
        } else if totalSize.height <= 670 {
            positX = -170
        } else {
            positX = -190
        }
        
        let lbl = UILabel()
        lbl.text = "Для поперечного шпагата".localized()
        lbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 5
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        self.view.addSubview(lbl)
        viewFive.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(positX)
            make.width.equalTo(300)
        }
        
        return lbl
    }()
    lazy var viewFiveImage: UIView = {
        let vi = UIView()
        vi.alpha = 0
        self.view.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        return vi
    }()
    
    lazy var imageFive: UIImageView = {
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
        var nameImage: String!
        switch Locale.current.languageCode {
        case "ru":
            nameImage = "stretchingPreviewFour"
        case "en":
            nameImage = "stretchingPreviewFourEn"
        default:
            nameImage = "stretchingPreviewFourEn"
        }
        
        let img = UIImageView(image: UIImage(named: nameImage))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        viewFiveImage.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(positX)
            make.height.equalTo(height)
        }
        
        return img
    }()
//FAKE
    lazy var viewFiveFake: UIView = {
        let vi = UIView()
        vi.alpha = 0
        self.view.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerXWithinMargins.equalTo(0)
        }
        
        return vi
    }()
    
    lazy var labelFiveFake: UILabel = {
        var positX: CGFloat!
        if totalSize.height >= 890 {
            positX = -180
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -190
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -190
        } else if totalSize.height <= 670 {
            positX = -170
        } else {
            positX = -190
        }
        
        let lbl = UILabel()
        lbl.text = "Для поперечного шпагата".localized()
        lbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 5
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        self.view.addSubview(lbl)
        viewFiveFake.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(positX)
            make.width.equalTo(300)
        }
        
        return lbl
    }()
    
    lazy var imageFiveFake: UIImageView = {
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
       let img = UIImageView(image: #imageLiteral(resourceName: "stretchingPreviewFour"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        viewFiveFake.addSubview(img)
        
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
        lbl.text = "Данные упражнения не являются готовым комплексом, а лишь собраны по направлениям, формируйте упражнения в любом удобном для Вас порядке".localized()
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
        lbl.text = "Данные упражнения не являются готовым комплексом, а лишь собраны по направлениям, формируйте упражнения в любом удобном для Вас порядке".localized()
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
