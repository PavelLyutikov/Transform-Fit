//
//  PreviewChosenStretchingViewController.swift
//  Transform
//
//  Created by Pavel Lyutikov on 21.05.2021.
//

import UIKit
import SnapKit

class PreviewChosenStretchingViewController: UIViewController {

    let totalSize = UIScreen.main.bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(false, forKey: "isFirstPressButtonFavoriteStretchingThree")
        UserDefaults.standard.set(false, forKey: "isFirstPressButtonFavoriteStretchingTwo")
        UserDefaults.standard.set(false, forKey: "isFirstPressButtonFavoriteStretchingOne")

        self.view.backgroundColor = .white

        viewOne.isHidden = false
        imageOne.isHidden = false
        labelOne.isHidden = false
        viewTwo.isHidden = false
        imageTwo.isHidden = false
        labelTwo.isHidden = false
        viewTwoFake.isHidden = false
        imageTwoFake.isHidden = false
        labelTwoFake.isHidden = false
        viewThree.isHidden = false
        imageThree.isHidden = false
        labelThree.isHidden = false
        viewThreeFake.isHidden = false
        imageThreeFake.isHidden = false
        labelThreeFake.isHidden = false
        viewFour.isHidden = false
        imageFour.isHidden = false
        labelFour.isHidden = false
        viewFourFake.isHidden = false
        imageFourFake.isHidden = false
        labelFourFake.isHidden = false
        
        nextButton.addTarget(self, action: #selector(actionNextButton(sender:)), for: .touchUpInside)
        

        
        UIView.animate(withDuration: 1.0, animations: {
            self.viewTwo.frame = CGRect(x: 200, y: 0, width: 0, height: 0)
            })
            
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
        
        if !UserDefaults.standard.bool(forKey: "isFirstPressButtonFavoriteStretchingOne") {
                    viewOne.fadeLeft()
                    
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                        self.viewTwo.alphaLeft()
                    }
           } else {
                if !UserDefaults.standard.bool(forKey: "isFirstPressButtonFavoriteStretchingTwo") {

                        viewTwo.alpha = 0
                        viewTwoFake.alpha = 1
                        viewTwoFake.fadeLeft()
                        
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                            self.viewThree.alphaLeft()
                        }
                   } else {
                        if !UserDefaults.standard.bool(forKey: "isFirstPressButtonFavoriteStretchingThree") {

                            viewThree.alpha = 0
                            viewThreeFake.alpha = 1
                            viewThreeFake.fadeLeft()
                                
                            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                                    self.viewFour.alphaLeft()
                                }
                           } else {
                            
                            viewFour.alpha = 0
                            viewFourFake.alpha = 1
                            viewFourFake.fadeLeft()
                            
                            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                            
                                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ChosenStretchingTableViewController")
                
                                viewController.modalPresentationStyle = .fullScreen
                
                                let transition = CATransition()
                                transition.duration = 0.4
                                transition.type = CATransitionType.fade
                                transition.subtype = CATransitionSubtype.fromRight
                                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
                                self.view.window!.layer.add(transition, forKey: kCATransition)
                
                                self.present(viewController, animated: false, completion: nil)
                                }
                            
                           }
                           UserDefaults.standard.set(true, forKey: "isFirstPressButtonFavoriteStretchingThree")
                    
                   }
                   UserDefaults.standard.set(true, forKey: "isFirstPressButtonFavoriteStretchingTwo")
           }
           UserDefaults.standard.set(true, forKey: "isFirstPressButtonFavoriteStretchingOne")
        
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
            positX = -300
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -330
            case "en":
                positX = -310
            default:
                positX = -310
            }
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -310
            case "en":
                positX = -290
            default:
                positX = -290
            }
        } else if totalSize.height <= 670 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -300
            case "en":
                positX = -290
            default:
                positX = -290
            }
        } else {
            switch Locale.current.languageCode {
            case "ru":
                positX = -320
            case "en":
                positX = -310
            default:
                positX = -310
            }
        }
        
        let lbl = UILabel()
        lbl.text = "В данном разделе вы можете составить тренировку для себя, добавив упражнения из общего списка".localized()
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
            positX = -150
            height = 420
        } else {
            positX = -140
            height = 480
        }
        
        var nameImage: String!
        switch Locale.current.languageCode {
        case "ru":
            nameImage = "previewChosenStretchingOne"
        case "en":
            nameImage = "previewChosenStretchingOneEn"
        default:
            nameImage = "previewChosenStretchingOneEn"
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
            positX = -290
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -330
            case "en":
                positX = -300
            default:
                positX = -300
            }
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -300
            case "en":
                positX = -280
            default:
                positX = -280
            }
        } else if totalSize.height <= 670 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -300
            case "en":
                positX = -270
            default:
                positX = -270
            }
        } else {
            switch Locale.current.languageCode {
            case "ru":
                positX = -310
            case "en":
                positX = -290
            default:
                positX = -290
            }
        }
        
        let lbl = UILabel()
        lbl.text = "Чтобы добавить упражнение, зайди в нужный раздел и свайпни упражнение, которое понравилось".localized()
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
            positX = -150
            height = 420
        } else {
            positX = -140
            height = 480
        }
        var nameImage: String!
        switch Locale.current.languageCode {
        case "ru":
            nameImage = "previewChosenStretchingTwo"
        case "en":
            nameImage = "previewChosenStretchingTwoEn"
        default:
            nameImage = "previewChosenStretchingTwoEn"
        }
        
        let img = UIImageView(image: UIImage(named: nameImage))
        
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        viewTwo.addSubview(img)
        
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
            positX = -290
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -330
            case "en":
                positX = -300
            default:
                positX = -300
            }
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -300
            case "en":
                positX = -280
            default:
                positX = -280
            }
        } else if totalSize.height <= 670 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -300
            case "en":
                positX = -270
            default:
                positX = -270
            }
        } else {
            switch Locale.current.languageCode {
            case "ru":
                positX = -310
            case "en":
                positX = -290
            default:
                positX = -290
            }
        }
        
        let lbl = UILabel()
        lbl.text = "Чтобы добавить упражнение, зайди в нужный раздел и свайпни упражнение, которое понравилось".localized()
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
    
    lazy var imageTwoFake: UIImageView = {
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
            positX = -150
            height = 420
        } else {
            positX = -140
            height = 480
        }
        var nameImage: String!
        switch Locale.current.languageCode {
        case "ru":
            nameImage = "previewChosenStretchingTwo"
        case "en":
            nameImage = "previewChosenStretchingTwoEn"
        default:
            nameImage = "previewChosenStretchingTwoEn"
        }
        
        let img = UIImageView(image: UIImage(named: nameImage))
        
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        viewTwoFake.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
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
    
    lazy var labelThree: UILabel = {
        var positX: CGFloat!
        if totalSize.height >= 890 {
            positX = -280
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -310
            case "en":
                positX = -290
            default:
                positX = -290
            }
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -280
        } else if totalSize.height <= 670 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -280
            case "en":
                positX = -270
            default:
                positX = -270
            }
        } else {
            positX = -290
        }
        
        let lbl = UILabel()
        lbl.text = "Чтобы формировать список в нужном порядке, зажми упражнение и перемещай".localized()
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
            positX = -150
            height = 420
        } else {
            positX = -140
            height = 480
        }
        var nameImage: String!
        switch Locale.current.languageCode {
        case "ru":
            nameImage = "previewChosenStretchingThree"
        case "en":
            nameImage = "previewChosenStretchingThreeEn"
        default:
            nameImage = "previewChosenStretchingThreeEn"
        }
        
        let img = UIImageView(image: UIImage(named: nameImage))
        
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        viewThree.addSubview(img)
        
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
            positX = -280
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -310
            case "en":
                positX = -290
            default:
                positX = -290
            }
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -280
        } else if totalSize.height <= 670 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -280
            case "en":
                positX = -270
            default:
                positX = -270
            }
        } else {
            positX = -290
        }
        
        let lbl = UILabel()
        lbl.text = "Чтобы формировать список в нужном порядке, зажми упражнение и перемещай".localized()
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
    
    lazy var imageThreeFake: UIImageView = {
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
            positX = -150
            height = 420
        } else {
            positX = -140
            height = 480
        }
        var nameImage: String!
        switch Locale.current.languageCode {
        case "ru":
            nameImage = "previewChosenStretchingThree"
        case "en":
            nameImage = "previewChosenStretchingThreeEn"
        default:
            nameImage = "previewChosenStretchingThreeEn"
        }
        
        let img = UIImageView(image: UIImage(named: nameImage))
        
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        viewThreeFake.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
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
    
    lazy var labelFour: UILabel = {
        var positX: CGFloat!
        if totalSize.height >= 890 {
            positX = -260
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -300
            case "en":
                positX = -280
            default:
                positX = -280
            }
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -260
        } else if totalSize.height <= 670 {
            positX = -250
        } else {
            positX = -270
        }
        
        let lbl = UILabel()
        lbl.text = "Свайпни упражнение, чтобы удалить его".localized()
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
            positX = -150
            height = 420
        } else {
            positX = -140
            height = 480
        }
        var nameImage: String!
        switch Locale.current.languageCode {
        case "ru":
            nameImage = "previewChosenStretchingFour"
        case "en":
            nameImage = "previewChosenStretchingFourEn"
        default:
            nameImage = "previewChosenStretchingFourEn"
        }
        
        let img = UIImageView(image: UIImage(named: nameImage))
        
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        viewFour.addSubview(img)
        
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
            positX = -260
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -300
            case "en":
                positX = -280
            default:
                positX = -280
            }
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -260
        } else if totalSize.height <= 670 {
            positX = -250
        } else {
            positX = -270
        }
        
        let lbl = UILabel()
        lbl.text = "Свайпни упражнение, чтобы удалить его".localized()
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
            positX = -150
            height = 420
        } else {
            positX = -140
            height = 480
        }
        var nameImage: String!
        switch Locale.current.languageCode {
        case "ru":
            nameImage = "previewChosenStretchingFour"
        case "en":
            nameImage = "previewChosenStretchingFourEn"
        default:
            nameImage = "previewChosenStretchingFourEn"
        }
        
        let img = UIImageView(image: UIImage(named: nameImage))
        
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
}
