//
//  PreviewFoodRationViewController.swift
//  Transform
//
//  Created by Pavel Lyutikov on 06.08.2021.
//

import UIKit
import SnapKit

class PreviewFoodRationViewController: UIViewController {

    let totalSize = UIScreen.main.bounds.size

    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        nextButton.addTarget(self, action: #selector(actionNextButton(sender:)), for: .touchUpInside)
        
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
//MARK: - Button
    lazy var nextButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Далее".localized(), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        btn.setTitleColor(#colorLiteral(red: 0.9163805842, green: 0.609824717, blue: 0.3224352002, alpha: 1), for: .normal)
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
        
        return btn
    }()
    
    @objc func actionNextButton(sender: UIButton) {
        
        if !UserDefaults.standard.bool(forKey: "isFirstPressButtonFoodRationOne") {
                    viewOne.fadeLeft()
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                        self.viewTwo.alphaLeft()
                    }
           } else {
                if !UserDefaults.standard.bool(forKey: "isFirstPressButtonFoodRationTwo") {

//                        nextButton.fade()
                    
                        viewTwo.alpha = 0
                        viewTwoFake.alpha = 1
                        viewTwoFake.fadeLeft()
                        
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                            self.viewThree.alphaLeft()
                        }
                   } else {

                        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                        
                            let vc = MenuFoodRationViewController()
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
                   UserDefaults.standard.set(true, forKey: "isFirstPressButtonFoodRationTwo")
           }
           UserDefaults.standard.set(true, forKey: "isFirstPressButtonFoodRationOne")
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
            positX = -320
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -300
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -290
        } else if totalSize.height <= 670 {
            positX = -270
        } else {
            positX = -280
        }

        let lbl = UILabel()
        lbl.text = "В данном разделе представлен калькулятор расчета нормы калорий, в зависимости от ваших целей"
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
            positX = -80
            height = 440
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -90
            height = 420
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -100
            height = 410
        } else if totalSize.height <= 670 {
            positX = -100
            height = 380
        } else {
            positX = -80
            height = 400
        }
        
        let img = UIImageView(image: #imageLiteral(resourceName: "previewFoodRationOne"))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 8
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.8
        self.view.addSubview(img)
        viewOne.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(-5)
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
            positX = -320
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -290
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -280
        } else if totalSize.height <= 670 {
            positX = -250
        } else {
            positX = -290
        }
        
        let lbl = UILabel()
        lbl.text = "А также рационы питания на неделю, состоящие из 6 приемов пищи"
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
            make.width.equalTo(310)
        }
        
        return lbl
    }()
    
    lazy var imageTwo: UIImageView = {
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
            positX = -110
            height = 380
        } else {
            positX = -140
            height = 480
        }
        
        let img = UIImageView(image: #imageLiteral(resourceName: "previewFoodRationTwo"))
        
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
            positX = -320
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -290
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -280
        } else if totalSize.height <= 670 {
            positX = -250
        } else {
            positX = -290
        }
        
        let lbl = UILabel()
        lbl.text = "А также рационы питания на неделю, состоящие из 6 приемов пищи"
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
            make.width.equalTo(320)
        }
        
        return lbl
    }()
    
    lazy var imageTwoFake: UIImageView = {
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
            positX = -110
            height = 380
        } else {
            positX = -140
            height = 480
        }
        
        let img = UIImageView(image: #imageLiteral(resourceName: "previewFoodRationTwo"))
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
            positX = -350
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -330
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -320
        } else if totalSize.height <= 670 {
            positX = -290
        } else {
            positX = -330
        }
        
        let lbl = UILabel()
        lbl.text = "Рационы составлены с оптимальным соотношением нутриентов. Для ознакомления 'Понедельник' доступен бесплатно"
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
            make.width.equalTo(320)
        }
        
        return lbl
    }()
    
    lazy var imageThree: UIImageView = {
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
            positX = -110
            height = 380
        } else {
            positX = -140
            height = 480
        }
        
        let img = UIImageView(image: #imageLiteral(resourceName: "previewFoodRationThree"))
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
            positX = -350
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -330
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -320
        } else if totalSize.height <= 670 {
            positX = -290
        } else {
            positX = -330
        }
        
        let lbl = UILabel()
        lbl.text = "Рационы составлены с оптимальным соотношением нутриентов. Для ознакомления 'Понедельник' доступен бесплатно"
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
            make.width.equalTo(320)
        }
        
        return lbl
    }()
    
    lazy var imageThreeFake: UIImageView = {
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
            positX = -110
            height = 380
        } else {
            positX = -140
            height = 480
        }
        let img = UIImageView(image: #imageLiteral(resourceName: "previewFoodRationThree"))
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
}
