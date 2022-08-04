//
//  PreviewBodyGuideViewController.swift
//  Transform
//
//  Created by Pavel Lyutikov on 27.05.2021.
//

import UIKit
import SnapKit
import SafariServices

class PreviewBodyGuideViewController: UIViewController {

    let totalSize = UIScreen.main.bounds.size

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        viewOne.isHidden = false
        imageOne.isHidden = false
        labelOne.isHidden = false
        buttonInstagram.isHidden = false
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
        
        buttonInstagram.addTarget(self, action: #selector(actionButtonInstagram(sender:)), for: .touchUpInside)
        
        
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
        btn.setTitleColor(#colorLiteral(red: 0.9218779206, green: 0.6352821321, blue: 0.4530384603, alpha: 1), for: .normal)
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
        
        return btn
    }()
    
    @objc func actionNextButton(sender: UIButton) {
        
        if !UserDefaults.standard.bool(forKey: "isFirstPressButtonBodyGuideOne") {
                    viewOne.fadeLeft()
                    buttonInstagram.fadeLeft()
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                        self.viewTwo.alphaLeft()
                    }
           } else {
                if !UserDefaults.standard.bool(forKey: "isFirstPressButtonBodyGuideTwo") {

                        viewTwo.alpha = 0
                        viewTwoFake.alpha = 1
                        viewTwoFake.fadeLeft()
                        
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                            self.viewThree.alphaLeft()
                        }
                   } else {
                        if !UserDefaults.standard.bool(forKey: "isFirstPressButtonBodyGuideThree") {

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
                            
                                let vc = MenuBodyGuideViewController()
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
                           UserDefaults.standard.set(true, forKey: "isFirstPressButtonBodyGuideThree")
                    
                   }
                   UserDefaults.standard.set(true, forKey: "isFirstPressButtonBodyGuideTwo")
           }
           UserDefaults.standard.set(true, forKey: "isFirstPressButtonBodyGuideOne")

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
            positX = -270
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -270
        } else if totalSize.height <= 670 {
            positX = -250
        } else {
            positX = -310
        }

        let lbl = UILabel()
        lbl.text = "В данном разделе представлено наше пособие, автор:".localized()
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
    
    lazy var buttonInstagram: UIButton = {
        var positX: CGFloat!
        if totalSize.height >= 890 {
            positX = 220
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = 250
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = 210
        } else if totalSize.height <= 670 {
            positX = 190
        } else {
            positX = 220
        }
        
        let btn = UIButton()
        btn.setTitle("@transform_shev", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.9218779206, green: 0.6352821321, blue: 0.4530384603, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(positX)
        }
        
        return btn
    }()
    
    @objc func actionButtonInstagram(sender: UIButton) {
        showSafariVC(for: "https://www.instagram.com/transform_shev/")
    }
    func showSafariVC(for url: String) {
        guard let url = URL(string: url) else {
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    lazy var imageOne: UIImageView = {
        var positX: CGFloat!
        var height: CGFloat!
        if totalSize.height >= 890 {
            positX = -120
            height = 450
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -80
            height = 370
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -80
            height = 370
        } else if totalSize.height <= 670 {
            positX = -80
            height = 330
        } else {
            positX = -80
            height = 370
        }
        
        let img = UIImageView(image: #imageLiteral(resourceName: "bodyGuideBook"))
        
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 8
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.8
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
            positX = -350
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -330
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -330
        } else if totalSize.height <= 670 {
            positX = -300
        } else {
            positX = -330
        }
        
        let lbl = UILabel()
        lbl.text = "Это пособие подойдёт абсолютно любой женщине в разный возрастной период. Что нужно и важно знать? Согласно своей физиологии.".localized()
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
            make.width.equalTo(320)
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
        
        let img = UIImageView(image: #imageLiteral(resourceName: "previewBodyGuideTwo"))
        
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
            positX = -350
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -330
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -330
        } else if totalSize.height <= 670 {
            positX = -300
        } else {
            positX = -330
        }
        
        let lbl = UILabel()
        lbl.text = "Это пособие подойдёт абсолютно любой женщине в разный возрастной период. Что нужно и важно знать? Согласно своей физиологии.".localized()
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
        
        let img = UIImageView(image: #imageLiteral(resourceName: "previewBodyGuideTwo"))
        
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
            positX = -330
        } else if totalSize.height <= 670 {
            positX = -300
        } else {
            positX = -330
        }
        
        let lbl = UILabel()
        lbl.text = "В погоне за стандартными фигур и желанием в себе что-то поменять. Прибегают к самым абсурдным методам и способам, и забывают про здоровье.".localized()
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
        
        let img = UIImageView(image: #imageLiteral(resourceName: "previewBodyGuideThree"))
        
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
            positX = -330
        } else if totalSize.height <= 670 {
            positX = -300
        } else {
            positX = -330
        }
        
        let lbl = UILabel()
        lbl.text = "В погоне за стандартными фигур и желанием в себе что-то поменять. Прибегают к самым абсурдным методам и способам, и забывают про здоровье.".localized()
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
        
        let img = UIImageView(image: #imageLiteral(resourceName: "previewBodyGuideThree"))
        
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
            positX = -370
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -330
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -340
        } else if totalSize.height <= 670 {
            positX = -310
        } else {
            positX = -350
        }
        
        let lbl = UILabel()
        lbl.text = "В пособии вы узнаете и ключевые психологические особенности, и почему не получается добиться результата, в чем ошибки? И самое главное практические методы.".localized()
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
            make.width.equalTo(320)
        }
        
        return lbl
    }()
    
    lazy var imageFour: UIImageView = {
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
            positX = -100
            height = 370
        } else {
            positX = -140
            height = 480
        }
        
        let img = UIImageView(image: #imageLiteral(resourceName: "previewBodyGuideFour"))
        
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
            positX = -370
        } else  if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -330
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -340
        } else if totalSize.height <= 670 {
            positX = -310
        } else {
            positX = -350
        }
        
        let lbl = UILabel()
        lbl.text = "В пособии вы узнаете и ключевые психологические особенности, и почему не получается добиться результата, в чем ошибки? И самое главное практические методы.".localized()
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
            make.width.equalTo(320)
        }
        
        return lbl
    }()
    
    lazy var imageFourFake: UIImageView = {
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
            positX = -100
            height = 370
        } else {
            positX = -140
            height = 480
        }
        
        let img = UIImageView(image: #imageLiteral(resourceName: "previewBodyGuideFour"))
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
