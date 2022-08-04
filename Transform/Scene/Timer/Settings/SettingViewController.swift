//
//  SettingViewController.swift
//  WorkoutTimer
//
//  Created by Gavin Ryder on 8/18/20.
//  Copyright © 2020 Gavin Ryder. All rights reserved.
//

import UIKit


//MARK: - Float Extension
extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension Double {
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

//MARK: - Class
class SettingViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet weak var restDurationSlider: UISlider!
    @IBOutlet weak var sliderValueLabel: UILabel!
    @IBOutlet weak var timeStepper: UIStepper!
    @IBOutlet weak var timeStepper2: UIStepper!
    @IBOutlet weak var restDuration: UILabel!
    
    
    //MARK: - Local vars
    let defaults = UserDefaults.standard
    //let sharedView = StyledGradientView.shared
    var soundOptionsList = ["Tone","Beep","Whistle","Ding"]
    
    private let workoutEndKey = "WORKOUT_END_KEY"
    private let restEndKey = "REST_END_KEY"
    
    var workoutEndChoice = "Tone" {
        didSet {
            UserDefaults.standard.set(workoutEndChoice, forKey: "WORKOUT_END_KEY") //write to local
        }
    }
    
    var restEndChoice = "Tone" {
        didSet {
            UserDefaults.standard.set(restEndChoice, forKey: "REST_END_KEY") //write to local
        }
    }
    
    var VCMaster:TimerViewController = TimerViewController()
    private var darkModeEnabled:Bool = false
    
    //MARK: - Helpers
    func secondsToMinutesSeconds(secondsInput: Int) -> String {
        let seconds = secondsInput % 60
        let minutes = secondsInput / 60
        
        let sec = "сек".localized()
        let min = "мин".localized()
        
        if (minutes <= 0) {
            return "\(seconds) \(sec)"
        } else if (seconds == 0) {
            if (minutes == 1) {
                return "\(minutes) \(min)"
            } else {
                return "\(minutes) \(min)"
            }
        }
        return "\(minutes) \(min) : \(seconds) \(sec)"
    }
    
    
    //MARK: - Action Handlers
    @IBAction func valueChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value)
        sender.value = roundedValue
        sliderValueLabel.text = secondsToMinutesSeconds(secondsInput: Int(sender.value.clean)!)
        //sliderValueLabel.text = "\(sender.value.clean) seconds"
        VCMaster.restDuration = Int(sender.value)
        timeStepper.value = Double(sender.value)
        timeStepper2.value = Double(sender.value)
    }
    
    @IBAction func sliderReleased(_ sender: UISlider) {
        let roundedValue = round(sender.value)
        sender.value = roundedValue
        VCMaster.restDuration = Int(sender.value)
        timeStepper.value = Double(sender.value)
        timeStepper2.value = Double(sender.value)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        let roundedValue = round(sender.value)
        sender.value = roundedValue
        restDurationSlider.value = Float(sender.value)
        VCMaster.restDuration = Int(sender.value)
        sliderValueLabel.text = secondsToMinutesSeconds(secondsInput: Int(sender.value.clean)!)
        
        timeStepper.value = Double(sender.value)
        timeStepper2.value = Double(sender.value)
        //sliderValueLabel.text = "\(sender.value.clean) seconds"
    }
    
    //MARK: - View Overrides
    override func viewWillAppear(_ animated: Bool) {
        
        setUpTableViewHeader()
        
        restDurationSlider.thumbTintColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
        restDurationSlider.minimumTrackTintColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
        restDurationSlider.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        restDurationSlider.layer.shadowRadius = 5
        restDurationSlider.layer.shadowOffset = CGSize(width: 0, height: 0)
        restDurationSlider.layer.shadowOpacity = 0.3
        
        sliderValueLabel.textColor = .lightGray
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
//MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewWhiteBackgound.isHidden = false
        
        if #available(iOS 12.0, *) {
            self.darkModeEnabled = (self.traitCollection.userInterfaceStyle == .dark)
        } else {
            // Fallback on earlier versions
        }
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.restDurationSlider.value = Float(VCMaster.restDuration) //initialize to the stored value
        loadSoundPathsFromLocalData()
        sliderValueLabel.text = secondsToMinutesSeconds(secondsInput: Int(restDurationSlider.value.clean)!)
                
        restDuration.text = "Продолжительность отдыха".localized()
        restDuration.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        restDuration.layer.shadowRadius = 5
        restDuration.layer.shadowOffset = CGSize(width: 0, height: 0)
        restDuration.layer.shadowOpacity = 0.3
        
        setupSteppers()
        setupSteppers2()
        
//MARK: - Swipe
            let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeDown.direction = .down
            self.view.addGestureRecognizer(swipeDown)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
            case .down:
                self.dismiss(animated: true, completion: nil)
                print("Swiped down")
            case .left:
    //            self.performSegue (withIdentifier: "workoutBtnPressed", sender: self)
                print("Swiped left")
            case .up:
    //            self.performSegue (withIdentifier: "settingsSegue", sender: self)
                print("Swiped up")
            default:
                break
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
//MARK: - BackgoundWhiteView
    lazy var viewWhiteBackgound: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "whiteBackgroundView"))
        img.contentMode = .scaleAspectFit
        img.layer.zPosition = -5
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 50
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.5
        self.view.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(-500)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        return img
    }()
    
    private func setupSteppers() {
        timeStepper.minimumValue = Double(restDurationSlider.minimumValue) //set bounds
        timeStepper.maximumValue = Double(restDurationSlider.maximumValue)
        timeStepper.value = Double(restDurationSlider.value) //init the value to ensure alignment
        timeStepper.layer.cornerRadius = 0.5
        timeStepper.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        timeStepper.layer.shadowRadius = 5
        timeStepper.layer.shadowOffset = CGSize(width: 0, height: 0)
        timeStepper.layer.shadowOpacity = 0.3
    }
    
    private func setupSteppers2() {
        timeStepper2.minimumValue = Double(restDurationSlider.minimumValue) //set bounds
        timeStepper2.maximumValue = Double(restDurationSlider.maximumValue)
        timeStepper2.value = Double(restDurationSlider.value) //init the value to ensure alignment
        timeStepper2.layer.cornerRadius = 0.5
        timeStepper2.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        timeStepper2.layer.shadowRadius = 5
        timeStepper2.layer.shadowOffset = CGSize(width: 0, height: 0)
        timeStepper2.layer.shadowOpacity = 0.3
    }
    
    
    //MARK: - Loader and Setup Functions
    private func loadSoundPathsFromLocalData() {
        if (UserDefaults.standard.string(forKey: workoutEndKey) != nil) {
            self.workoutEndChoice = UserDefaults.standard.string(forKey: workoutEndKey)!
        } else {
            workoutEndChoice = "Tone" //revert to default
            UserDefaults.standard.set(workoutEndChoice, forKey: workoutEndKey)
        }
        
        if (UserDefaults.standard.string(forKey: restEndKey) != nil) {
            self.restEndChoice = UserDefaults.standard.string(forKey: restEndKey)!
        } else {
            restEndChoice = "Tone" //revert to default
            UserDefaults.standard.set(restEndChoice, forKey: restEndKey)
        }
    }
    
    
    private func setUpTableViewHeader(){
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true //no content scrolling behind, so use translucency to "match" the color in the background
        self.navigationController?.navigationBar.barTintColor = .yellow
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = .black
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done,target: self, action: #selector(backTapped))
        let label = UILabel(frame: CGRect(x:0, y:0, width:350, height:30))
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.font = UIFont (name: "Avenir Next", size: 18.0)!
        label.textAlignment = .center
        label.textColor = .black
        label.sizeToFit()
        label.text = "Configure Settings"
        self.navigationItem.titleView = label
    }
    
    @objc func backTapped(){
        navigationController?.popToRootViewController(animated: true)
    }
    
}

//MARK: - Table View Implementation!
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soundOptionsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)
//        tableView.separatorColor = StyledGradientView.viewColors.last!
        let cellIdentifier = "optionCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? OptionsViewCell else {
            fatalError("Dequeued cell not an instance of OptionsViewCell")
        }
        cell.isSelected = (workoutEndChoice == soundOptionsList[indexPath.row])
        cell.optionLabel.textColor = .black
        cell.optionLabel.textAlignment = .left
        cell.backgroundColor = .clear
        cell.optionLabel.text = soundOptionsList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView.restorationIdentifier == "workout") {
//            dropdownBtn.setTitle("\(soundOptionsList[indexPath.row])", for: .normal)
            workoutEndChoice = soundOptionsList[indexPath.row]
            VCMaster.workoutEndSoundName = workoutEndChoice
            
            VCMaster.configMainPlayerToPlaySound(name: workoutEndChoice)
            VCMaster.mainPlayer.prepareToPlay()
            VCMaster.mainPlayer.play()
            
            //VCMaster.audioSessionEnabled(enabled: false)
            
//            self.optionsTableView.setIsHidden(true, animated: true)
        } else if (tableView.restorationIdentifier == "rest") {
//            restDropdownBtn.setTitle("\(soundOptionsList[indexPath.row])", for: .normal)
            restEndChoice = soundOptionsList[indexPath.row]
            VCMaster.restEndSoundName = restEndChoice
            
            VCMaster.configMainPlayerToPlaySound(name: restEndChoice)
            VCMaster.mainPlayer.prepareToPlay()
            VCMaster.mainPlayer.play()
            
            //VCMaster.audioSessionEnabled(enabled: false)
            
//            self.restOptionsTblView.setIsHidden(true, animated: true)
        }
    }
}
