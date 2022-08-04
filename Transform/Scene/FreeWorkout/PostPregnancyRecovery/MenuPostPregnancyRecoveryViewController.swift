//
//  MenuPostPregnancyRecoveryViewController.swift
//  Transform
//
//  Created by Pavel Lyutikov on 03.06.2021.
//

import UIKit
import EGOCircleMenu
import SnapKit

class MenuPostPregnancyRecoveryViewController: UIViewController, CircleMenuDelegate {

    let totalSize = UIScreen.main.bounds.size
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    var icons = [String]()
    let submenuIds = [2]
    let showItemSegueId = "showItem"
    var selectedItemId: Int?
    
    //ironSource
    var bannerView: ISBannerView! = nil
    let kAPPKEY = "11dfcc91d"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        setupUI()
        
        infoButton.addTarget(self, action: #selector(buttonInfoAction(sender:)), for: .touchUpInside)
        
        setupScrollView()
        setupViews()
        
        //Ads
        if !UserDefaults.standard.bool(forKey: "removeAdsPurchased") {
            setupIronSourceSdk()
            loadBanner()
        }
        
        setupCircleMenu()
        
        //Notification
        NotificationCenter.default.addObserver(self, selector: #selector(MenuPostPregnancyRecoveryViewController.rotateCircleMenuLeft), name: NSNotification.Name(rawValue: "rotateCircleMenuLeft"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MenuPostPregnancyRecoveryViewController.rotateCircleMenuRight), name: NSNotification.Name(rawValue: "rotateCircleMenuRight"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MenuPostPregnancyRecoveryViewController.openCircleMenu), name: NSNotification.Name(rawValue: "openCircleMenu"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MenuPostPregnancyRecoveryViewController.closeCircleMenu), name: NSNotification.Name(rawValue: "closeCircleMenu"), object: nil)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    func setupUI() {
        imageRecoveryBackground.isHidden = false
        
        buttonLigtnSection.addTarget(self, action: #selector(actionButtonLightSection(sender:)), for: .touchUpInside)
        buttonMidleSection.addTarget(self, action: #selector(actionButtonMidleSection(sender:)), for: .touchUpInside)
        buttonHardSection.addTarget(self, action: #selector(actionButtonHardSection(sender:)), for: .touchUpInside)
        favoritesButton.addTarget(self, action: #selector(favoritesButtonAction(sender:)), for: .touchUpInside)
    }
//MARK: - IronSource
    func loadBanner() {
        let BNSize: ISBannerSize = ISBannerSize(description: "BANNER", width: Int(self.view.frame.size.width), height: 50)
           IronSource.loadBanner(with: self, size: BNSize)
        UserDefaults.standard.set(true, forKey: "bannerLoaded")
    }
    func setupIronSourceSdk() {
        ISIntegrationHelper.validateIntegration()
        

//        IronSource.setRewardedVideoDelegate(self)
//        IronSource.setOfferwallDelegate(self)
//        IronSource.setInterstitialDelegate(self)
        IronSource.setBannerDelegate(self)
        IronSource.add(self)
        
    
        
        IronSource.initWithAppKey(kAPPKEY)
        
        // To initialize specific ad units:
//        IronSource.initWithAppKey(kAPPKEY, adUnits:[IS_REWARDED_VIDEO,IS_INTERSTITIAL,IS_OFFERWALL,IS_BANNER])
    }
    func logFunctionName(string: String = #function) {
        print("IronSource Swift Demo App:"+string)
    }
    func destroyBanner() {
        if bannerView != nil {
            IronSource.destroyBanner(bannerView)
        }
    }
//MARK: - FavoritesButton
    @objc lazy var favoritesButton: UIButton = {
        let positX: CGFloat!
        let leidTrail: CGFloat!
        if totalSize.height >= 920 {
            positX = 80
            leidTrail = 30
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positX = 80
            leidTrail = 30
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = 80
            leidTrail = 30
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = 50
            leidTrail = 20
        } else if totalSize.height <= 670 {
            positX = 50
            leidTrail = 20
        } else {
            positX = 70
            leidTrail = 25
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "heartPostPregnancyRecovery"), for: .normal)
        btn.layer.zPosition = 6
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positX)
            make.trailing.equalToSuperview().inset(leidTrail)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        return btn
    }()
    
    @objc func favoritesButtonAction(sender: UIButton) {
        
        destroyBanner()
        sender.zoomOut()
        
        if !UserDefaults.standard.bool(forKey: "isFirstLaunchFavoritePostPregnancyRecovery") {
            
                let vc = PreviewChosenRecoveryViewController()
                vc.modalPresentationStyle = .fullScreen
                
                let transition = CATransition()
                transition.duration = 0.4
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(vc, animated: false, completion: nil)
            
           } else {
            
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ChosenPostPregnancyRecoveryTableViewController")

                viewController.modalPresentationStyle = .fullScreen

                let transition = CATransition()
                transition.duration = 0.4
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
                self.view.window!.layer.add(transition, forKey: kCATransition)

                self.present(viewController, animated: false, completion: nil)
                }
           }
           UserDefaults.standard.set(true, forKey: "isFirstLaunchFavoritePostPregnancyRecovery")
    
    }
//MARK: ScrollInfo
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let positTop: CGFloat!
        let positBttm: CGFloat!
        if totalSize.height >= 920 {
            positTop = 188
            positBttm = -188
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positTop = 183
            positBttm = -183
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positTop = 174
            positBttm = -174
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positTop = 120
            positBttm = -120
        } else if totalSize.height <= 670 {
            positTop = 110
            positBttm = -110
        } else {
            positTop = 169
            positBttm = -169
        }
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: positTop).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: positBttm).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: positTop).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: positBttm).isActive = true
        
        scrollView.layer.zPosition = 9
        scrollView.isHidden = true
        
        }
    func setupViews(){
        contentView.addSubview(labelRecoveryInfo)
        
        let wdth: CGFloat!
        let positTop: CGFloat!
        let positBttm: CGFloat!
        if totalSize.height >= 890 {
            wdth = 3.5/4
            positTop = -120
            positBttm = 180
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 3.5/4
            positTop = -140
            positBttm = 180
        } else if totalSize.height <= 800 {
            wdth = 3.2/4
            positTop = -60
            positBttm = 180
        } else {
            wdth = 3.5/4
            positTop = -100
            positBttm = 180
        }
        
        labelRecoveryInfo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        labelRecoveryInfo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: positTop).isActive = true
        labelRecoveryInfo.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: wdth).isActive = true
            
        
        
        contentView.addSubview(labelEnd)
        labelEnd.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        labelEnd.topAnchor.constraint(equalTo: labelRecoveryInfo.bottomAnchor, constant: 25).isActive = true
        labelEnd.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        labelEnd.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: positBttm).isActive = true
        
        labelRecoveryInfo.isHidden = true
    }
    
    let labelEnd: UILabel = {
        let label = UILabel()
        label.text = "\n \n"
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var labelRecoveryInfo: UILabel = {
        let fnt: CGFloat!
        if totalSize.height >= 890 {
            fnt = 22
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fnt = 20
        } else if totalSize.height <= 800 {
            fnt = 18
        } else {
            fnt = 18
        }
        
       let label = UILabel()
        label.text = """
            Планируете снова начать заниматься спортом после родов? Хотите сбросить набранный во время беременности вес, убрать послеродовой живот или вернуться в свою дородовую форму?

            В этом разделе рекомендованы самые эффективные упражнения для восстановления после родов для разного этапа восстановления, а так же упражнения, которые безопасно можно выполнять во время беременности.

            Данные упражнения помогут укрепить мышцы спины, пресса, мышцы тазового дна. Упражнения направленны на улучшение функций пресса с помощью трех методов: дыхание, активация и сокращения мышц пресса, которые можно и нужно выполнять при диастазе.

            В этом разделе упражнения разделены на три этапа вашего послеродового восстановления:
            сразу после родов, после прохождения начальных упражнений и после восстановления функционирования  тела.

            Важно:
                   - Это индивидуальный процесс. Учитывайте индивидуальные задачи, наличие заболеваний или осложнений;
            - Не стоит спешить, чтобы быстрее восстановиться. Поначалу вы сможете выполнять упражнения в течение пары минут за один раз. Затем объем тренировок может быть средней интенсивности до 20–30 минут в день 5-6 дней в неделю. Не ставьте себе задачу как можно быстрее вернуться к добеременной форме. Долгосрочные цели важнее быстрых результатов;
            - Ориентируйтесь на свой личный уровень физической подготовки. Учитывайте, занимались ли вы спортом до беременности и во время нее. Если раньше вы спортом не занимались, нужно подходить к этому особенно осторожно и крайне медленно увеличивать продолжительность или интенсивность тренировок;
            - Кормящим мамам нужно подходить к спорту с особой осторожностью. Пейте достаточное количество  воды, питайтесь правильно и тренируйтесь в среднем темпе, чтобы не устать. Рекомендуется покормить ребенка перед занятиями, а на тренировку надеть поддерживающий бюстгальтер, чтобы в груди не возникало неприятных ощущений;
            - Если у вас недавно было кесарево, не стоит поднимать тяжести. Лучше всего проконсультироваться с врачом. Как правило, специалисты советуют не поднимать ничего тяжелее ребенка в течение первых шести-восьми месяцев после родов;
            - Лучше закрепить за тренировками определенное время. Мамы обычно ставят на первое место семейные дела, но нельзя забывать, что спорт после родов очень важен для здоровья и хорошего самочувствия. Рекомендуется выделить постоянное время для тренировок, чтобы в суматохе дел о них не забывать.


            Польза:
            - Улучшение самочувствия;
            - Прилив энергии;
            - Снижение веса,
            - Улучшение аэробной выносливости;
            - Подтянутый пресс;
            - Уменьшение проявлений послеродовой депрессии и тревожности;
            - Улучшение качества сна.


            ЧАСТО ЗАДАВАЕМЫЕ ВОПРОСЫ:
             Когда можно начинать заниматься спортом после родов?
             - В случае естественных родов без осложнений, рекомендуется делать легкие упражнения уже через пару дней. Если у вас было кесарево сечение или осложнения, следует подождать 4-6 недель. Проконсультируйтесь с врачом, какой вариант подойдет в вашем случае.
             Можно ли заниматься спортом при грудном вскармливании?
             - Можно. Рекомендовано пить побольше воды, чаще отдыхать и полноценно питаться для восполнения энергии.  Что делать, если у меня диастаз прямой мышцы живота?
             - Важно уделять внимание укреплению поперечной мышцы живота, работать с дыханием, налаживать чувствительность. Исключать упражнения с сильным натуживанием, обычными скручиваниями, упражнениям с 4-мя точками опоры.

            Можно ли заниматься беременным?

            - Если у Вас нет противопоказаний, да.


            Поддержание и работа поперечной мышцы живота во время беременности помогает правильно носить ребенка, избегая при этом таких симптомов, как боль в пояснице, обычно связанная с беременностью. Это поможет вам быстрее восстановиться после родов.

            Во время беременности и родов организм женщины проходит через множество трансформаций. Необходимо дать время на физическое и психическое восстановление. Если вы готовы вернуться к занятиям спортом после родов, не спешите и получайте удовольствие от процесса.


            Отказ от ответственности: Обратите внимание, что каждый этап упражнений, перечисленный далее, подходит для разного этапа вашего послеродового восстановления. Если вы испытываете боль в спине или тазовом дне после родов, проконсультируйтесь со своим врачом или физиотерапевтом тазового дна.
            """.localized()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.textAlignment = .natural
        label.font = UIFont.systemFont(ofSize: fnt)
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
//MARK: InfoButton
        @objc lazy var infoButton: UIButton = {
            let positX: CGFloat!
            let leidTrail: CGFloat!
            if totalSize.height >= 920 {
                positX = 80
                leidTrail = 110
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                positX = 80
                leidTrail = 110
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                positX = 80
                leidTrail = 110
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                positX = 50
                leidTrail = 100
            } else if totalSize.height <= 670 {
                positX = 50
                leidTrail = 100
            } else {
                positX = 70
                leidTrail = 100
            }
            let btn = UIButton()
            btn.setImage(#imageLiteral(resourceName: "informationPostPregnancyRecovery"), for: .normal)
            btn.layer.zPosition = 4
            btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            btn.layer.shadowRadius = 3
            btn.layer.shadowOffset = CGSize(width: 0, height: 0)
            btn.layer.shadowOpacity = 0.4
            btn.adjustsImageWhenHighlighted = false
            self.view.addSubview(btn)

            btn.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(leidTrail)
                make.top.equalToSuperview().inset(positX)
                make.height.equalTo(40)
                make.width.equalTo(40)
            }
            
            return btn
        }()
        @objc func buttonInfoAction(sender: UIButton) {
            backgroundInfo.isHidden = false
            backgroundInfo.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            UIView.animate(withDuration: 0.4) {
                self.backgroundInfo.transform = CGAffineTransform.identity
                self.backgroundInfo.alpha = 1
            }

            scrollView.isHidden = false
            labelRecoveryInfo.isHidden = false
            labelRecoveryInfo.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            UIView.animate(withDuration: 0.4) {
                self.labelRecoveryInfo.transform = CGAffineTransform.identity
                self.labelRecoveryInfo.alpha = 1
            }

            infoButton.isHidden = true

            closeInfoButton.isHidden = false

            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
                self.closeInfoButton.zoomInInfo()
            }

            closeInfoButton.addTarget(self, action: #selector(buttonCloseInfoAction(sender:)), for: .touchUpInside)
            
            
        }
//MARK: CloseInfoButton
        @objc lazy var closeInfoButton: UIButton = {
            let trail: CGFloat!
            let positTop: CGFloat!
            if totalSize.height >= 920 {
                trail = 30
                positTop = 205
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                trail = 30
                positTop = 200
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                trail = 30
                positTop = 190
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                trail = 40
                positTop = 135
            } else if totalSize.height <= 670 {
                trail = 40
                positTop = 125
            } else {
                trail = 30
                positTop = 180
            }
            let btn = UIButton()
            btn.setImage(#imageLiteral(resourceName: "cancelWhite"), for: .normal)
            btn.layer.zPosition = 10
            self.view.addSubview(btn)

            btn.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(trail)
                make.top.equalToSuperview().inset(positTop)
                make.height.equalTo(30)
                make.width.equalTo(30)
            }
            
            return btn
        }()
        @objc func buttonCloseInfoAction(sender: UIButton) {
            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                self.backgroundInfo.isHidden = true
            }
            backgroundInfo.zoomOutInfo()
            
            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                self.labelRecoveryInfo.isHidden = true
                self.scrollView.isHidden = true
            }
            labelRecoveryInfo.zoomOutInfo()
            
            closeInfoButton.zoomOutInfo()
            
            self.closeInfoButton.isHidden = true
            
            infoButton.isHidden = false
        }
//MARK: - BackgroundInfo
    lazy var backgroundInfo: UIImageView = {
        let leadtTrail: CGFloat!
        if totalSize.height >= 830 {
            leadtTrail = 10
        } else if totalSize.height <= 800 {
            leadtTrail = 20
        } else {
            leadtTrail = 10
        }
        var image = UIImageView(image: #imageLiteral(resourceName: "infoBackgroundRecovery"))
//        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.layer.zPosition = 8
        image.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        image.layer.shadowRadius = 50
        image.layer.shadowOffset = CGSize(width: 0, height: 0)
        image.layer.shadowOpacity = 0.8
        self.view.addSubview(image)
        
        image.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(leadtTrail)
//            make.width.equalTo(450)
//            make.height.equalTo(950)
        }
        return image
    }()
//MARK: - ButtonChoiceSection
    lazy var buttonLigtnSection: UIButton = {
        let positTop: CGFloat!
        if totalSize.height >= 920 {
            positTop = 200
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positTop = 200
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positTop = 200
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positTop = 140
        } else if totalSize.height <= 670 {
            positTop = 120
        } else {
            positTop = 180
        }
        
        let btn = UIButton()
        btn.setTitle("Ligth", for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.9129461646, green: 0.7716093063, blue: 0.7911036611, alpha: 1)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 28)
        btn.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        btn.titleLabel?.textAlignment = .center
        btn.layer.cornerRadius = 10
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positTop)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(80)
        }
        
        return btn
    }()
    @objc func actionButtonLightSection(sender: UIButton) {
        UserDefaults.standard.set(1, forKey: "choiceSection")
        
        destroyBanner()
        sender.zoomOut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "PostPregnancyRecoveryTableViewController")

        viewController.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
            self.view.window!.layer.add(transition, forKey: kCATransition)

            self.present(viewController, animated: false, completion: nil)
        }
    }
    lazy var buttonMidleSection: UIButton = {
        let positTop: CGFloat!
        if totalSize.height >= 920 {
            positTop = 400
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positTop = 400
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positTop = 400
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positTop = 300
        } else if totalSize.height <= 670 {
            positTop = 280
        } else {
            positTop = 380
        }
        
        let btn = UIButton()
        btn.setTitle("Midle", for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.89165662, green: 0.626505068, blue: 0.6593458906, alpha: 1)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 28)
        btn.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        btn.titleLabel?.textAlignment = .center
        btn.layer.cornerRadius = 10
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positTop)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(80)
        }
        
        return btn
    }()
    @objc func actionButtonMidleSection(sender: UIButton) {
        UserDefaults.standard.set(2, forKey: "choiceSection")
        
        destroyBanner()
        sender.zoomOut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "PostPregnancyRecoveryTableViewController")

        viewController.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
            self.view.window!.layer.add(transition, forKey: kCATransition)

            self.present(viewController, animated: false, completion: nil)
        }
    }
    lazy var buttonHardSection: UIButton = {
        let positTop: CGFloat!
        if totalSize.height >= 920 {
            positTop = 600
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positTop = 600
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positTop = 600
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positTop = 460
        } else if totalSize.height <= 670 {
            positTop = 440
        } else {
            positTop = 580
        }
        
        let btn = UIButton()
        btn.setTitle("Hard", for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.7890952229, green: 0.5551275015, blue: 0.5862262249, alpha: 1)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 28)
        btn.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        btn.titleLabel?.textAlignment = .center
        btn.layer.cornerRadius = 10
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positTop)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(80)
        }
        
        return btn
    }()
    @objc func actionButtonHardSection(sender: UIButton) {
        UserDefaults.standard.set(3, forKey: "choiceSection")
        
        destroyBanner()
        sender.zoomOut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "PostPregnancyRecoveryTableViewController")

        viewController.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
            self.view.window!.layer.add(transition, forKey: kCATransition)

            self.present(viewController, animated: false, completion: nil)
        }
    }
//MARK: - BackgroundImage
    lazy var imageRecoveryBackground: UIImageView = {
        let lead: CGFloat!
        let height: CGFloat!
        if totalSize.height >= 920 {
            lead = -430
            height = 800
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            lead = -430
            height = 800
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            lead = -440
            height = 750
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            lead = -450
            height = 670
        } else if totalSize.height <= 670 {
            lead = -460
            height = 600
        } else {
            lead = -440
            height = 700
        }
        
        let img = UIImageView(image: #imageLiteral(resourceName: "recoveryMenuImage"))
        img.contentMode = .scaleAspectFit
        img.alpha = 0.4
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 5
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.5
        self.view.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(lead)
            make.bottom.equalToSuperview().inset(0)
            make.height.equalTo(height)
        }
        
        return img
    }()
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
                self.labelCircleMenuMoveRight.text = "Таймер".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 4 {
                self.labelCircleMenuMoveRight.text = "Body Guide"
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 5 {
                self.labelCircleMenuMoveRight.text = "Комплексы тренировок".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 6 {
                self.labelCircleMenuMoveRight.text = "Рационы питания и Калькулятор".localized()
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
                self.labelCircleMenuMoveRight.text = "Таймер".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 4 {
                self.labelCircleMenuMoveRight.text = "Body Guide"
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 5 {
                self.labelCircleMenuMoveRight.text = "Комплексы тренировок".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 6 {
                self.labelCircleMenuMoveRight.text = "Рационы питания и Калькулятор".localized()
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
        icons.append(contentsOf: ["home", "stretching", "yoga", "dumbbell","stopwatch","bodyGuideIcon", "complexIcon", "foodRationIcon", "icTimer", "icVideo", "home", "icHDR"])
        
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
        
        destroyBanner()
        
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
                    transition.subtype = CATransitionSubtype.fromRight
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
                transition.subtype = CATransitionSubtype.fromRight
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
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(vc, animated: false, completion: nil)
               }
               UserDefaults.standard.set(true, forKey: "isFirstLaunchHomeWorkout")
        } else if id == 4 {
            if !UserDefaults.standard.bool(forKey: "isFirstLaunchTimerController") {
                    
                    let vc = PreviewTimerViewController()
                    vc.modalPresentationStyle = .fullScreen
                    
                    let transition = CATransition()
                    transition.duration = 0.4
                    transition.type = CATransitionType.push
                    transition.subtype = CATransitionSubtype.fromRight
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
                transition.subtype = CATransitionSubtype.fromRight
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
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(vc, animated: false, completion: nil)
            }
            UserDefaults.standard.set(true, forKey: "isFirstLaunchTrainingComplex")
        } else if id == 7 {
            if !UserDefaults.standard.bool(forKey: "isFirstLaunchFoodRation") {
                let vc = PreviewFoodRationViewController()
                vc.modalPresentationStyle = .fullScreen

                let transition = CATransition()
                transition.duration = 0.4
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(vc, animated: false, completion: nil)
                
            } else {
                
                let vc = MenuFoodRationViewController()
                vc.modalPresentationStyle = .fullScreen

                let transition = CATransition()
                transition.duration = 0.4
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(vc, animated: false, completion: nil)
            }
            UserDefaults.standard.set(true, forKey: "isFirstLaunchFoodRation")
        }
    }
    
    private func createCircleMenuItems(count: Int) -> [CircleMenuItemModel] {
        var menuModels = [CircleMenuItemModel]()
        for i in 0..<count {
            let menuModel = CircleMenuItemModel(id: i, imageSource: UIImage.init(named: icons[i]))
            menuModels.append(menuModel)
        }
        return menuModels
    }
}

//MARK: - ExtensionIronSource
extension MenuPostPregnancyRecoveryViewController: ISBannerDelegate, ISImpressionDataDelegate {
    
    func bannerDidLoad(_ bannerView: ISBannerView!) {
        self.bannerView = bannerView
        if #available(iOS 11.0, *) {
               
            if totalSize.height >= 801 {
                bannerView.frame = CGRect(x: 0, y: view.frame.size.height - 50, width: view.frame.size.width, height: 0)
                
            } else if totalSize.height <= 800 {
                bannerView.frame = CGRect(x: 0, y: view.frame.size.height - 50, width: view.frame.size.width, height: 0)
            }
        } else {
                bannerView.frame = CGRect(x: 0, y: view.frame.size.height - 50, width: view.frame.size.width, height: 0)
        }


        bannerView.backgroundColor = .clear
        bannerView.layer.zPosition = 100
        view.addSubview(bannerView)
        
        logFunctionName()
    }
    
    func bannerDidShow() {
        logFunctionName()
    }
    
    func bannerDidFailToLoadWithError(_ error: Error!) {
        logFunctionName(string: #function+String(describing: Error.self))

    }
    
    func didClickBanner() {
        logFunctionName()
    }
    
    func bannerWillPresentScreen() {
        logFunctionName()
    }
    
    func bannerDidDismissScreen() {
        logFunctionName()
    }
    
    func bannerWillLeaveApplication() {
        logFunctionName()
    }
    func impressionDataDidSucceed(_ impressionData: ISImpressionData!) {
        logFunctionName(string: #function+String(describing: impressionData))

    }
}
