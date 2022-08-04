//
//  PreviewYogaViewController.swift
//  Transform
//
//  Created by Pavel Lyutikov on 27.05.2021.
//

import UIKit
import SnapKit

class PreviewYogaViewController: UIViewController {
    
    let totalSize = UIScreen.main.bounds.size

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(false, forKey: "isFirstPressButtonYogaOne")
        UserDefaults.standard.set(false, forKey: "isFirstPressButtonYogaTwo")
        
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
        labelThree.isHidden = false
        viewThreeFake.isHidden = false
        labelThreeFake.isHidden = false
        
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
        btn.setTitleColor(#colorLiteral(red: 0.6141310334, green: 0.2240989804, blue: 0.2263827324, alpha: 1), for: .normal)
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
        
        return btn
    }()
    
    @objc func actionNextButton(sender: UIButton) {
        
        if !UserDefaults.standard.bool(forKey: "isFirstPressButtonYogaOne") {
                    viewOne.fadeLeft()
                    
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                        self.viewTwo.alphaLeft()
                    }
           } else {
                if !UserDefaults.standard.bool(forKey: "isFirstPressButtonYogaTwo") {
                        
                    labelTwo.alpha = 0
                    viewTwoFake.alpha = 1
                    labelTwoFake.fadeLeft()
                        
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                            self.viewThree.alphaLeft()
                        }
                   } else {
                            viewThree.alpha = 0
                            viewThreeFake.alpha = 1
                            viewThreeFake.fadeLeft()
                            imageTwo.alpha = 0
                            imageTwoFake.alpha = 1
                            imageTwoFake.fadeLeft()
                                
                            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                                let vc = YogaMenuViewController()
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
                   UserDefaults.standard.set(true, forKey: "isFirstPressButtonYogaTwo")
           }
           UserDefaults.standard.set(true, forKey: "isFirstPressButtonYogaOne")
        
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
                positX = -300
            default:
                positX = -300
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
            positX = -310
        }

        let lbl = UILabel()
        lbl.text = "Хатха - йога \n \nВ данном разделе представлены примеры базовых асан".localized()
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
            positX = -160
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
        
        let img = UIImageView(image: #imageLiteral(resourceName: "previewYogaOne"))
        
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
            positX = -310
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -280
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -280
            case "en":
                positX = -270
            default:
                positX = -270
            }
        } else if totalSize.height <= 670 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -260
            case "en":
                positX = -250
            default:
                positX = -250
            }
        } else {
            positX = -280
        }
        
        let lbl = UILabel()
        lbl.text = "Для удобства навигации они разделены на несколько частей".localized()
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
            positX = -160
            height = 550
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -130
            height = 500
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -140
            height = 450
        } else if totalSize.height <= 670 {
            positX = -130
            height = 400
        } else {
            positX = -140
            height = 480
        }
        
        let img = UIImageView(image: #imageLiteral(resourceName: "previewYogaTwo"))
        
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
            positX = -310
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -280
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -280
            case "en":
                positX = -270
            default:
                positX = -270
            }
        } else if totalSize.height <= 670 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -260
            case "en":
                positX = -250
            default:
                positX = -250
            }
        } else {
            positX = -280
        }
        
        let lbl = UILabel()
        lbl.text = "Для удобства навигации они разделены на несколько частей".localized()
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
            positX = -160
            height = 550
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -130
            height = 500
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -140
            height = 450
        } else if totalSize.height <= 670 {
            positX = -130
            height = 400
        } else {
            positX = -140
            height = 480
        }
        
        let img = UIImageView(image: #imageLiteral(resourceName: "previewYogaTwo"))
        
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
            switch Locale.current.languageCode {
            case "ru":
                positX = -350
            case "en":
                positX = -330
            default:
                positX = -330
            }
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
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
                positX = -330
            case "en":
                positX = -300
            default:
                positX = -300
            }
        } else if totalSize.height <= 670 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -310
            case "en":
                positX = -280
            default:
                positX = -280
            }
        } else {
            switch Locale.current.languageCode {
            case "ru":
                positX = -330
            case "en":
                positX = -310
            default:
                positX = -310
            }
        }

        let lbl = UILabel()
        lbl.text = "Составляя асаны в подходящей для Вас последовательности, Вы можете составить разминку или полноценный комплекс".localized()
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
            switch Locale.current.languageCode {
            case "ru":
                positX = -350
            case "en":
                positX = -330
            default:
                positX = -330
            }
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
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
                positX = -330
            case "en":
                positX = -300
            default:
                positX = -300
            }
        } else if totalSize.height <= 670 {
            switch Locale.current.languageCode {
            case "ru":
                positX = -310
            case "en":
                positX = -280
            default:
                positX = -280
            }
        } else {
            switch Locale.current.languageCode {
            case "ru":
                positX = -330
            case "en":
                positX = -310
            default:
                positX = -310
            }
        }

        let lbl = UILabel()
        lbl.text = "Составляя асаны в подходящей для Вас последовательности, Вы можете составить разминку или полноценный комплекс".localized()
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
}
