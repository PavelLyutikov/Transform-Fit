//
//  CalorieCalculatorViewController.swift
//  Transform
//
//  Created by Pavel Lyutikov on 02.08.2021.
//

import UIKit

class CalorieCalculatorViewController: UIViewController, UITextFieldDelegate {

    let totalSize = UIScreen.main.bounds.size
    
    var activityIndicator = UIActivityIndicatorView()
    
    var bmr: Double!
    var calculationWeight: Double!
    var calculationHeight: Double!
    var calculationAge: Double!
    var maleGender: Bool!
    
    var ageInt: Int!
    var heightInt: Int!
    var weightInt: Int!
    
    //ironSource
    var bannerView: ISBannerView! = nil
    let kAPPKEY = "11dfcc91d"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        backgroundImage.isHidden = false
        age.isHidden = true
        height.isHidden = true
        weight.isHidden = true
        mainLabel.isHidden = false
        genderLabel.isHidden = false
        
        
        dismissButton.addTarget(self, action: #selector(dismissButtonAction(sender:)), for: .touchUpInside)
        maleGenderButton.addTarget(self, action: #selector(maleGenderButtonAction(sender:)), for: .touchUpInside)
        femaleGenderButton.addTarget(self, action: #selector(femaleGenderButtonAction(sender:)), for: .touchUpInside)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        age.addTarget(self, action: #selector(CalorieCalculatorViewController.ageDidChange(_:)),
                                  for: .editingChanged)
        height.addTarget(self, action: #selector(CalorieCalculatorViewController.heightDidChange(_:)),
                                  for: .editingChanged)
        weight.addTarget(self, action: #selector(CalorieCalculatorViewController.weightDidChange(_:)),
                                  for: .editingChanged)
        
        
        //Ads
        if !UserDefaults.standard.bool(forKey: "removeAdsPurchased") {
            setupIronSourceSdk()
            loadBanner()
        }

        addDoneButtonOnKeyboard()
    }
    //MARK: - IronSource
    func loadBanner() {
        let BNSize: ISBannerSize = ISBannerSize(description: "BANNER", width: Int(self.view.frame.size.width), height: 50)
           IronSource.loadBanner(with: self, size: BNSize)
    }
    func setupIronSourceSdk() {

        IronSource.setRewardedVideoDelegate(self)
        IronSource.setBannerDelegate(self)
        IronSource.add(self)
        
        IronSource.initWithAppKey(kAPPKEY)
    }
    func logFunctionName(string: String = #function) {
        print("IronSource Swift Demo App:"+string)
    }
    func destroyBanner() {
        if bannerView != nil {
            IronSource.destroyBanner(bannerView)
        }
    }
//MARK: - ActivityIndicator
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        activityIndicator.center = self.view.center
        activityIndicator.style = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = #colorLiteral(red: 0.5489576459, green: 0.5490553379, blue: 0.5489515066, alpha: 1)
        activityIndicator.layer.cornerRadius = 15
        activityIndicator.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        activityIndicator.layer.shadowRadius = 3
        activityIndicator.layer.shadowOffset = CGSize(width: 0, height: 0)
        activityIndicator.layer.shadowOpacity = 0.4
    }
//MARK: - MainLabel
    lazy var mainLabel: UILabel = {
        let topPosit: CGFloat!
        let fontSz: CGFloat!
        if totalSize.height >= 830 {
            topPosit = 100
            fontSz = 33
        } else if totalSize.height <= 800 {
            topPosit = 100
            fontSz = 33
        } else {
            topPosit = 100
            fontSz = 33
        }
        
        let lbl = UILabel()
        lbl.text = "Расчет суточной нормы калорий"
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: fontSz)
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 8
        lbl.layer.shadowOpacity = 0.5
        self.view.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(topPosit)
            make.leading.trailing.equalToSuperview().inset(50)
        }
        
       return lbl
    }()
//MARK: - MainLabel
    lazy var genderLabel: UILabel = {
        let topPosit: CGFloat!
        let fontSz: CGFloat!
        if totalSize.height >= 830 {
            topPosit = 280
            fontSz = 25
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            topPosit = 280
            fontSz = 25
        } else if totalSize.height <= 670 {
            topPosit = 250
            fontSz = 25
        } else {
            topPosit = 280
            fontSz = 25
        }
        
        let lbl = UILabel()
        lbl.text = "ВАШ ГЕНДЕР:"
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: fontSz)
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 8
        lbl.layer.shadowOpacity = 0.5
        self.view.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(topPosit)
            make.leading.trailing.equalToSuperview().inset(50)
        }
        
       return lbl
    }()
//MARK: - anthropometricDataLabel
    lazy var anthropometricDataLabel: UILabel = {
        let topPosit: CGFloat!
        let fontSz: CGFloat!
        if totalSize.height >= 830 {
            topPosit = 100
            fontSz = 28
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            topPosit = 100
            fontSz = 28
        } else if totalSize.height <= 670 {
            topPosit = 100
            fontSz = 26
        } else {
            topPosit = 100
            fontSz = 26
        }
        
        let lbl = UILabel()
        lbl.text = "Антропометрические данные:"
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: fontSz)
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 8
        lbl.layer.shadowOpacity = 0.5
        self.view.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(topPosit)
            make.leading.trailing.equalToSuperview().inset(50)
        }
        
       return lbl
    }()
//MARK: BackgroundImage
    lazy var backgroundImage: UIImageView = {
        var image = UIImageView(image: #imageLiteral(resourceName: "calculationBackground"))
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.layer.zPosition = 0
        image.alpha = 0.17
        self.view.addSubview(image)


        image.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(10)
    }
        return image
    }()
//MARK: - GenderButton
//Male
    lazy var maleGenderButton: UIButton = {
        let leadTrail: CGFloat!
        let top: CGFloat!
        let width: CGFloat!
        if totalSize.height >= 920 {
            leadTrail = 35
            top = 350
            width = 150
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            leadTrail = 35
            top = 350
            width = 150
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            leadTrail = 40
            top = 350
            width = 130
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            leadTrail = 40
            top = 350
            width = 140
        } else if totalSize.height <= 670 {
            leadTrail = 40
            top = 320
            width = 130
        } else {
            leadTrail = 35
            top = 370
            width = 130
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "maleGenderButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.3
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(top)
            make.leading.equalToSuperview().inset(leadTrail)
            make.width.height.equalTo(width)
        }
        
        return btn
    }()
    
    @objc func maleGenderButtonAction(sender: UIButton) {
        maleGenderButton.layer.shadowColor = #colorLiteral(red: 0.2875794768, green: 0.5477300882, blue: 0.9337822199, alpha: 1)
        maleGenderButton.layer.shadowRadius = 15
        maleGenderButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        maleGenderButton.layer.shadowOpacity = 1
        
        maleGender = true
        print("maleGender\(String(describing: maleGender))")
        
        femaleGenderButton.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        femaleGenderButton.layer.shadowRadius = 8
        femaleGenderButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        femaleGenderButton.layer.shadowOpacity = 0.3
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.mainLabel.zoomOutInfo()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.genderLabel.zoomOutInfo()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.maleGenderButton.zoomOutInfo()
            self.femaleGenderButton.zoomOutInfo()
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            self.anthropometricDataLabel.isHidden = false
            self.anthropometricDataLabel.zoomInInfo()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            self.age.isHidden = false
            self.age.zoomInInfo()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
            self.height.isHidden = false
            self.height.zoomInInfo()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
            self.weight.isHidden = false
            self.weight.zoomInInfo()
        }
    }
//Female
    lazy var femaleGenderButton: UIButton = {
        let leadTrail: CGFloat!
        let top: CGFloat!
        let width: CGFloat!
        if totalSize.height >= 920 {
            leadTrail = 35
            top = 350
            width = 150
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            leadTrail = 35
            top = 350
            width = 150
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            leadTrail = 40
            top = 350
            width = 130
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            leadTrail = 40
            top = 350
            width = 140
        } else if totalSize.height <= 670 {
            leadTrail = 40
            top = 320
            width = 130
        } else {
            leadTrail = 35
            top = 370
            width = 130
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "femaleGenderButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.3
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(top)
            make.trailing.equalToSuperview().inset(leadTrail)
            make.width.height.equalTo(width)
        }
        
        return btn
    }()
    
    @objc func femaleGenderButtonAction(sender: UIButton) {
        femaleGenderButton.layer.shadowColor = #colorLiteral(red: 1, green: 0.5768669248, blue: 0.6308962703, alpha: 1)
        femaleGenderButton.layer.shadowRadius = 15
        femaleGenderButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        femaleGenderButton.layer.shadowOpacity = 1
        
        maleGender = false
        print("maleGender\(String(describing: maleGender))")
        
        maleGenderButton.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        maleGenderButton.layer.shadowRadius = 8
        maleGenderButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        maleGenderButton.layer.shadowOpacity = 0.3
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.mainLabel.zoomOutInfo()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.genderLabel.zoomOutInfo()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.maleGenderButton.zoomOutInfo()
            self.femaleGenderButton.zoomOutInfo()
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            self.anthropometricDataLabel.isHidden = false
            self.anthropometricDataLabel.zoomInInfo()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            self.age.isHidden = false
            self.age.zoomInInfo()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
            self.height.isHidden = false
            self.height.zoomInInfo()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
            self.weight.isHidden = false
            self.weight.zoomInInfo()
        }
    }
//MARK: - Age/Height/Weight
    lazy var age: UITextField = {
        let font: CGFloat!
        let top: CGFloat!
        let width: CGFloat!
        let hghth: CGFloat!
        if totalSize.height >= 920 {
            font = 35
            top = 270
            width = 150
            hghth = 70
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            font = 35
            top = 270
            width = 150
            hghth = 70
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            font = 35
            top = 250
            width = 150
            hghth = 70
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            font = 30
            hghth = 65
            top = 210
            width = 130
        } else if totalSize.height <= 670 {
            font = 30
            hghth = 65
            top = 210
            width = 130
        } else {
            font = 30
            hghth = 65
            top = 210
            width = 130
        }
        let age = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        age.placeholder = "Возраст"
        age.textAlignment = .center
        age.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        age.layer.shadowRadius = 7
        age.layer.shadowOffset = CGSize(width: 0, height: 0)
        age.layer.shadowOpacity = 0.3
        age.font = UIFont.systemFont(ofSize: font)
        age.borderStyle = UITextField.BorderStyle.roundedRect
        age.autocorrectionType = UITextAutocorrectionType.no
        age.keyboardType = UIKeyboardType.asciiCapableNumberPad
        age.returnKeyType = UIReturnKeyType.done
        age.clearButtonMode = UITextField.ViewMode.whileEditing
        age.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        age.delegate = self
        self.view.addSubview(age)
        
        age.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(top)
            make.height.equalTo(hghth)
            make.width.equalTo(width)
        }
        
        return age
    }()
    @objc func ageDidChange(_ textField: UITextField) {
        ageInt = Int(age.text!)
        
    }
    
    lazy var height: UITextField = {
        let font: CGFloat!
        let top: CGFloat!
        let width: CGFloat!
        let hghth: CGFloat!
        if totalSize.height >= 920 {
            font = 35
            top = 410
            hghth = 70
            width = 150
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            font = 33
            top = 410
            hghth = 70
            width = 150
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            font = 33
            top = 390
            hghth = 70
            width = 150
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            font = 30
            top = 350
            hghth = 65
            width = 130
        } else if totalSize.height <= 670 {
            font = 30
            top = 330
            hghth = 65
            width = 130
        } else {
            font = 30
            top = 350
            hghth = 65
            width = 130
        }
        let age = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        age.placeholder = "Рост"
        age.textAlignment = .center
        age.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        age.layer.shadowRadius = 7
        age.layer.shadowOffset = CGSize(width: 0, height: 0)
        age.layer.shadowOpacity = 0.3
        age.font = UIFont.systemFont(ofSize: font)
        age.borderStyle = UITextField.BorderStyle.roundedRect
        age.autocorrectionType = UITextAutocorrectionType.no
        age.keyboardType = UIKeyboardType.asciiCapableNumberPad
        age.returnKeyType = UIReturnKeyType.done
        age.clearButtonMode = UITextField.ViewMode.whileEditing
        age.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        age.delegate = self
        self.view.addSubview(age)
        
        age.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(top)
            make.height.equalTo(hghth)
            make.width.equalTo(width)
        }
        
        return age
    }()
    @objc func heightDidChange(_ textField: UITextField) {
        heightInt = Int(height.text!)
    }
    
    lazy var weight: UITextField = {
        let font: CGFloat!
        let top: CGFloat!
        let width: CGFloat!
        let hghth: CGFloat!
        if totalSize.height >= 920 {
            font = 33
            top = 550
            width = 150
            hghth = 70
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            font = 33
            top = 550
            width = 150
            hghth = 70
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            font = 33
            top = 530
            width = 150
            hghth = 70
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            font = 30
            top = 490
            hghth = 65
            width = 130
        } else if totalSize.height <= 670 {
            font = 30
            top = 450
            hghth = 65
            width = 130
        } else {
            font = 30
            top = 490
            hghth = 65
            width = 130
        }
        let age = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        age.placeholder = "Вес"
        age.textAlignment = .center
        age.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        age.layer.shadowRadius = 7
        age.layer.shadowOffset = CGSize(width: 0, height: 0)
        age.layer.shadowOpacity = 0.3
        age.font = UIFont.systemFont(ofSize: font)
        age.borderStyle = UITextField.BorderStyle.roundedRect
        age.autocorrectionType = UITextAutocorrectionType.no
        age.keyboardType = UIKeyboardType.asciiCapableNumberPad
        age.returnKeyType = UIReturnKeyType.done
        age.clearButtonMode = UITextField.ViewMode.whileEditing
        age.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        age.delegate = self
        self.view.addSubview(age)
        
        age.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(top)
            make.height.equalTo(hghth)
            make.width.equalTo(width)
        }
        
        return age
    }()
    @objc func weightDidChange(_ textField: UITextField) {
        weightInt = Int(weight.text!)
    }
    
//MARK: - DoneButton
    func addDoneButtonOnKeyboard(){
        
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default

            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(self.doneButtonAction))

            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()

            age.inputAccessoryView = doneToolbar
            height.inputAccessoryView = doneToolbar
            weight.inputAccessoryView = doneToolbar
    
        }

        @objc func doneButtonAction() {
            
            if ageInt >= 1 && heightInt >= 1 && weightInt >= 1 {
            
                age.resignFirstResponder()
                height.resignFirstResponder()
                weight.resignFirstResponder()
                
                if maleGender == true {
                
                    calculationAge = 5.7 * Double(age.text!)!
                    calculationWeight = 13.4 * Double(weight.text!)!
                    calculationHeight = 4.8 * Double(height.text!)!
                    
                    bmr = 88.36 + calculationHeight + calculationWeight - calculationAge
                
                } else if maleGender == false {
                    
                    calculationAge = 4.3 * Double(age.text!)!
                    calculationWeight = 9.2 * Double(weight.text!)!
                    calculationHeight = 3.1 * Double(height.text!)!
                    
                    bmr = 447.6 + calculationHeight + calculationWeight - calculationAge
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.anthropometricDataLabel.zoomOutInfo()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.age.zoomOutInfo()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    self.height.zoomOutInfo()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                    self.weight.zoomOutInfo()
                }
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                    self.sedenteryLifestileButton.zoomInInfo()
                    self.sedenteryLifestileButton.addTarget(self, action: #selector(self.sedenteryLifestileButtonAction(sender:)), for: .touchUpInside)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                    self.training1_3WeekButton.zoomInInfo()
                    self.training1_3WeekButton.addTarget(self, action: #selector(self.training1_3WeekButtonAction(sender:)), for: .touchUpInside)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.training3_5WeekButton.zoomInInfo()
                    self.training3_5WeekButton.addTarget(self, action: #selector(self.training3_5WeekButtonAction(sender:)), for: .touchUpInside)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
                    self.training6_7WeekButton.zoomInInfo()
                    self.training6_7WeekButton.addTarget(self, action: #selector(self.training6_7WeekButtonAction(sender:)), for: .touchUpInside)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.6) {
                    self.frequentTrainingSessionsButton.zoomInInfo()
                    self.frequentTrainingSessionsButton.addTarget(self, action: #selector(self.frequentTrainingSessionsButtonAction(sender:)), for: .touchUpInside)
                }
                
                print(Double(bmr))
            }
        }
    
//MARK: Lifestile
    lazy var sedenteryLifestileButton: UIButton = {
        let top: CGFloat!
        let hght: CGFloat!
        let center: CGFloat!
        if totalSize.height >= 920 {
            top = 100
            hght = 120
            center = 0
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            top = 100
            hght = 120
            center = 0
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            top = 100
            hght = 115
            center = 0
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            top = 50
            hght = 115
            center = 0
        } else if totalSize.height <= 670 {
            top = 40
            hght = 105
            center = 10
        } else {
            top = 85
            hght = 115
            center = 0
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "sedenteryLifestileButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 6
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(center)
            make.top.equalToSuperview().inset(top)
            make.height.equalTo(hght)
        }
        
            return btn
        }()
    
        @objc func sedenteryLifestileButtonAction(sender: UIButton) {
            bmr = bmr * 1.2
            
            print(String(bmr))
            
            sedenteryLifestileButton.zoomOutInfo()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.training1_3WeekButton.zoomOutInfo()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.training3_5WeekButton.zoomOutInfo()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                self.training6_7WeekButton.zoomOutInfo()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                self.frequentTrainingSessionsButton.zoomOutInfo()
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.geinWeightButton.zoomInInfo()
                self.geinWeightButton.addTarget(self, action: #selector(self.geinWeightButtonAction(sender:)), for: .touchUpInside)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                self.loseWeightButton.zoomInInfo()
                self.loseWeightButton.addTarget(self, action: #selector(self.loseWeightButtonAction(sender:)), for: .touchUpInside)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                self.saveWeightButton.zoomInInfo()
                self.saveWeightButton.addTarget(self, action: #selector(self.saveWeightButtonAction(sender:)), for: .touchUpInside)
            }
        }
    
    lazy var training1_3WeekButton: UIButton = {
        let top: CGFloat!
        let hght: CGFloat!
        let center: CGFloat!
        if totalSize.height >= 920 {
            top = 250
            hght = 120
            center = 0
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            top = 250
            hght = 120
            center = 0
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            top = 243
            hght = 115
            center = 0
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            top = 183
            hght = 115
            center = 0
        } else if totalSize.height <= 670 {
            top = 164
            hght = 105
            center = 10
        } else {
            top = 228
            hght = 115
            center = 0
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "training1_3WeekButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 6
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(center)
            make.top.equalToSuperview().inset(top)
            make.height.equalTo(hght)
        }
        
            return btn
        }()
    
        @objc func training1_3WeekButtonAction(sender: UIButton) {
            bmr = bmr * 1.375
            
            print(String(bmr))
            
            training1_3WeekButton.zoomOutInfo()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.sedenteryLifestileButton.zoomOutInfo()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.training3_5WeekButton.zoomOutInfo()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                self.training6_7WeekButton.zoomOutInfo()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                self.frequentTrainingSessionsButton.zoomOutInfo()
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.geinWeightButton.zoomInInfo()
                self.geinWeightButton.addTarget(self, action: #selector(self.geinWeightButtonAction(sender:)), for: .touchUpInside)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                self.loseWeightButton.zoomInInfo()
                self.loseWeightButton.addTarget(self, action: #selector(self.loseWeightButtonAction(sender:)), for: .touchUpInside)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                self.saveWeightButton.zoomInInfo()
                self.saveWeightButton.addTarget(self, action: #selector(self.saveWeightButtonAction(sender:)), for: .touchUpInside)
            }
        }
    
    lazy var training3_5WeekButton: UIButton = {
        let top: CGFloat!
        let hght: CGFloat!
        let center: CGFloat!
        if totalSize.height >= 920 {
            top = 400
            hght = 120
            center = 0
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            top = 400
            hght = 120
            center = 0
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            top = 386
            hght = 115
            center = 0
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            top = 320
            hght = 115
            center = 0
        } else if totalSize.height <= 670 {
            top = 288
            hght = 105
            center = 10
        } else {
            top = 371
            hght = 115
            center = 0
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "training3_5WeekButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 6
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(center)
            make.top.equalToSuperview().inset(top)
            make.height.equalTo(hght)
        }
        
            return btn
        }()
    
        @objc func training3_5WeekButtonAction(sender: UIButton) {
            bmr = bmr * 1.55
            
            print(String(bmr))
            
            training3_5WeekButton.zoomOutInfo()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.sedenteryLifestileButton.zoomOutInfo()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.training1_3WeekButton.zoomOutInfo()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                self.training6_7WeekButton.zoomOutInfo()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                self.frequentTrainingSessionsButton.zoomOutInfo()
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.geinWeightButton.zoomInInfo()
                self.geinWeightButton.addTarget(self, action: #selector(self.geinWeightButtonAction(sender:)), for: .touchUpInside)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                self.loseWeightButton.zoomInInfo()
                self.loseWeightButton.addTarget(self, action: #selector(self.loseWeightButtonAction(sender:)), for: .touchUpInside)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                self.saveWeightButton.zoomInInfo()
                self.saveWeightButton.addTarget(self, action: #selector(self.saveWeightButtonAction(sender:)), for: .touchUpInside)
            }
        }
    
    lazy var training6_7WeekButton: UIButton = {
        let top: CGFloat!
        let hght: CGFloat!
        let center: CGFloat!
        if totalSize.height >= 920 {
            top = 550
            hght = 120
            center = 0
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            top = 550
            hght = 120
            center = 0
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            top = 530
            hght = 115
            center = 0
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            top = 455
            hght = 115
            center = 0
        } else if totalSize.height <= 670 {
            top = 412
            hght = 105
            center = 10
        } else {
            top = 515
            hght = 115
            center = 0
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "training6_7WeekButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 6
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(center)
            make.top.equalToSuperview().inset(top)
            make.height.equalTo(hght)
        }
        
            return btn
        }()
    
        @objc func training6_7WeekButtonAction(sender: UIButton) {
            bmr = bmr * 1.725
            
            print(String(bmr))
            
            training6_7WeekButton.zoomOutInfo()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.sedenteryLifestileButton.zoomOutInfo()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.training1_3WeekButton.zoomOutInfo()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                self.training3_5WeekButton.zoomOutInfo()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                self.frequentTrainingSessionsButton.zoomOutInfo()
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.geinWeightButton.zoomInInfo()
                self.geinWeightButton.addTarget(self, action: #selector(self.geinWeightButtonAction(sender:)), for: .touchUpInside)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                self.loseWeightButton.zoomInInfo()
                self.loseWeightButton.addTarget(self, action: #selector(self.loseWeightButtonAction(sender:)), for: .touchUpInside)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                self.saveWeightButton.zoomInInfo()
                self.saveWeightButton.addTarget(self, action: #selector(self.saveWeightButtonAction(sender:)), for: .touchUpInside)
            }
        }
    
    lazy var frequentTrainingSessionsButton: UIButton = {
        let top: CGFloat!
        let hght: CGFloat!
        let center: CGFloat!
        if totalSize.height >= 920 {
            top = 700
            hght = 120
            center = 0
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            top = 700
            hght = 120
            center = 0
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            top = 676
            hght = 115
            center = 0
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            top = 587
            hght = 115
            center = 0
        } else if totalSize.height <= 670 {
            top = 536
            hght = 105
            center = 10
        } else {
            top = 661
            hght = 115
            center = 0
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "frequentTrainingSessionsButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 6
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        btn.layer.zPosition = 8
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(center)
            make.top.equalToSuperview().inset(top)
            make.height.equalTo(hght)
        }
        
            return btn
        }()
    
        @objc func frequentTrainingSessionsButtonAction(sender: UIButton) {
            bmr = bmr * 1.9
            
            print(String(bmr))
            
            frequentTrainingSessionsButton.zoomOutInfo()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.sedenteryLifestileButton.zoomOutInfo()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.training1_3WeekButton.zoomOutInfo()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                self.training3_5WeekButton.zoomOutInfo()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                self.training6_7WeekButton.zoomOutInfo()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.geinWeightButton.zoomInInfo()
                self.geinWeightButton.addTarget(self, action: #selector(self.geinWeightButtonAction(sender:)), for: .touchUpInside)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                self.loseWeightButton.zoomInInfo()
                self.loseWeightButton.addTarget(self, action: #selector(self.loseWeightButtonAction(sender:)), for: .touchUpInside)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                self.saveWeightButton.zoomInInfo()
                self.saveWeightButton.addTarget(self, action: #selector(self.saveWeightButtonAction(sender:)), for: .touchUpInside)
            }
        }
    
//MARK: - DesiredResult
    lazy var geinWeightButton: UIButton = {
        let top: CGFloat!
        let hght: CGFloat!
        if totalSize.height >= 920 {
            top = 250
            hght = 100
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            top = 250
            hght = 100
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            top = 250
            hght = 100
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            top = 180
            hght = 90
        } else if totalSize.height <= 670 {
            top = 160
            hght = 90
        } else {
            top = 230
            hght = 90
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "geinWeightButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 6
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(top)
            make.height.equalTo(hght)
        }
        
            return btn
        }()
    
        @objc func geinWeightButtonAction(sender: UIButton) {
            bmr = bmr + 200
            
            UserDefaults.standard.set(String(format: "%.0f", bmr), forKey: "bmrResult")
            UserDefaults.standard.set(bmr, forKey: "bmrResultDouble")
            
            geinWeightButton.zoomOutInfo()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.loseWeightButton.zoomOutInfo()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.saveWeightButton.zoomOutInfo()
            }
            
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.setupActivityIndicator()
                self.activityIndicator.startAnimating()
                self.view.addSubview(self.activityIndicator)
            }
            //rewardAd
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                IronSource.showRewardedVideo(with: self)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                
                self.activityIndicator.stopAnimating()
                
                self.calorieTitle.isHidden = false
                self.calorieTitle.zoomInInfo()
                
                UserDefaults.standard.set(true, forKey: "calculationBmr")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                self.calorieLabel.isHidden = false
                self.calorieLabel.zoomInInfo()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.1) {
                self.dismissButtonCompletion.isHidden = false
                self.dismissButtonCompletion.addTarget(self, action: #selector(self.dismissButtonCompletionAction(sender:)), for: .touchUpInside)
            }
        }
    
    lazy var loseWeightButton: UIButton = {
        let top: CGFloat!
        let hght: CGFloat!
        if totalSize.height >= 920 {
            top = 400
            hght = 100
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            top = 400
            hght = 100
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            top = 400
            hght = 100
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            top = 330
            hght = 90
        } else if totalSize.height <= 670 {
            top = 310
            hght = 90
        } else {
            top = 380
            hght = 90
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "loseWeightButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 6
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(top)
            make.height.equalTo(hght)
        }
        
            return btn
        }()
    
        @objc func loseWeightButtonAction(sender: UIButton) {
            bmr = bmr - 200
            
            UserDefaults.standard.set(String(format: "%.0f", bmr), forKey: "bmrResult")
            UserDefaults.standard.set(bmr, forKey: "bmrResultDouble")
            
            loseWeightButton.zoomOutInfo()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.geinWeightButton.zoomOutInfo()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.saveWeightButton.zoomOutInfo()
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.setupActivityIndicator()
                self.activityIndicator.startAnimating()
                self.view.addSubview(self.activityIndicator)
            }
            
            //rewardAd
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                IronSource.showRewardedVideo(with: self)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                
                self.activityIndicator.stopAnimating()
                
                self.calorieTitle.isHidden = false
                self.calorieTitle.zoomInInfo()
                
                UserDefaults.standard.set(true, forKey: "calculationBmr")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                self.calorieLabel.isHidden = false
                self.calorieLabel.zoomInInfo()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.1) {
                self.dismissButtonCompletion.isHidden = false
                self.dismissButtonCompletion.addTarget(self, action: #selector(self.dismissButtonCompletionAction(sender:)), for: .touchUpInside)
            }
        }
    
    lazy var saveWeightButton: UIButton = {
        let top: CGFloat!
        let hght: CGFloat!
        if totalSize.height >= 920 {
            top = 550
            hght = 100
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            top = 550
            hght = 100
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            top = 550
            hght = 100
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            top = 480
            hght = 90
        } else if totalSize.height <= 670 {
            top = 460
            hght = 90
        } else {
            top = 530
            hght = 90
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "saveWeightButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 6
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(top)
            make.height.equalTo(hght)
        }
        
            return btn
        }()
    
        @objc func saveWeightButtonAction(sender: UIButton) {

            UserDefaults.standard.set(String(format: "%.0f", bmr), forKey: "bmrResult")
            UserDefaults.standard.set(bmr, forKey: "bmrResultDouble")
            
            saveWeightButton.zoomOutInfo()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.geinWeightButton.zoomOutInfo()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.loseWeightButton.zoomOutInfo()
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.setupActivityIndicator()
                self.activityIndicator.startAnimating()
                self.view.addSubview(self.activityIndicator)
            }
            //rewardAd
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                IronSource.showRewardedVideo(with: self)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                
                self.activityIndicator.stopAnimating()
                
                self.calorieTitle.isHidden = false
                self.calorieTitle.zoomInInfo()
                
                UserDefaults.standard.set(true, forKey: "calculationBmr")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                self.calorieLabel.isHidden = false
                self.calorieLabel.zoomInInfo()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.1) {
                self.dismissButtonCompletion.isHidden = false
                self.dismissButtonCompletion.addTarget(self, action: #selector(self.dismissButtonCompletionAction(sender:)), for: .touchUpInside)
            }
        }
//MARK: - DismissButton
    @objc lazy var dismissButton: UIButton = {

        let top: CGFloat!
        let trail: CGFloat!
        if totalSize.height >= 830 {
            top = 55
            trail = 30
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            top = 35
            trail = 25
        } else if totalSize.height <= 670 {
            top = 30
            trail = 20
        } else {
            top = 45
            trail = 25
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "closeBlack"), for: .normal)
        btn.layer.zPosition = 4
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(top)
            make.leading.equalToSuperview().inset(trail)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        return btn
    }()
    @objc func dismissButtonAction(sender: UIButton) {
 
        sender.zoomOut()

        let vc = MenuFoodRationViewController()
        vc.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: false, completion: nil)
    }
//MARK: - DismissCompletion
    lazy var dismissButtonCompletion: UIButton = {
        let top: CGFloat!
        let hght: CGFloat!
        if totalSize.height >= 920 {
            top = 250
            hght = 140
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            top = 250
            hght = 140
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            top = 250
            hght = 140
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            top = 230
            hght = 140
        } else if totalSize.height <= 670 {
            top = 200
            hght = 140
        } else {
            top = 250
            hght = 140
        }
        let btn = UIButton()
        btn.setTitle("Готово", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.5479585313, green: 0.5479585313, blue: 0.5479585313, alpha: 1)
        btn.layer.cornerRadius = 15
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
//        btn.setImage(#imageLiteral(resourceName: "saveWeightButton"), for: .normal)
//        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 6
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(top)
            make.width.equalTo(hght)
        }
        
            return btn
        }()
    
        @objc func dismissButtonCompletionAction(sender: UIButton) {

            sender.zoomOut()

            let vc = MenuFoodRationViewController()
            vc.modalPresentationStyle = .fullScreen

            let transition = CATransition()
            transition.duration = 0.4
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromLeft
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
            view.window!.layer.add(transition, forKey: kCATransition)

            present(vc, animated: false, completion: nil)
        }
    
//MARK: - CalorieLabel
    lazy var calorieTitle: UILabel = {
        let topPosit: CGFloat!
        let fontSz: CGFloat!
        if totalSize.height >= 830 {
            topPosit = 250
            fontSz = 30
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            topPosit = 220
            fontSz = 30
        } else if totalSize.height <= 670 {
            topPosit = 160
            fontSz = 30
        } else {
            topPosit = 250
            fontSz = 30
        }
        
        let lbl = UILabel()
        lbl.text = "Ваша суточная норма калорий:"
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: fontSz)
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 8
        lbl.layer.shadowOpacity = 0.5
        self.view.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(topPosit)
            make.leading.trailing.equalToSuperview().inset(50)
        }
        
       return lbl
    }()
    lazy var calorieLabel: UILabel = {
        let topPosit: CGFloat!
        let fontSz: CGFloat!
        if totalSize.height >= 830 {
            topPosit = 380
            fontSz = 50
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            topPosit = 350
            fontSz = 50
        } else if totalSize.height <= 670 {
            topPosit = 300
            fontSz = 50
        } else {
            topPosit = 370
            fontSz = 50
        }
        
        let lbl = UILabel()
        lbl.text = String(format: "%.0f", bmr)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: fontSz)
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 8
        lbl.layer.shadowOpacity = 0.5
        self.view.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(topPosit)
            make.leading.trailing.equalToSuperview().inset(50)
        }
        
       return lbl
    }()
    
    
    }

//MARK: - Extension
extension CalorieCalculatorViewController {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == age && textField == height && textField == weight {
            
            let allowedCharacters = CharacterSet(charactersIn:"0123456789 ")
            
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    @objc func keyboardWillShow(sender: NSNotification) {
        
        let point: CGFloat!
        if totalSize.height >= 920 {
            point = -130
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            point = -130
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            point = -150
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            point = -140
        } else if totalSize.height <= 670 {
            point = -150
        } else {
            point = -130
        }
         self.view.frame.origin.y = point
        
        if ageInt == nil {
            ageInt = 0
        }
        if heightInt == nil {
            heightInt = 0
        }
        if weightInt == nil {
            weightInt = 0
        }
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0
    }
}
//MARK: - ExtensionIronSource
extension CalorieCalculatorViewController: ISBannerDelegate, ISImpressionDataDelegate, ISRewardedVideoDelegate {
    
    //banner
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
        bannerView.layer.zPosition = 7
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
    
    
    //RewardedVideo
    public func rewardedVideoHasChangedAvailability(_ available: Bool) {
        logFunctionName(string: #function+String(available.self))
    }

    public func rewardedVideoDidEnd() {
        logFunctionName()
    }

    public func rewardedVideoDidStart() {
        logFunctionName()
    }

    public func rewardedVideoDidClose() {
        logFunctionName()
    }

    public func rewardedVideoDidOpen() {
        logFunctionName()
    }
    
    public func rewardedVideoDidFailToShowWithError(_ error: Error!) {
        logFunctionName(string: #function+String(describing: error.self))
    }

    public func didReceiveReward(forPlacement placementInfo: ISPlacementInfo!) {
        logFunctionName(string: #function+String(describing: placementInfo.self))
    }

    func didClickRewardedVideo(_ placementInfo: ISPlacementInfo!) {
        logFunctionName(string: #function+String(describing: placementInfo.self))
    }
}
