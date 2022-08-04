//
//  PreviewHomeWorkoutViewController.swift
//  Transform
//
//  Created by Pavel Lyutikov on 25.05.2021.
//

import UIKit
import SnapKit

class PreviewHomeWorkoutViewController: UIViewController {

    let totalSize = UIScreen.main.bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        viewOne.isHidden = false
        imageOne.isHidden = false
        labelOne.isHidden = false
        viewTwo.isHidden = false
        labelTwo.isHidden = false
        viewTwoFake.isHidden = false
        labelTwoFake.isHidden = false
        viewThree.isHidden = false
        labelThree.isHidden = false
        viewThreeFake.isHidden = false
        labelThreeFake.isHidden = false
        viewFour.isHidden = false
        labelFour.isHidden = false
        viewFourFake.isHidden = false
        labelFourFake.isHidden = false
        
        nextButton.addTarget(self, action: #selector(actionNextButton(sender:)), for: .touchUpInside)

    }
//MARK: - Button
    lazy var nextButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Далее".localized(), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        btn.setTitleColor(#colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1), for: .normal)
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
        
        return btn
    }()
    
    @objc func actionNextButton(sender: UIButton) {
        
        if !UserDefaults.standard.bool(forKey: "isFirstPressButtonHomeWorkoutOne") {
                    labelOne.fadeLeft()
                    
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                        self.viewTwo.alphaLeft()
                    }
           } else {
                if !UserDefaults.standard.bool(forKey: "isFirstPressButtonHomeWorkoutTwo") {

                        viewTwo.alpha = 0
                        viewTwoFake.alpha = 1
                        viewTwoFake.fadeLeft()
                        
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                            self.viewThree.alphaLeft()
                        }
                   } else {
                        if !UserDefaults.standard.bool(forKey: "isFirstPressButtonHomeWorkoutThree") {

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
                            imageOne.fadeLeft()
                            
                            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                                let vc = HomeWorkoutMenuViewController()
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
                           UserDefaults.standard.set(true, forKey: "isFirstPressButtonHomeWorkoutThree")
                    
                   }
                   UserDefaults.standard.set(true, forKey: "isFirstPressButtonHomeWorkoutTwo")
           }
           UserDefaults.standard.set(true, forKey: "isFirstPressButtonHomeWorkoutOne")
        
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
            positX = -340
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -330
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -310
        } else if totalSize.height <= 670 {
            positX = -300
        } else {
            switch Locale.current.languageCode {
            case "ru":
                positX = -310
            case "en":
                positX = -320
            default:
                positX = -320
            }
        }
        
        let lbl = UILabel()
        lbl.text = "В данном разделе собраны упражнения для занятий с минимальным инвентарем (дома), которые разбиты по группам мышц".localized()
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
            positX = -150
            height = 550
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
            nameImage = "previewHomeWorkout"
        case "en":
            nameImage = "previewHomeWorkoutEn"
        default:
            nameImage = "previewHomeWorkoutEn"
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
            switch Locale.current.languageCode {
            case "ru":
                positX = -320
            case "en":
                positX = -300
            default:
                positX = -300
            }
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -300
            case "en":
                positX = -290
            default:
                positX = -290
            }
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -290
            case "en":
                positX = -275
            default:
                positX = -275
            }
        } else if totalSize.height <= 670 {
            positX = -270
        } else {
            positX = -290
        }
        
        let lbl = UILabel()
        lbl.text = "Просто нажимай на мышцы, чтобы перейти к упражнениям".localized()
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
            switch Locale.current.languageCode {
            case "ru":
                positX = -320
            case "en":
                positX = -300
            default:
                positX = -300
            }
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -300
            case "en":
                positX = -290
            default:
                positX = -290
            }
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -290
            case "en":
                positX = -275
            default:
                positX = -275
            }
        } else if totalSize.height <= 670 {
            positX = -270
        } else {
            positX = -290
        }
        
        let lbl = UILabel()
        lbl.text = "Просто нажимай на мышцы, чтобы перейти к упражнениям".localized()
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
            positX = -340
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -320
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -310
        } else if totalSize.height <= 670 {
            positX = -300
        } else {
            positX = -320
        }
        
        let lbl = UILabel()
        lbl.text = "Мышечные группы: \n \nМышцы ног / Мышцы рук \n Плечи / Ягодицы / Грудные \n Мышцы кора / Мышцы спины".localized()
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
            make.width.equalTo(350)
        }
        
        return lbl
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
            positX = -340
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -320
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -310
        } else if totalSize.height <= 670 {
            positX = -300
        } else {
            positX = -320
        }
        
        let lbl = UILabel()
        lbl.text = "Мышечные группы: \n \nМышцы ног / Мышцы рук \n Плечи / Ягодицы / Грудные \n Мышцы кора / Мышцы спины".localized()
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
            make.width.equalTo(350)
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
            positX = -330
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -320
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
                positX = -300
            default:
                positX = -300
            }
        } else if totalSize.height <= 670 {
            positX = -300
        } else {
            positX = -310
        }
        
        let lbl = UILabel()
        lbl.text = "Данные упражнения не являются готовым комплексом, упражнения сформированны по мышечным группам".localized()
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
            positX = -330
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -320
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
                positX = -300
            default:
                positX = -300
            }
        } else if totalSize.height <= 670 {
            positX = -300
        } else {
            positX = -310
        }
        
        let lbl = UILabel()
        lbl.text = "Данные упражнения не являются готовым комплексом, упражнения сформированны по мышечным группам".localized()
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
}
