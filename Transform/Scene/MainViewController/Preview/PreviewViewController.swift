//
//  PreviewViewController.swift
//  Transform
//
//  Created by Pavel Lyutikov on 27.05.2021.
//

import UIKit
import SnapKit

class PreviewViewController: UIViewController {

    let totalSize = UIScreen.main.bounds.size

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        UserDefaults.standard.set(false, forKey: "isFirstPressButtonPreviewOne")
        
        viewOne.isHidden = false
        labelOne.isHidden = false
        labelOneSubTitle.isHidden = false
        
        viewTwo.isHidden = false
        imageTwo.isHidden = false
        
        viewTwoFake.isHidden = false
        imageTwoFake.isHidden = false

        viewThree.isHidden = false
        imageThree.isHidden = false

        viewThreeFake.isHidden = false
        imageThreeFake.isHidden = false

        viewFour.isHidden = false
        imageFour.isHidden = false

        viewFourFake.isHidden = false
        imageFourFake.isHidden = false

        viewFive.isHidden = false
        imageFive.isHidden = false
        
        viewFiveFake.isHidden = false
        imageFiveFake.isHidden = false
        
        imageLabelBackground.isHidden = false
        viewFavorites.isHidden = false
        labelFavorites.isHidden = false
        imageFavorites.isHidden = false
        
        viewComplex.isHidden = false
        labelComplex.isHidden = false
        imageComplex.isHidden = false
        
        viewFoodRation.isHidden = false
        labelFoodRation.isHidden = false
        imageFoodRation.isHidden = false
        
        
        nextButton.addTarget(self, action: #selector(actionNextButton(sender:)), for: .touchUpInside)
        
        nextButton.alpha = 0
        
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (timer) in
            self.viewTwo.alphaLeft()
        }
        
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
            self.viewThree.alphaLeft()
        }
        
        Timer.scheduledTimer(withTimeInterval: 4.5, repeats: false) { (timer) in
            self.viewFour.alphaLeft()
        }
        
        Timer.scheduledTimer(withTimeInterval: 6.0, repeats: false) { (timer) in
            self.viewFive.alphaLeft()
        }
        
        Timer.scheduledTimer(withTimeInterval: 7.5, repeats: false) { (timer) in
            self.nextButton.alpha()
        }
            
    }
    //MARK: - Button
    lazy var nextButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Далее".localized(), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        btn.setTitleColor(#colorLiteral(red: 0.8322479129, green: 0.5383385684, blue: 0.4425687341, alpha: 1), for: .normal)
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
        
        return btn
    }()

    @objc func actionNextButton(sender: UIButton) {
        
        if !UserDefaults.standard.bool(forKey: "isFirstPressButtonPreviewOne") {
                    viewOne.fadeLeft()
            
                    viewTwo.alpha = 0
                    viewTwoFake.alpha = 1
                    viewTwoFake.fadeLeft()
            
                    viewThree.alpha = 0
                    viewThreeFake.alpha = 1
                    viewThreeFake.fadeLeft()
            
                    viewFour.alpha = 0
                    viewFourFake.alpha = 1
                    viewFourFake.fadeLeft()
            
                    viewFive.alpha = 0
                    viewFiveFake.alpha = 1
                    viewFiveFake.fadeLeft()
            
                    nextButton.fade()
                    
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
                    self.viewFavorites.alphaLeft()
                }
                Timer.scheduledTimer(withTimeInterval: 3.5, repeats: false) { (timer) in
                    self.labelFavorites.fadeLeft()
                }
                Timer.scheduledTimer(withTimeInterval: 3.5, repeats: false) { (timer) in
                    self.viewComplex.alphaLeft()
                }
            
                switch Locale.current.languageCode {
                case "ru":
                    Timer.scheduledTimer(withTimeInterval: 6.5, repeats: false) { (timer) in
                        self.labelComplex.fadeLeft()
                    }
                    Timer.scheduledTimer(withTimeInterval: 6.5, repeats: false) { (timer) in
                        self.viewFoodRation.alphaLeft()
                    }
                    Timer.scheduledTimer(withTimeInterval: 8.5, repeats: false) { (timer) in
                        self.nextButton.alpha()
                    }
                case "en":
                    Timer.scheduledTimer(withTimeInterval: 6.5, repeats: false) { (timer) in
                        self.nextButton.alpha()
                    }
                default:
                    Timer.scheduledTimer(withTimeInterval: 6.5, repeats: false) { (timer) in
                        self.nextButton.alpha()
                    }
                }
                
            
           } else {
                let vc = PreviewPremiumViewController()
                vc.modalPresentationStyle = .fullScreen

                let transition = CATransition()
                transition.duration = 0.4
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(vc, animated: false, completion: nil)
           }
           UserDefaults.standard.set(true, forKey: "isFirstPressButtonPreviewOne")
        
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

    //MainTitle
    lazy var labelOne: UILabel = {
        var positX: CGFloat!
        if totalSize.height >= 890 {
            positX = -340
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -340
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -310
        } else if totalSize.height <= 670 {
            positX = -290
        } else {
            positX = -320
        }
        
        var fontSz: CGFloat!
        switch Locale.current.languageCode {
        case "ru":
            fontSz = 20
        case "en":
            fontSz = 30
            if totalSize.height >= 890 {
                positX = -350
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                positX = -350
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                positX = -320
            } else if totalSize.height <= 670 {
                positX = -300
            } else {
                positX = -330
            }
        default:
            fontSz = 30
            if totalSize.height >= 890 {
                positX = -350
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                positX = -350
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                positX = -320
            } else if totalSize.height <= 670 {
                positX = -300
            } else {
                positX = -330
            }
        }
        
        let lbl = UILabel()
        lbl.text = "ДОБРО ПОЖАЛОВАТЬ В".localized()
        lbl.textColor = #colorLiteral(red: 0.289646424, green: 0.289646424, blue: 0.289646424, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: fontSz)
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
        
    lazy var labelOneSubTitle: UILabel = {
        var positX: CGFloat!
        if totalSize.height >= 890 {
            positX = -320
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -320
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -290
        } else if totalSize.height <= 670 {
            positX = -270
        } else {
            positX = -300
        }
        
        let lbl = UILabel()
        lbl.text = "Transform-Fit"
        lbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 40)
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

    lazy var imageTwo: UIImageView = {
        var positX: CGFloat!
        var positY: CGFloat!
        var height: CGFloat!
        if totalSize.height >= 890 {
            positX = -220
            positY = -60
            height = 450
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -220
            positY = -60
            height = 450
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -220
            positY = -60
            height = 420
        } else if totalSize.height <= 670 {
            positX = -200
            positY = -60
            height = 360
        } else {
            positX = -220
            positY = -60
            height = 430
        }

        var nameImage: String!
        switch Locale.current.languageCode {
        case "ru":
            nameImage = "previewViewControllerWorkout"
        case "en":
            nameImage = "previewViewControllerWorkoutEn"
        default:
            nameImage = "previewViewControllerWorkoutEn"
        }
        
        let img = UIImageView(image: UIImage(named: nameImage))

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

    lazy var imageTwoFake: UIImageView = {
        var positX: CGFloat!
        var positY: CGFloat!
        var height: CGFloat!
        if totalSize.height >= 890 {
            positX = -220
            positY = -60
            height = 450
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -220
            positY = -60
            height = 450
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -220
            positY = -60
            height = 420
        } else if totalSize.height <= 670 {
            positX = -200
            positY = -60
            height = 360
        } else {
            positX = -220
            positY = -60
            height = 430
        }

        var nameImage: String!
        switch Locale.current.languageCode {
        case "ru":
            nameImage = "previewViewControllerWorkout"
        case "en":
            nameImage = "previewViewControllerWorkoutEn"
        default:
            nameImage = "previewViewControllerWorkoutEn"
        }
        
        let img = UIImageView(image: UIImage(named: nameImage))

        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        viewTwoFake.addSubview(img)

        img.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(positY)
            make.top.equalToSuperview().inset(positX)

            make.height.equalTo(height)
        }

        return img
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

    lazy var imageThree: UIImageView = {
        var positX: CGFloat!
        var positY: CGFloat!
        var height: CGFloat!
        if totalSize.height >= 890 {
            positX = -130
            positY = -20
            height = 450
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -140
            positY = -20
            height = 450
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -150
            positY = -20
            height = 420
        } else if totalSize.height <= 670 {
            positX = -130
            positY = -20
            height = 360
        } else {
            positX = -140
            positY = -20
            height = 430
        }

        var nameImage: String!
        switch Locale.current.languageCode {
        case "ru":
            nameImage = "previewViewControllerStretching"
        case "en":
            nameImage = "previewViewControllerStretchingEn"
        default:
            nameImage = "previewViewControllerStretchingEn"
        }
        
        let img = UIImageView(image: UIImage(named: nameImage))

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

    lazy var imageThreeFake: UIImageView = {
        var positX: CGFloat!
        var positY: CGFloat!
        var height: CGFloat!
        if totalSize.height >= 890 {
            positX = -130
            positY = -20
            height = 450
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -140
            positY = -20
            height = 450
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -150
            positY = -20
            height = 420
        } else if totalSize.height <= 670 {
            positX = -130
            positY = -20
            height = 360
        } else {
            positX = -140
            positY = -20
            height = 430
        }

        var nameImage: String!
        switch Locale.current.languageCode {
        case "ru":
            nameImage = "previewViewControllerStretching"
        case "en":
            nameImage = "previewViewControllerStretchingEn"
        default:
            nameImage = "previewViewControllerStretchingEn"
        }
        
        let img = UIImageView(image: UIImage(named: nameImage))

        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        viewThreeFake.addSubview(img)

        img.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(positY)
            make.top.equalToSuperview().inset(positX)

            make.height.equalTo(height)
        }

        return img
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

lazy var imageFour: UIImageView = {
    var positX: CGFloat!
    var positY: CGFloat!
    var height: CGFloat!
    if totalSize.height >= 890 {
        positX = -170
        positY = 20
        height = 450
    } else  if totalSize.height >= 830 && totalSize.height <= 889 {
        positX = -180
        positY = 20
        height = 450
    } else if totalSize.height >= 671 && totalSize.height <= 800 {
        positX = -190
        positY = 20
        height = 420
    } else if totalSize.height <= 670 {
        positX = -170
        positY = 20
        height = 360
    } else {
        positX = -180
        positY = 20
        height = 430
    }

    var nameImage: String!
    switch Locale.current.languageCode {
    case "ru":
        nameImage = "previewViewControllerYoga"
    case "en":
        nameImage = "previewViewControllerYogaEn"
    default:
        nameImage = "previewViewControllerYogaEn"
    }
    
    let img = UIImageView(image: UIImage(named: nameImage))

    img.contentMode = .scaleAspectFit
    self.view.addSubview(img)
    viewFour.addSubview(img)

    img.snp.makeConstraints { make in
        make.centerXWithinMargins.equalTo(positY)
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

lazy var imageFourFake: UIImageView = {
    var positX: CGFloat!
    var positY: CGFloat!
    var height: CGFloat!
    if totalSize.height >= 890 {
        positX = -170
        positY = 20
        height = 450
    } else  if totalSize.height >= 830 && totalSize.height <= 889 {
        positX = -180
        positY = 20
        height = 450
    } else if totalSize.height >= 671 && totalSize.height <= 800 {
        positX = -190
        positY = 20
        height = 420
    } else if totalSize.height <= 670 {
        positX = -170
        positY = 20
        height = 360
    } else {
        positX = -180
        positY = 20
        height = 430
    }

    var nameImage: String!
    switch Locale.current.languageCode {
    case "ru":
        nameImage = "previewViewControllerYoga"
    case "en":
        nameImage = "previewViewControllerYogaEn"
    default:
        nameImage = "previewViewControllerYogaEn"
    }
    
    let img = UIImageView(image: UIImage(named: nameImage))

    img.contentMode = .scaleAspectFit
    self.view.addSubview(img)
    viewFourFake.addSubview(img)

    img.snp.makeConstraints { make in
        make.centerXWithinMargins.equalTo(positY)
        make.top.equalToSuperview().inset(positX)

        make.height.equalTo(height)
    }

    return img
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

lazy var imageFive: UIImageView = {
    var positX: CGFloat!
    var positY: CGFloat!
    var height: CGFloat!
    if totalSize.height >= 890 {
        positX = -70
        positY = 60
        height = 450
    } else  if totalSize.height >= 830 && totalSize.height <= 889 {
        positX = -90
        positY = 60
        height = 450
    } else if totalSize.height >= 671 && totalSize.height <= 800 {
        positX = -110
        positY = 60
        height = 420
    } else if totalSize.height <= 670 {
        positX = -90
        positY = 60
        height = 360
    } else {
        positX = -80
        positY = 60
        height = 430
    }

    var nameImage: String!
    switch Locale.current.languageCode {
    case "ru":
        nameImage = "previewViewControllerRecovery"
    case "en":
        nameImage = "previewViewControllerRecoveryEn"
    default:
        nameImage = "previewViewControllerRecoveryEn"
    }
    
    let img = UIImageView(image: UIImage(named: nameImage))

    img.contentMode = .scaleAspectFit
    self.view.addSubview(img)
    viewFive.addSubview(img)

    img.snp.makeConstraints { make in
        make.centerXWithinMargins.equalTo(positY)
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

lazy var imageFiveFake: UIImageView = {
    var positX: CGFloat!
    var positY: CGFloat!
    var height: CGFloat!
    if totalSize.height >= 890 {
        positX = -70
        positY = 60
        height = 450
    } else  if totalSize.height >= 830 && totalSize.height <= 889 {
        positX = -90
        positY = 60
        height = 450
    } else if totalSize.height >= 671 && totalSize.height <= 800 {
        positX = -110
        positY = 60
        height = 420
    } else if totalSize.height <= 670 {
        positX = -90
        positY = 60
        height = 360
    } else {
        positX = -80
        positY = 60
        height = 430
    }

    var nameImage: String!
    switch Locale.current.languageCode {
    case "ru":
        nameImage = "previewViewControllerRecovery"
    case "en":
        nameImage = "previewViewControllerRecoveryEn"
    default:
        nameImage = "previewViewControllerRecoveryEn"
    }
    
    let img = UIImageView(image: UIImage(named: nameImage))

    img.contentMode = .scaleAspectFit
    self.view.addSubview(img)
    viewFourFake.addSubview(img)

    img.snp.makeConstraints { make in
        make.centerXWithinMargins.equalTo(positY)
        make.top.equalToSuperview().inset(positX)

        make.height.equalTo(height)
    }

    return img
}()
//MARK: - ViewFavorites
    lazy var viewFavorites: UIView = {
        let vi = UIView()
        vi.alpha = 0
        self.view.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerXWithinMargins.equalTo(200)
        }
        
        return vi
    }()

    lazy var labelFavorites: UILabel = {
        var positX: CGFloat!
        var fontSz: CGFloat!
        if totalSize.height >= 890 {
            positX = -350
            fontSz = 28
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -323
            fontSz = 27
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -300
            fontSz = 26
        } else if totalSize.height <= 670 {
            positX = -273
            fontSz = 26
        } else {
            positX = -327
            fontSz = 27
        }
        
        var wdth: CGFloat!
        switch Locale.current.languageCode {
        case "ru":
            wdth = 300
        case "en":
            wdth = 230
        default:
            wdth = 230
        }
        
        
        let lbl = UILabel()
        lbl.text = "Составь свою тренировку".localized()
        lbl.textColor = #colorLiteral(red: 0.3565558994, green: 0.3565558994, blue: 0.3565558994, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: fontSz)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 7
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.5
        self.view.addSubview(lbl)
        viewFavorites.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(positX)
            make.width.equalTo(wdth)
        }
        
        return lbl
    }()

    lazy var imageFavorites: UIImageView = {
        var positX: CGFloat!
        var positY: CGFloat!
        var height: CGFloat!
        if totalSize.height >= 890 {
            positX = -220
            positY = -60
            height = 450
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -190
            positY = -60
            height = 450
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -190
            positY = -60
            height = 420
        } else if totalSize.height <= 670 {
            positX = -160
            positY = -60
            height = 360
        } else {
            positX = -200
            positY = -60
            height = 430
        }
        

        var nameImage: String!
        switch Locale.current.languageCode {
        case "ru":
            nameImage = "previewViewControllerFavorite"
        case "en":
            nameImage = "previewViewControllerFavoriteEn"
        default:
            nameImage = "previewViewControllerFavoriteEn"
        }
        
        let img = UIImageView(image: UIImage(named: nameImage))

        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        viewFavorites.addSubview(img)

        img.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(positY)
            make.top.equalToSuperview().inset(positX)

            make.height.equalTo(height)
        }

        return img
    }()
    
    lazy var imageLabelBackground: UIImageView = {
        var positX: CGFloat!
        var positY: CGFloat!
        var height: CGFloat!
        if totalSize.height >= 890 {
            positX = -365
            height = 100
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -340
            height = 100
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -315
            height = 90
        } else if totalSize.height <= 670 {
            positX = -285
            height = 90
        } else {
            positX = -345
            height = 100
        }

        let img = UIImageView(image: #imageLiteral(resourceName: "whitePanelBackgroundPreview"))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 8
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.5
        self.view.addSubview(img)
        viewFavorites.addSubview(img)

        img.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(positX)

            make.height.equalTo(height)
        }

        return img
    }()
//MARK: - ViewComplex
    lazy var viewComplex: UIView = {
        let vi = UIView()
        vi.alpha = 0
        self.view.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerXWithinMargins.equalTo(200)
        }
        
        return vi
    }()

    lazy var labelComplex: UILabel = {
        var positX: CGFloat!
        var fontSz: CGFloat!
        if totalSize.height >= 890 {
            positX = -350
            fontSz = 28
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -323
            fontSz = 27
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -300
            fontSz = 26
        } else if totalSize.height <= 670 {
            positX = -273
            fontSz = 26
        } else {
            positX = -327
            fontSz = 27
        }
        
        let lbl = UILabel()
        lbl.text = "Или используй уже готовую".localized()
        lbl.textColor = #colorLiteral(red: 0.3565558994, green: 0.3565558994, blue: 0.3565558994, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: fontSz)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 7
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.5
        self.view.addSubview(lbl)
        viewComplex.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(positX)
            make.width.equalTo(300)
        }
        
        return lbl
    }()

    lazy var imageComplex: UIImageView = {
        var positX: CGFloat!
        var positY: CGFloat!
        var height: CGFloat!
        
        switch Locale.current.languageCode {
        case "ru":
            if totalSize.height >= 890 {
                positX = -100
                positY = 0
                height = 450
            } else  if totalSize.height >= 830 && totalSize.height <= 889 {
                positX = -90
                positY = 0
                height = 450
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                positX = -110
                positY = 0
                height = 420
            } else if totalSize.height <= 670 {
                positX = -80
                positY = 0
                height = 360
            } else {
                positX = -90
                positY = 0
                height = 430
            }
        case "en":
            if totalSize.height >= 890 {
                positX = -100
                positY = 60
                height = 450
            } else  if totalSize.height >= 830 && totalSize.height <= 889 {
                positX = -90
                positY = 60
                height = 450
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                positX = -110
                positY = 60
                height = 420
            } else if totalSize.height <= 670 {
                positX = -80
                positY = 60
                height = 360
            } else {
                positX = -90
                positY = 60
                height = 430
            }
        default:
            if totalSize.height >= 890 {
                positX = -100
                positY = 60
                height = 450
            } else  if totalSize.height >= 830 && totalSize.height <= 889 {
                positX = -90
                positY = 60
                height = 450
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                positX = -110
                positY = 60
                height = 420
            } else if totalSize.height <= 670 {
                positX = -80
                positY = 60
                height = 360
            } else {
                positX = -90
                positY = 60
                height = 430
            }
        }


        var nameImage: String!
        switch Locale.current.languageCode {
        case "ru":
            nameImage = "previewViewControllerComplex"
        case "en":
            nameImage = "previewViewControllerComplexEn"
        default:
            nameImage = "previewViewControllerComplexEn"
        }
        
        let img = UIImageView(image: UIImage(named: nameImage))

        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        viewComplex.addSubview(img)

        img.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(positY)
            make.top.equalToSuperview().inset(positX)

            make.height.equalTo(height)
        }

        return img
    }()
//MARK: - ViewFoodRation
    lazy var viewFoodRation: UIView = {
        let vi = UIView()
        vi.alpha = 0
        self.view.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerXWithinMargins.equalTo(200)
        }
        
        return vi
    }()

    lazy var labelFoodRation: UILabel = {
        var positX: CGFloat!
        var fontSz: CGFloat!
        if totalSize.height >= 890 {
            positX = -350
            fontSz = 28
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -323
            fontSz = 27
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -300
            fontSz = 26
        } else if totalSize.height <= 670 {
            positX = -273
            fontSz = 26
        } else {
            positX = -327
            fontSz = 27
        }
        
        let lbl = UILabel()
        lbl.text = "И не забывай про питание".localized()
        lbl.textColor = #colorLiteral(red: 0.3565558994, green: 0.3565558994, blue: 0.3565558994, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: fontSz)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 7
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.5
        self.view.addSubview(lbl)
        viewFoodRation.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(positX)
            make.width.equalTo(300)
        }
        
        return lbl
    }()

    lazy var imageFoodRation: UIImageView = {
        var positX: CGFloat!
        var positY: CGFloat!
        var height: CGFloat!
        if totalSize.height >= 890 {
            positX = -160
            positY = 60
            height = 450
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -140
            positY = 60
            height = 450
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -150
            positY = 60
            height = 420
        } else if totalSize.height <= 670 {
            positX = -120
            positY = 60
            height = 360
        } else {
            positX = -150
            positY = 60
            height = 430
        }

        let img = UIImageView(image: #imageLiteral(resourceName: "previewViewControllerFoodRation"))

        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        viewFoodRation.addSubview(img)

        img.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(positY)
            make.top.equalToSuperview().inset(positX)

            make.height.equalTo(height)
        }

        return img
    }()
}
