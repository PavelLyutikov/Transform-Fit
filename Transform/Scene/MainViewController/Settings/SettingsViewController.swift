//
//  SettingsTableViewController.swift
//  Transform
//
//  Created by Pavel Lyutikov on 27.05.2021.
//

import UIKit
import SnapKit
import SafariServices
import MessageUI
import MailController

class SettingsViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    let totalSize = UIScreen.main.bounds.size

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        instagramButton.addTarget(self, action: #selector(instagramButtonAction(sender:)), for: .touchUpInside)
        mailButton.addTarget(self, action: #selector(mailButtonAction(sender:)), for: .touchUpInside)
        politicsButton.addTarget(self, action: #selector(politickButtonAction(sender:)), for: .touchUpInside)
        
        
        setNavBarToTheView()
        
        dismissButton.addTarget(self, action: #selector(buttonDismiss(sender:)), for: .touchUpInside)
    }
    
//MARK: - NavigationBar
    func setNavBarToTheView() {
        let positY: CGFloat!
        if totalSize.height >= 890 {
            positY = 40
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 40
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 20
        } else if totalSize.height <= 670 {
            positY = 20
        } else {
            positY = 40
        }
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0 + positY, width: self.view.frame.size.width, height: 64.0))
        navBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        navBar.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.view.addSubview(navBar)
        
        
        let navItem = UINavigationItem()
        navItem.title = "Контакты".localized()
        
        navBar.setItems([navItem], animated: true)
    }
    
//MARK: - InstagramButton
    lazy var instagramButton: UIButton = {
        let positX: CGFloat!
        let fontSize: CGFloat!
        let lead: CGFloat!
        let trail: CGFloat!
        let height: CGFloat!
        let left: CGFloat!
        if totalSize.height >= 920 {
            fontSize = 24
            positX = 150
            lead = 40
            trail = 60
            height = 75
            left = -260
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 23
            positX = 150
            lead = 40
            trail = 60
            height = 75
            left = -260
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 23
            positX = 150
            lead = 40
            trail = 60
            height = 70
            left = -240
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 23
            positX = 150
            lead = 40
            trail = 60
            height = 75
            left = -260
        } else if totalSize.height <= 670 {
            fontSize = 23
            positX = 150
            lead = 40
            trail = 60
            height = 65
            left = -225
        } else {
            fontSize = 21
            positX = 150
            lead = 40
            trail = 60
            height = 67
            left = -230
        }
        
        let btn = UIButton()
        btn.setTitle("@transform_shev", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: left, bottom: 0, right: 0)
//        btn.imageView?.contentMode = .scaleAspectFit
        btn.setImage(#imageLiteral(resourceName: "instagramButton"), for: .normal)
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.3
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positX)
            make.leading.equalToSuperview().inset(lead)
            make.trailing.equalToSuperview().inset(trail)
            make.height.equalTo(height)
        }
        
        return btn
    }()
    
    @objc func instagramButtonAction(sender: UIButton) {
        
        sender.zoomOut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        
            self.showSafariVC(for: "https://www.instagram.com/transform_shev/")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                sender.zoomOutClose()
            }
        }
    }
//MARK: - MailButton
    lazy var mailButton: UIButton = {
        let positX: CGFloat!
        let fontSize: CGFloat!
        let lead: CGFloat!
        let trail: CGFloat!
        let height: CGFloat!
        let left: CGFloat!
        if totalSize.height >= 920 {
            fontSize = 23
            positX = 250
            lead = 40
            trail = 60
            height = 75
            left = -250
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 22
            positX = 250
            lead = 40
            trail = 60
            height = 75
            left = -240
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 20
            positX = 250
            lead = 40
            trail = 60
            height = 70
            left = -230
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 22
            positX = 250
            lead = 40
            trail = 60
            height = 75
            left = -240
        } else if totalSize.height <= 670 {
            fontSize = 18
            positX = 250
            lead = 40
            trail = 60
            height = 65
            left = -215
        } else {
            fontSize = 18
            positX = 250
            lead = 40
            trail = 60
            height = 67
            left = -220
        }
        let btn = UIButton()
        btn.setTitle("savage.developer.team", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: left, bottom: 0, right: 0)
//        btn.imageView?.contentMode = .scaleAspectFit
        btn.setImage(#imageLiteral(resourceName: "mailButton"), for: .normal)
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.3
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positX)
            make.leading.equalToSuperview().inset(lead)
            make.trailing.equalToSuperview().inset(trail)
            make.height.equalTo(height)
        }
        
        return btn
    }()
    
    @objc func mailButtonAction(sender: UIButton) {
        sender.zoomOut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if let mailComposeViewController = MailController.shared.mailComposeViewController() {

                mailComposeViewController.setToRecipients(["savage.developer.team@gmail.com"])
                mailComposeViewController.setSubject("User Transform-Fit")
                mailComposeViewController.setMessageBody("Hello!", isHTML: false)

                self.present(mailComposeViewController, animated:true, completion:nil)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    sender.zoomOutClose()
                }
            } else {
                print("Mail services are not available")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                sender.zoomOutClose()
            }
            }
        }
    }
//MARK: - PoliticsButton
    lazy var politicsButton: UIButton = {
        let positX: CGFloat!
        let fontSize: CGFloat!
        let lead: CGFloat!
        let trail: CGFloat!
        let height: CGFloat!
        let left: CGFloat!
        if totalSize.height >= 920 {
            positX = 500
            lead = 40
            trail = 60
            height = 75
            left = -250
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positX = 500
            lead = 40
            trail = 60
            height = 75
            left = -240
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = 500
            lead = 40
            trail = 60
            height = 70
            left = -225
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = 500
            lead = 40
            trail = 60
            height = 75
            left = -240
        } else if totalSize.height <= 670 {
            positX = 500
            lead = 40
            trail = 60
            height = 67
            left = -215
        } else {
            positX = 500
            lead = 40
            trail = 60
            height = 67
            left = -215
        }
        
        switch Locale.current.languageCode {
        case "ru":
            if totalSize.height >= 920 {
                fontSize = 16
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                fontSize = 15
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                fontSize = 13.5
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                fontSize = 15
            } else if totalSize.height <= 670 {
                fontSize = 12.5
            } else {
                fontSize = 12.5
            }
        case "en":
            if totalSize.height >= 920 {
                fontSize = 23
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                fontSize = 22
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                fontSize = 20.5
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                fontSize = 22
            } else if totalSize.height <= 670 {
                fontSize = 19.5
            } else {
                fontSize = 19.5
            }
        default:
            if totalSize.height >= 920 {
                fontSize = 23
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                fontSize = 22
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                fontSize = 20.5
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                fontSize = 22
            } else if totalSize.height <= 670 {
                fontSize = 19.5
            } else {
                fontSize = 19.5
            }
        }
        let btn = UIButton()
        btn.setTitle("Политика конфиденциальности".localized(), for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: left, bottom: 0, right: 0)
//        btn.imageView?.contentMode = .scaleAspectFit
        btn.setImage(#imageLiteral(resourceName: "privacyPolicyButton"), for: .normal)
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.3
        btn.frame = CGRect(x: 0, y: 0, width: 100, height: 80)
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positX)
            make.leading.equalToSuperview().inset(lead)
            make.trailing.equalToSuperview().inset(trail)
            make.height.equalTo(height)
        }
        
        return btn
    }()
    
    @objc func politickButtonAction(sender: UIButton) {
        sender.zoomOut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.showSafariVC(for: "http://savage-developer-team.ru/transform-politics/")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                sender.zoomOutClose()
            }
        }
    }
    func mailComposeController(_controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {

            _controller.dismiss(animated: true, completion: nil)

    }
        
    func showSafariVC(for url: String) {
        guard let url = URL(string: url) else {
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
//MARK: Dismiss
    @objc lazy var dismissButton: UIButton = {
        let positX: CGFloat!
        let leidTrail: CGFloat!
        if totalSize.height >= 830 {
            positX = 45
            leidTrail = 15
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = 25
            leidTrail = 20
        } else if totalSize.height <= 670 {
            positX = 25
            leidTrail = 10
        } else {
            positX = 45
            leidTrail = 15
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "closeBlack"), for: .normal)
        btn.layer.zPosition = 6
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positX)
            make.trailing.equalToSuperview().inset(leidTrail)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        return btn
    }()
    @objc func buttonDismiss(sender: UIButton) {

        let vc = MainViewController()
        vc.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: false, completion: nil)
    }
}
