//
//  YogaMenuViewController.swift
//  Transform
//
//  Created by Pavel Lyutikov on 10.03.2021.
//

import UIKit
import SnapKit
import EGOCircleMenu

class YogaMenuViewController: UIViewController, CircleMenuDelegate {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let totalSize = UIScreen.main.bounds.size
    
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
        backgroundImage.isHidden = false
        
        buttonList1_9.addTarget(self, action: #selector(buttonList1_9Action(sender:)), for: .touchUpInside)
        buttonList10_19.addTarget(self, action: #selector(buttonList10_19Action(sender:)), for: .touchUpInside)
        buttonList20_29.addTarget(self, action: #selector(buttonList20_29Action(sender:)), for: .touchUpInside)
        buttonList30_38.addTarget(self, action: #selector(buttonList30_38Action(sender:)), for: .touchUpInside)
        favoritesButton.addTarget(self, action: #selector(favoritesButtonAction(sender:)), for: .touchUpInside)
        
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
        NotificationCenter.default.addObserver(self, selector: #selector(YogaMenuViewController.rotateCircleMenuLeft), name: NSNotification.Name(rawValue: "rotateCircleMenuLeft"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(YogaMenuViewController.rotateCircleMenuRight), name: NSNotification.Name(rawValue: "rotateCircleMenuRight"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(YogaMenuViewController.openCircleMenu), name: NSNotification.Name(rawValue: "openCircleMenu"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(YogaMenuViewController.closeCircleMenu), name: NSNotification.Name(rawValue: "closeCircleMenu"), object: nil)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
//MARK: - IronSource
    func loadBanner() {
        let BNSize: ISBannerSize = ISBannerSize(description: "BANNER", width: Int(self.view.frame.size.width), height: 50)
           IronSource.loadBanner(with: self, size: BNSize)
        UserDefaults.standard.set(true, forKey: "bannerLoaded")
    }
    func setupIronSourceSdk() {

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
    
    func setupUI() {
        backgoundImageLotusShadow.isHidden = false
        backgoundImageLotus.isHidden = false
        mainTitle.isHidden = false
        subTitle.isHidden = false
    }
//MARK: - RewardVideo
    func showRewardVideo() {
        
    }
//MARK: - FavoritesButton
    @objc lazy var favoritesButton: UIButton = {
        let positX: CGFloat!
        let leidTrail: CGFloat!
        if totalSize.height >= 830 {
            positX = 180
            leidTrail = 30
        } else if totalSize.height == 812 {
            positX = 180
            leidTrail = 30
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = 120
            leidTrail = 30
        } else if totalSize.height <= 670 {
            positX = 100
            leidTrail = 30
        } else {
            positX = 180
            leidTrail = 30
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "heartYoga"), for: .normal)
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
        
        sender.zoomOut()
        
        if !UserDefaults.standard.bool(forKey: "isFirstLaunchFavoriteYoga") {
            
                destroyBanner()
            
                let vc = PreviewChosenYogaViewController()
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
                    
                self.destroyBanner()
                    
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ChosenYogaTableViewController")

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
           UserDefaults.standard.set(true, forKey: "isFirstLaunchFavoriteYoga")
    }
//MARK: BackgroundImage
    lazy var backgroundImage: UIImageView = {
        var image = UIImageView(image: #imageLiteral(resourceName: "backgroundYogaMenu"))
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.layer.zPosition = 0
        image.alpha = 0.1
        self.view.addSubview(image)


        image.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(0)
            make.centerX.equalToSuperview()
            make.height.equalTo(700)
//            make.leading.trailing.equalToSuperview().inset(-20)
    }
        return image
    }()
//MARK: MainTitle
    lazy var mainTitle: UILabel = {
        
        let positX: CGFloat!
        if totalSize.height >= 920 {
            positX = 160
        } else if totalSize.height >= 830 && totalSize.height <= 919 {
            positX = 150
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = 70
        } else if totalSize.height <= 670 {
            positX = 50
        } else {
            positX = 150
        }
       let label = UILabel()
        label.text = "Hatha"
        label.textColor = #colorLiteral(red: 0.8359088302, green: 0.3050788045, blue: 0.3091535568, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 60)
        label.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.layer.shadowRadius = 5
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowOpacity = 0.3
        self.view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positX)
            make.centerX.equalToSuperview()
        }
        return label
    }()
    lazy var subTitle: UILabel = {
        
        let positX: CGFloat!
        if totalSize.height >= 920 {
            positX = 220
        } else if totalSize.height >= 830 && totalSize.height <= 919 {
            positX = 210
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = 130
        } else if totalSize.height <= 670 {
            positX = 110
        } else {
            positX = 210
        }
        
       let label = UILabel()
        label.text = "YOGA"
        label.textColor = #colorLiteral(red: 0.9014314413, green: 0.5729121167, blue: 0.5374045745, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 40)
        label.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.layer.shadowRadius = 5
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowOpacity = 0.3
        self.view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positX)
            make.centerX.equalToSuperview()
        }
        return label
    }()
    
//MARK: ScrollInfo
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let positTop: CGFloat!
        let positBttm: CGFloat!
        if totalSize.height >= 830 {
            positTop = 100
            positBttm = -100
        } else if totalSize.height <= 800 {
            positTop = 40
            positBttm = -37
        } else {
            positTop = 100
            positBttm = -100
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
        contentView.addSubview(labelYogaInfo)
        
        let wdth: CGFloat!
        let positTop: CGFloat!
        let positBttm: CGFloat!
        if totalSize.height >= 890 {
            wdth = 3.5/4
            positTop = -60
            positBttm = -180
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 3.5/4
            positTop = -40
            positBttm = -180
        } else if totalSize.height <= 800 {
            wdth = 3.2/4
            positTop = 0
            positBttm = -180
        } else {
            wdth = 3.5/4
            positTop = -60
            positBttm = -180
        }
        
        labelYogaInfo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        labelYogaInfo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: positTop).isActive = true
        labelYogaInfo.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: wdth).isActive = true
            
        
        
        contentView.addSubview(labelEnd)
        labelEnd.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        labelEnd.topAnchor.constraint(equalTo: labelYogaInfo.bottomAnchor, constant: 25).isActive = true
        labelEnd.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        labelEnd.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: positBttm).isActive = true
        
        labelYogaInfo.isHidden = true
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

    lazy var labelYogaInfo: UILabel = {
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
            В данном случае мы приводим примеры базовых асан, которые подойдут как для начинающих, так и для продолжающих. Составляя их в подходящей вам последовательности  вы сможете подобрать небольшие разминки или полноценные комплексы йоги.

            Хатха-йога - значение:

            Если обращаться к прямому значению, то слово «хатха» имеет два корня: «ха», что означает ум, ментальная энергия и «тха» - прана, жизненная энергия. Таким образом Хатха – это объединение ментальных сил и жизненной энергии. При этом традиционно слово переводится, как «средство для достижения силы посредством йоги».

            Плюсы йоги:

            -Йогу называют уникальной системой оздоровления организма. Она позволяет найти внутреннюю гармонию и улучшить работу всех органов. Философия йоги помогает избавиться от вредных привычек и приобщиться к здоровому образу жизни;
            -Гармония с окружающим миром. Избавление от стрессов и негативных переживаний. Йога позволяет окунуться в свой внутренний мир и лучше себя узнать. Упражнения направлены на раскрытие;
            -Избавление от болей в спине и суставах. В йоге есть целый комплекс упражнений, оказывающий расслабляющее и тонизирующее действие на наш организм;
            -Улучшение осанки. Занятие йогой оказывает укрепляющее действие на мышечный корсет. Улучшается осанка, походка становится более уверенной;
            -В йоге существуют специальные упражнения, направленные на улучшение работы ЖКТ.
            -Выполнение упражнений активизирует циркуляцию лимфы, восстанавливает внутренний баланс органов и улучшает сопротивляемость организма инфекциям и бактериям;
            -Упражнения способствуют улучшению кровотока и обогащают мозг кислородом;
            -Возраст не имеет значения. Заниматься йогой можно в любом возрасте, независимо от уровня физической подготовки;
            -Время и место не имеют значение. Занятия йогой не требуют определенного оборудования.

            Противопоказания:

            Возможность появления травм и обострения старых болезней – неправильная практика, грозит не только обычными травмами (растяжения, вывихи и т.п), но и развитием хронических болезней внутренних органов и опорно-двигательного аппарата. Поэтому практику нужно выполнять корректно.
            
            Существуют ряд противопоказаний к каждой асане, а также противопоказания к практики в целом, а именно:
            -заболевания внутренних органов в острой стадии (аппендицит, панкреатит и.т.д.);
            -заболевания крови;
            -нарушения в работе сердечно-сосудистой системы;
            -онкологические заболевания;
            -паховая грыжа;
            -первые шесть месяцев после инфаркта или инсульта;
            -инфекции в головном или спинном мозге;
            -повышенное давление или температура тела;
            -серьезные расстройства психики (шизофрения);
            -ОРВИ, грипп, ангина;
            -проблемы со спиной.

            Классической йогой нельзя заниматься беременным женщинам, у которых срок больше трех месяцев и в течение четырех месяцев после родов. Но можно заниматься йогой для беременных.

            Йога не фитнес и не спорт, ей невозможно заниматься факультативно, это не только комплекс упражнений. Это, прежде всего, особая философия, которая меняет мировоззрение, ведет к изменению стиля поведения, изменяет привычки, проникает во все сферы жизни.
            """.localized()
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
            if totalSize.height >= 830 {
                positX = 100
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                positX = 50
            } else if totalSize.height <= 670 {
                positX = 30
            } else {
                positX = 100
            }
            let btn = UIButton()
            btn.setImage(#imageLiteral(resourceName: "informationYoga"), for: .normal)
            btn.layer.zPosition = 4
            btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            btn.layer.shadowRadius = 3
            btn.layer.shadowOffset = CGSize(width: 0, height: 0)
            btn.layer.shadowOpacity = 0.4
            btn.adjustsImageWhenHighlighted = false
            self.view.addSubview(btn)

            btn.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(30)
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
            labelYogaInfo.isHidden = false
            labelYogaInfo.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            UIView.animate(withDuration: 0.4) {
                self.labelYogaInfo.transform = CGAffineTransform.identity
                self.labelYogaInfo.alpha = 1
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
            if totalSize.height >= 830 {
                trail = 30
                positTop = 115
            } else if totalSize.height <= 800 {
                trail = 40
                positTop = 50
            } else {
                trail = 30
                positTop = 110
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
                self.labelYogaInfo.isHidden = true
                self.scrollView.isHidden = true
            }
            labelYogaInfo.zoomOutInfo()
            
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
        var image = UIImageView(image: #imageLiteral(resourceName: "infoBackgroundRed"))
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
        }
        return image
    }()
//MARK: - BackgroundImage
    lazy var backgoundImageLotus: UIImageView = {
        let positX: CGFloat!
        let leidTrail: CGFloat!
        if totalSize.height >= 830 {
            positX = 0
            leidTrail = 20
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -23
            leidTrail = 30
        } else if totalSize.height <= 670 {
            positX = -45
            leidTrail = 30
        } else {
            positX = -20
            leidTrail = 20
        }
       var image = UIImageView(image: #imageLiteral(resourceName: "lotus"))
        image.contentMode = .scaleAspectFit
        image.alpha = 0.7
        image.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        image.layer.shadowRadius = 8
        image.layer.shadowOffset = CGSize(width: 0, height: 0)
        image.layer.shadowOpacity = 0.5
        self.view.addSubview(image)
        
        image.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().inset(positX)
            make.leading.trailing.equalToSuperview().inset(leidTrail)
        }
        return image
    }()
    lazy var backgoundImageLotusShadow: UIImageView = {
        let positX: CGFloat!
        let leidTrail: CGFloat!
        if totalSize.height >= 920 {
            positX = -240
            leidTrail = 20
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positX = -230
            leidTrail = 20
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -215
            leidTrail = 20
        } else if totalSize.height <= 800 {
            positX = -240
            leidTrail = 30
        } else {
            positX = -230
            leidTrail = 20
        }
       var image = UIImageView(image: #imageLiteral(resourceName: "lotusShadow"))
        image.contentMode = .scaleAspectFit
        image.alpha = 0.3
        image.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        image.layer.shadowRadius = 8
        image.layer.shadowOffset = CGSize(width: 0, height: 0)
        image.layer.shadowOpacity = 0.5
        self.view.addSubview(image)

        image.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().inset(positX)
            make.leading.trailing.equalToSuperview().inset(leidTrail)
        }
        return image
    }()
//MARK: - ButtonMenu
    //list1_19
    @objc lazy var buttonList1_9: UIButton = {
        let positX: CGFloat!
        let fontSize: CGFloat!
        let leadTrail: CGFloat!
        if totalSize.height >= 920 {
            fontSize = 24
            positX = 490
            leadTrail = 90
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 25
            positX = 460
            leadTrail = 90
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 23
            positX = 450
            leadTrail = 85
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 23
            positX = 420
            leadTrail = 90
        } else if totalSize.height <= 670 {
            fontSize = 23
            positX = 400
            leadTrail = 85
        } else {
            fontSize = 23
            positX = 450
            leadTrail = 85
        }
        let btn = UIButton()
        btn.setTitle("1-9", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        btn.backgroundColor = #colorLiteral(red: 0.8359088302, green: 0.3050788045, blue: 0.3091535568, alpha: 1)
        btn.layer.cornerRadius = 20
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(positX)
            make.leading.equalToSuperview().inset(leadTrail)
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
        
        return btn
    }()
    
    @objc func buttonList1_9Action(sender: UIButton) {
        UserDefaults.standard.set(1, forKey: "choiceMuscle")
        
        destroyBanner()
        sender.zoomOut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "YogaTableViewController")

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
    //list20_29
    @objc lazy var buttonList10_19: UIButton = {
        let positX: CGFloat!
        let fontSize: CGFloat!
        let leadTrail: CGFloat!
        if totalSize.height >= 920 {
            fontSize = 24
            positX = 490
            leadTrail = 90
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 25
            positX = 460
            leadTrail = 90
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 23
            positX = 450
            leadTrail = 85
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 23
            positX = 420
            leadTrail = 90
        } else if totalSize.height <= 670 {
            positX = 400
            fontSize = 23
            leadTrail = 85
        } else {
            positX = 450
            fontSize = 23
            leadTrail = 85
        }
        let btn = UIButton()
        btn.setTitle("10-19", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        btn.backgroundColor = #colorLiteral(red: 0.8359088302, green: 0.3050788045, blue: 0.3091535568, alpha: 1)
        btn.layer.cornerRadius = 20
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(positX)
            make.trailing.equalToSuperview().inset(leadTrail)
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
        
        return btn
    }()
    
    @objc func buttonList10_19Action(sender: UIButton) {
        UserDefaults.standard.set(2, forKey: "choiceMuscle")
        
        destroyBanner()
        sender.zoomOut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "YogaTableViewController")

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
    //list20_29
    @objc lazy var buttonList20_29: UIButton = {
        let positX: CGFloat!
        let fontSize: CGFloat!
        let leadTrail: CGFloat!
        if totalSize.height >= 920 {
            fontSize = 24
            positX = 380
            leadTrail = 90
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 25
            positX = 360
            leadTrail = 90
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 23
            positX = 350
            leadTrail = 85
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 23
            positX = 320
            leadTrail = 90
        } else if totalSize.height <= 670 {
            positX = 300
            fontSize = 23
            leadTrail = 85
        } else {
            positX = 350
            fontSize = 23
            leadTrail = 85
        }
        let btn = UIButton()
        btn.setTitle("20-29", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        btn.backgroundColor = #colorLiteral(red: 0.8359088302, green: 0.3050788045, blue: 0.3091535568, alpha: 1)
        btn.layer.cornerRadius = 20
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(positX)
            make.leading.equalToSuperview().inset(leadTrail)
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
        
        return btn
    }()
    
    @objc func buttonList20_29Action(sender: UIButton) {
        UserDefaults.standard.set(3, forKey: "choiceMuscle")
        
        destroyBanner()
        sender.zoomOut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "YogaTableViewController")

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
    //list30_38
    @objc lazy var buttonList30_38: UIButton = {
        let positX: CGFloat!
        let fontSize: CGFloat!
        let leadTrail: CGFloat!
        if totalSize.height >= 920 {
            fontSize = 24
            positX = 380
            leadTrail = 90
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            fontSize = 25
            positX = 360
            leadTrail = 90
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 23
            positX = 350
            leadTrail = 85
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 23
            positX = 320
            leadTrail = 90
        } else if totalSize.height <= 670 {
            positX = 300
            fontSize = 23
            leadTrail = 85
        } else {
            positX = 350
            fontSize = 23
            leadTrail = 85
        }
        let btn = UIButton()
        btn.setTitle("30-38", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        btn.backgroundColor = #colorLiteral(red: 0.8359088302, green: 0.3050788045, blue: 0.3091535568, alpha: 1)
        btn.layer.cornerRadius = 20
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(positX)
            make.trailing.equalToSuperview().inset(leadTrail)
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
        
        return btn
    }()
    
    @objc func buttonList30_38Action(sender: UIButton) {
        UserDefaults.standard.set(4, forKey: "choiceMuscle")
        
        destroyBanner()
        sender.zoomOut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "YogaTableViewController")

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
//MARK: - CircleMenu
    @objc func rotateCircleMenuLeft() {
        
        labelCircleMenuMoveRight.zoomOutCircleMenu()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
            if UserDefaults.standard.integer(forKey: "idCircleMenu") == 0 {
                self.labelCircleMenuMoveRight.text = "Стретчинг".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 1 {
                self.labelCircleMenuMoveRight.text = "Фитнес дома".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 2 {
                self.labelCircleMenuMoveRight.text = "Восстановление после родов".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 3 {
                self.labelCircleMenuMoveRight.text = "Body Guide"
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 4 {
                self.labelCircleMenuMoveRight.text = "Таймер".localized()
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
                self.labelCircleMenuMoveRight.text = "Фитнес дома".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 2 {
                self.labelCircleMenuMoveRight.text = "Восстановление после родов".localized()
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 3 {
                self.labelCircleMenuMoveRight.text = "Body Guide"
            } else if UserDefaults.standard.integer(forKey: "idCircleMenu") == 4 {
                self.labelCircleMenuMoveRight.text = "Таймер".localized()
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
        labelCircleMenuMoveRight.text = "Фитнес дома".localized()
        
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
        lbl.text = "Фитнес дома".localized()
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
            make.width.equalTo(320)
        }
        
        return img
    }()
    func setupCircleMenu() {
        icons.append(contentsOf: ["home", "stretching", "dumbbell", "baby", "bodyGuideIcon", "stopwatch", "complexIcon", "foodRationIcon", "icVideo", "home", "icHDR"])
        
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
            
        } else if id == 3 {
            
            if !UserDefaults.standard.bool(forKey: "isFirstLaunchPostPregnancyRecovery") {
                    
                let vc = PreviewRecoveryViewController()
                vc.modalPresentationStyle = .fullScreen

                let transition = CATransition()
                transition.duration = 0.4
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(vc, animated: false, completion: nil)
                
               } else {
                let vc = MenuPostPregnancyRecoveryViewController()
                vc.modalPresentationStyle = .fullScreen

                let transition = CATransition()
                transition.duration = 0.4
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
                view.window!.layer.add(transition, forKey: kCATransition)

                present(vc, animated: false, completion: nil)
               }
               UserDefaults.standard.set(true, forKey: "isFirstLaunchPostPregnancyRecovery")
            
        } else if id == 4 {
            
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
            
        } else if id == 5 {
            
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
extension YogaMenuViewController: ISBannerDelegate, ISImpressionDataDelegate {
    
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
