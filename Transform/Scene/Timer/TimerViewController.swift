//
//  ViewController.swift
//  WorkoutTimer
//
//  Created by Gavin Ryder on 8/11/20.
//  Copyright © 2020 Gavin Ryder. All rights reserved.
//

import UIKit
import UICircularProgressRing
import AVFoundation
import MediaPlayer
import SnapKit
import EGOCircleMenu

//MARK: - UIView Animation Extension
extension UIView {
    
    func setIsHidden(_ hidden: Bool, animated: Bool) {
        if animated {
            if self.isHidden && !hidden {
                self.alpha = 0.0
                self.isHidden = false
            }
            UIView.animate(withDuration: 0.15, animations: {
                self.alpha = hidden ? 0.0 : 1.0
            }) { (complete) in
                self.isHidden = hidden
            }
        } else {
            self.isHidden = hidden
        }
    }
}

//MARK: - Main VC Class
class TimerViewController: UIViewController, AVAudioPlayerDelegate, MPMediaPickerControllerDelegate, CircleMenuDelegate {
    
    let totalSize = UIScreen.main.bounds.size
    
    //CircleMenu
    var icons = [String]()
    let submenuIds = [2]
    let showItemSegueId = "showItem"
    var selectedItemId: Int?
    
    //ironSource
    var bannerView: ISBannerView! = nil
    let kAPPKEY = "11dfcc91d"
    
//MARK: - SetupCircleMenu
    func setupCircleMenu() {
        icons.append(contentsOf: ["home", "stretching", "yoga", "dumbbell", "baby", "bodyGuideIcon", "complexIcon", "foodRationIcon", "icVideo", "home", "icHDR"])
        
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
    
    
    //MARK: - Local Vars
    var mainPlayer: AVAudioPlayer!
    
    private let END_WORKOUT_SOUND_KEY = "ENDWORKOUT_SOUND_KEY"
    private let END_REST_SOUND_KEY = "RESTEND_SOUND_KEY"
    private let TONE_VOLUME_KEY = "TONE_VOLUME_KEY"
    
    var workoutEndSoundName = "Tone" {
        didSet {
            defaults.set(workoutEndSoundName, forKey: END_WORKOUT_SOUND_KEY)
        }
    }

    var restEndSoundName = "Tone" {
        didSet {
            defaults.set(restEndSoundName, forKey: END_REST_SOUND_KEY)
        }
    }

    var restDuration:Int = 15 {
        didSet {
            defaults.set(restDuration, forKey: restDurationKey) //update local data on set
        }
    }
    
    
    private var buttonState:ButtonMode = ButtonMode.start //inital state
    private let restDurationKey = "REST_DUR_KEY" //KEY
    private let defaults = UserDefaults.standard
        
    typealias AllWorkouts = [Workouts.Workout] //array of struct
    
    var currentWorkout = Workouts.Workout(duration: 0, name: "")
    var nextWorkout = Workouts.Workout(duration: 0, name: "")
    
    var timerInitiallyStarted = false
    var canStart = true
    
    var isRestTimerActive = false
    private var restTimer:Timer!
    
//MARK: - Workouts Singleton!
    private let workouts: Workouts = Workouts.shared
    
//MARK: - Button Modes
    enum ButtonMode:Equatable { //button states
        case start
        case pause
        case restart
    }
    
    
//MARK:  - Properties
    @IBOutlet weak var timerRing: UICircularTimerRing!
    @IBOutlet weak var restTimerLabel: UILabel!
    
    
//MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "swipeFromMain" || segue.identifier == "workoutBtnPressed") {
            (segue.destination as! WorkoutEditorControllerTableViewController).VCMaster = self
        } else if (segue.identifier == "settingsSegue") {
            (segue.destination as! SettingViewController).VCMaster = self
        }
    }
    
//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isHidden = true
        timerInitiallyStarted = false
        loadDataFromLocalStorage()
        
        //********************************************************
        
        roundAllButtons()
        enableAndShowButton(startButton)
        disableAndHideButton(stopButton)
        disableAndHideButton(restartButton)
        
        //********************************************************
        
        setupTimerRing()
        
        self.currentWorkout = workouts.getCurrentWorkout()
        self.nextWorkout = workouts.getNextWorkout()
        
        //********************************************************
        
        updateLabels() //MUST come after current workout init
        configMainPlayerToPlaySound(name: workoutEndSoundName)
        setupAudioAndControlColors() //setup audio stuff
                
        //********************************************************
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.observeBackgroundEntry), name: UIApplication.didEnterBackgroundNotification, object: nil) //add observer to handle leaving the foreground and pausing the timer
        
        settingsBtn.addTarget(self, action: #selector(settingsBtnAction(sender:)), for: .touchUpInside)
        workoutViewBtn.addTarget(self, action: #selector(workoutViewBtnAction(sender:)), for: .touchUpInside)
        restartButton.addTarget(self, action: #selector(restartButtonTapped(sender:)), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(startButtonTapped(sender:)), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopButtonTapped(sender:)), for: .touchUpInside)
        
        
        
        //Ads
        if !UserDefaults.standard.bool(forKey: "removeAdsPurchased") {
            setupIronSourceSdk()
            loadBanner()
        }
        
        setupCircleMenu()
        
        //Notification
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.rotateCircleMenuLeft), name: NSNotification.Name(rawValue: "rotateCircleMenuLeft"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.rotateCircleMenuRight), name: NSNotification.Name(rawValue: "rotateCircleMenuRight"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.openCircleMenu), name: NSNotification.Name(rawValue: "openCircleMenu"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.closeCircleMenu), name: NSNotification.Name(rawValue: "closeCircleMenu"), object: nil)
        
        
        spawnSwipe()
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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
//MARK: - Swipe
    func spawnSwipe() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
            case .down:
                print("Swiped down")
            case .left:
                self.performSegue (withIdentifier: "workoutBtnPressed", sender: self)
                print("Swiped left")
            case .up:
                self.performSegue (withIdentifier: "settingsSegue", sender: self)
                print("Swiped up")
            default:
                break
            }
        }
        
    }
    
    lazy var swipeView: UIView = {
        let view = UIView()
        view.layer.zPosition = 90
        view.backgroundColor = .clear
        self.view.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.width.equalTo(1000)
            make.height.equalTo(1000)
            make.center.equalToSuperview()
        }
        return view
    }()
//MARK: - SettingButton
    @objc lazy var settingsBtn: UIButton = {
        
        let wdth: CGFloat!
        let positionTrl: CGFloat!
        let positionTop: CGFloat!
        if totalSize.height >= 890 {
            wdth = 50
            positionTrl = 110
            positionTop = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 40
            positionTrl = 90
            positionTop = 60
        } else if totalSize.height <= 800 {
            wdth = 40
            positionTrl = 75
            positionTop = 30
        } else {
            wdth = 45
            positionTrl = 100
            positionTop = 70
        }
        
        let btn = UIButton()
        btn.setTitle("", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.setImage(#imageLiteral(resourceName: "gear"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 25)
//        btn.backgroundColor = #colorLiteral(red: 0.8359088302, green: 0.3050788045, blue: 0.3091535568, alpha: 1)
        btn.layer.cornerRadius = 20
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positionTop)
            make.trailing.equalToSuperview().inset(positionTrl)
            make.width.equalTo(wdth)
            make.height.equalTo(wdth)
        }
        
        return btn
    }()
    
    @objc func settingsBtnAction(sender: UIButton) {
        self.performSegue (withIdentifier: "settingsSegue", sender: self)
    }
//MARK: - WorkoutViewButoon
    @objc lazy var workoutViewBtn: UIButton = {
        
        let wdth: CGFloat!
        let positionTop: CGFloat!
        let positionTrl: CGFloat!
        if totalSize.height >= 890 {
            wdth = 65
            positionTop = 70
            positionTrl = 20
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 55
            positionTop = 60
            positionTrl = 15
        } else if totalSize.height <= 800 {
            wdth = 45
            positionTop = 30
            positionTrl = 10
        } else {
            wdth = 50
            positionTop = 70
            positionTrl = 20
        }
        
        let btn = UIButton()
        btn.setTitle("", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 25)
//        btn.backgroundColor = #colorLiteral(red: 0.8359088302, green: 0.3050788045, blue: 0.3091535568, alpha: 1)
        btn.setImage(#imageLiteral(resourceName: "note"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.cornerRadius = 20
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.4
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positionTop)
            make.trailing.equalToSuperview().inset(positionTrl)
            make.width.equalTo(wdth)
            make.height.equalTo(wdth)
        }
        
        return btn
    }()
    
    @objc func workoutViewBtnAction(sender: UIButton) {
        self.performSegue (withIdentifier: "workoutBtnPressed", sender: self)
    }
    
//MARK: - StartButton
    lazy var startButton: UIButton = {

        let wdth: CGFloat!
        let hght: CGFloat!
        let fntSize: CGFloat!
        let positionBtn: CGFloat!
        if totalSize.height >= 830 {
            wdth = 200
            hght = 55
            fntSize = 30
            positionBtn = 180
        } else if totalSize.height <= 800 {
            wdth = 150
            hght = 40
            fntSize = 22
            positionBtn = 140
        } else {
            wdth = 170
            hght = 50
            fntSize = 26
            positionBtn = 170
        }
        
        let btn = UIButton()
        btn.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
        btn.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        btn.setTitle("СТАРТ   ".localized(), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fntSize)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        self.view.addSubview(btn)
        
        
        btn.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.height.equalTo(hght)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(positionBtn)
        }
        
        return btn
    }()
    @objc func startButtonTapped(sender: UIButton) {
            if (buttonState == .start && !timerInitiallyStarted) { //first start
                timerInitiallyStarted = true
                startTimerIfWorkoutExists()
                changeButtonToMode(mode: .pause)
                self.settingsBtn.isEnabled = false
                transitioningActionsEnabled(false)
                UIApplication.shared.isIdleTimerDisabled = true //once the user starts the workout, prevent the device from going to sleep
                return
            } else if (buttonState == .start) { //resuming from pause
                if (!isRestTimerActive) {
                    timerRing.continueTimer()
                } else {
                    restTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateLabelForCountdown), userInfo: nil, repeats: true)
                }
                self.settingsBtn.isEnabled = false
                changeButtonToMode(mode: .pause)
                transitioningActionsEnabled(false)
                return
            } else if (buttonState == .pause){ //pause timer
                if (!isRestTimerActive) {
                    timerRing.pauseTimer()
                    settingsBtn.isEnabled = true
                } else {
                    restTimer.invalidate()
                    settingsBtn.isEnabled = true
                }
                transitioningActionsEnabled(true)
                changeButtonToMode(mode: .start)
                return
            } else if (buttonState == .restart){ //restart timer
                self.resetAll()
                
                return
            }
    }
//MARK: - StopButton
    lazy var stopButton: UIButton = {

        let wdthStp: CGFloat!
        let hghtStp: CGFloat!
        let fntSizeStp: CGFloat!
        let positionBtn: CGFloat!
        if totalSize.height >= 830 {
            wdthStp = 265
            hghtStp = 55
            fntSizeStp = 26
            positionBtn = 100
        } else if totalSize.height <= 800 {
            wdthStp = 200
            hghtStp = 40
            fntSizeStp = 20
            positionBtn = 85
        } else {
            wdthStp = 235
            hghtStp = 50
            fntSizeStp = 23
            positionBtn = 95
        }
        
        let btn = UIButton()
        btn.backgroundColor = #colorLiteral(red: 0.780459702, green: 0.2858942747, blue: 0.286295712, alpha: 1)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.setImage(#imageLiteral(resourceName: "delete"), for: .normal)
        btn.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        btn.setTitle("ЗАВЕРШИТЬ   ".localized(), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fntSizeStp)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.width.equalTo(wdthStp)
            make.height.equalTo(hghtStp)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(positionBtn)
        }
        
        return btn
    }()
    @objc func stopButtonTapped(sender: UIButton) {
        self.resetAll()
        
        if !UserDefaults.standard.bool(forKey: "removeAdsPurchased") {
            IronSource.showRewardedVideo(with: self)
        }
    }
//MARK: - RestartButton
    lazy var restartButton: UIButton = {

        let wdth: CGFloat!
        let hght: CGFloat!
        let fntSize: CGFloat!
        let positionBtn: CGFloat!
        if totalSize.height >= 830 {
            wdth = 240
            hght = 55
            fntSize = 26
            positionBtn = 150
        } else if totalSize.height <= 800 {
            wdth = 205
            hght = 40
            fntSize = 22
            positionBtn = 135
        } else {
            wdth = 210
            hght = 50
            fntSize = 23
            positionBtn = 170
        }
        
        let btn = UIButton()
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.1682949133, green: 0.7692858509, blue: 0.5529700511, alpha: 1)
        btn.setImage(#imageLiteral(resourceName: "restart"), for: .normal)
        btn.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        btn.setTitle("ПОВТОРИТЬ   ".localized(), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fntSize)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        self.view.addSubview(btn)
        
        
        btn.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.height.equalTo(hght)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(positionBtn)
        }
        
        return btn
    }()
    @objc func restartButtonTapped(sender: UIButton) {
        self.resetAll()
        
    }
//MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        
        if (self.workouts.allWorkouts.isEmpty) {
            canStart = false
            //nextWorkoutNameLabel.setIsHidden(true, animated: false)
            workoutNameLabel.font = UIFont.systemFont(ofSize: 22)
            workoutNameLabel.text = "Список тренировок пуст!".localized()
            nextWorkoutNameLabel.font = UIFont.systemFont(ofSize: 18)
            nextWorkoutNameLabel.text = "Заполните список".localized()
        } else {
            canStart = true
            updateLabels()
        }
        startButton.isEnabled = canStart
        
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    
    //MARK: - AVPlayer Config
    func configMainPlayerToPlaySound(name:String) {
        let path = Bundle.main.path(forResource: name, ofType: "mp3")!
        let URLForSound = URL(string: path)!
        do {
            try mainPlayer = AVAudioPlayer(contentsOf: URLForSound)
            mainPlayer.delegate = self
        } catch {
            print("Failed to initialize player with error: \(error)")
        }
    }
    
    
    //MARK: - Enable and Disable Button
    func transitioningActionsEnabled(_ enabled: Bool) { //determine if buttons are on or off on the home page
        //soundToggle.isEnabled = true
        workoutViewBtn.isEnabled = enabled
//        swipeToTableView.isEnabled = enabled
    }

//MARK: SettingsButton
    func changeButtonToMode(mode: ButtonMode) {
        startButton.isUserInteractionEnabled = true
        //set the state of the button according to the state passed in
        if (mode == .start && !timerInitiallyStarted) { //first start
            
            
            startButton.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
            startButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            startButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            startButton.tintColor = .white
            startButton.semanticContentAttribute = UIApplication.shared
                .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
            
            startButton.setTitle("СТАРТ   ".localized(), for: .normal)
//            startButton.titleLabel?.font = .systemFont(ofSize: 30)
            

            self.buttonState = mode
            return
        } else if (mode == .start && timerInitiallyStarted) { //resume
            startButton.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
            startButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            startButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            startButton.tintColor = .white
            startButton.semanticContentAttribute = UIApplication.shared
                .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
            
            startButton.setTitle("ДАЛЕЕ   ".localized(), for: .normal)
//            startButton.titleLabel?.font = .systemFont(ofSize: 30)

            enableAndShowButton(stopButton)
            self.buttonState = mode
            return
        } else if (mode == .pause){ //pause
            startButton.backgroundColor = #colorLiteral(red: 0.1260255208, green: 0.5231914717, blue: 0.4911269381, alpha: 1)
            startButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            startButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            startButton.tintColor = .white
            startButton.semanticContentAttribute = UIApplication.shared
                .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
            
            startButton.setTitle("ПАУЗА   ".localized(), for: .normal)
//            startButton.titleLabel?.font = .systemFont(ofSize: 30)
            
            disableAndHideButton(stopButton)
            self.buttonState = mode
            return
        } else if (mode == .restart) { //restart
            startButton.setTitle("Restart", for: .normal)
            UIApplication.shared.isIdleTimerDisabled = false //enable the screen to go to sleep once the workout is done
            startButton.backgroundColor = UIColor.systemBlue
            disableAndHideButton(stopButton)
            self.buttonState = mode
            return
        }
    }
    
    
    //MARK: - Delegates
    func mediaPicker(_ mediaPicker: MPMediaPickerController,
                     didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        // Get the system music player.
        let musicPlayer = MPMusicPlayerController.systemMusicPlayer
        musicPlayer.setQueue(with: mediaItemCollection)
        musicPlayer.prepareToPlay()
        mediaPicker.dismiss(animated: true)
        // Begin playback.
        musicPlayer.play()
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) { //delegate method
        audioSessionEnabled(enabled: false)
    }
    
    @objc func observeBackgroundEntry(notification: Notification) {
        if (timerInitiallyStarted) {
            if (!isRestTimerActive) {
                timerRing.pauseTimer()
                settingsBtn.isEnabled = true
            } else {
                restTimer.invalidate()
                settingsBtn.isEnabled = true
            }
            transitioningActionsEnabled(true)
            changeButtonToMode(mode: .start)
        }
        return
    }
    
    
    //MARK: - Local Helper and Initialization Functions
    private func startNextWorkout() {
        advanceWorkout()
        startTimerIfWorkoutExists()
        updateLabels()
    }
    
    func enableAndShowButton(_ button: UIButton, isAnimated:Bool? = true) { //helper
        button.setIsHidden(false, animated: isAnimated!)
        button.isEnabled = true
        button.isUserInteractionEnabled = true
    }
    
    func disableAndHideButton(_ button: UIButton, isAnimated:Bool? = true) { //helper
        button.setIsHidden(true, animated: isAnimated!)
        button.isEnabled = false
        button.isUserInteractionEnabled = false
    }
    
    func resetAll() {
        
        timerRing.resetTimer()
        timerInitiallyStarted = false
        workouts.currentWorkoutIndex = 0
        currentWorkout = workouts.getCurrentWorkout()
        nextWorkout = workouts.getNextWorkout()
        updateLabels()
        disableAndHideButton(restartButton, isAnimated: false)
        disableAndHideButton(stopButton, isAnimated: false)
        enableAndShowButton(startButton, isAnimated: true)
        timerRing.shouldShowValueText = false
        restTimerLabel.isHidden = true
        changeButtonToMode(mode: .start)
        self.settingsBtn.isEnabled = true
        self.isRestTimerActive = false
        transitioningActionsEnabled(true)
    }
    
//MARK: - Timer
    private func setupTimerRing() {
//        timerRing.font = UIFont (name: "Avenir Next", size: 38.0)!.italic()
        timerRing.font = UIFont.systemFont(ofSize: 55)
        timerRing.shouldShowValueText = false
        timerRing.backgroundColor = UIColor.clear //no background
        timerRing.startAngle = 90
        timerRing.outerRingColor = #colorLiteral(red: 0.1674883962, green: 0.6921558976, blue: 0.6487865448, alpha: 0.3022226347) //don't show
        timerRing.innerRingColor = #colorLiteral(red: 0.1674883962, green: 0.6921558976, blue: 0.6487865448, alpha: 1)
        timerRing.innerCapStyle = .round
        timerRing.innerRingWidth = 20.0
        timerRing.layer.cornerRadius = 20
        timerRing.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        timerRing.layer.shadowRadius = 5
        timerRing.layer.shadowOffset = CGSize(width: 0, height: 0)
        timerRing.layer.shadowOpacity = 0.4
        
        restTimerLabel.isHidden = true

        
        let positTop: CGFloat!
        if totalSize.height >= 920 {
            positTop = 170
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positTop = 150
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positTop = 110
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positTop = 85
        } else if totalSize.height <= 670 {
            positTop = 55
        } else {
            positTop = 130
        }
        timerRing.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positTop)
        }
        
    }
    
    private func roundButton(button:UIButton) { //round the corners of the button passed in
        
        let crnrRds: CGFloat!
        if totalSize.height >= 830 {
            crnrRds = 28
        } else if totalSize.height <= 800 {
            crnrRds = 20
        } else {
            crnrRds = 24
        }
        button.layer.cornerRadius = crnrRds
        button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.3
        
    }
    
    private func roundAllButtons() { //local helper method
        roundButton(button: startButton)
        roundButton(button: stopButton)
        roundButton(button: restartButton)
    }
    
    private func setupAudioAndControlColors() {
        do {
            try AVAudioSession.sharedInstance().setCategory(
                AVAudioSession.Category.playback,
                mode: AVAudioSession.Mode.default,
                options: [
                    AVAudioSession.CategoryOptions.duckOthers
                ]
            )
        } catch {
            print("Error occured on intializing: \(error)")
        }
    }
//MARK: - WorkoutLabel
    lazy var workoutNameLabel: UILabel = {
       
        let fontSize: CGFloat!
        let positionBtn: CGFloat!
        if totalSize.height >= 830 {
            fontSize = 32
            positionBtn = 355
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 28
            positionBtn = 270
        } else if totalSize.height <= 670 {
            fontSize = 25
            positionBtn = 260
        } else {
            positionBtn = 320
            fontSize = 25
        }
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: fontSize)
        lbl.layer.cornerRadius = 20
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 5
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        lbl.textAlignment = .center
        self.view.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(positionBtn)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        return lbl
    }()
    
    lazy var nextWorkoutNameLabel: UILabel = {
       
        let fontSize: CGFloat!
        let positionBtn: CGFloat!
        if totalSize.height >= 830 {
            fontSize = 25
            positionBtn = 270
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 23
            positionBtn = 215
        } else if totalSize.height <= 670 {
            fontSize = 20
            positionBtn = 215
        } else {
            fontSize = 20
            positionBtn = 250
        }
        
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: fontSize)
        lbl.layer.cornerRadius = 20
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 5
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        lbl.textAlignment = .center
        self.view.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(positionBtn)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(25)
        }
        
        return lbl
    }()
    func updateLabels(nextWorkoutOnly: Bool = false) { //set the label text to be the same as the name of the current workout
        if(!nextWorkoutOnly) {
            self.workoutNameLabel.text = currentWorkout.name
        }
        if (currentWorkout.duration == nil) {
            self.nextWorkoutNameLabel.text = "" //won't be visible but isn't technically hidden
        } else if (nextWorkout.duration != nil) {
            let contin = "Далее:".localized()
            
            self.nextWorkoutNameLabel.text = "\(contin)   \(self.nextWorkout.name)".localized()
        } else {
            self.nextWorkoutNameLabel.text = self.nextWorkout.name
        }
    }
    
    private func advanceWorkout() {
        self.workouts.currentWorkoutIndex += 1 //get the next workout
        self.currentWorkout = workouts.getCurrentWorkout()
        self.nextWorkout = workouts.getNextWorkout()
    }
    
    private func loadDataFromLocalStorage() {
        if (defaults.integer(forKey: restDurationKey) != 0) { //load duration if it exists
            self.restDuration = defaults.integer(forKey: restDurationKey)
        } else {
            defaults.set(restDuration, forKey: restDurationKey)
        }
        
        if (defaults.string(forKey: END_WORKOUT_SOUND_KEY) != nil) { //load sound name if it exists
            workoutEndSoundName = defaults.string(forKey: END_WORKOUT_SOUND_KEY)! //can't be nil here
        } else {
            //workoutEndSoundName = "Tone"
            defaults.set(workoutEndSoundName, forKey: END_WORKOUT_SOUND_KEY)
        }
        
        if (defaults.string(forKey: END_REST_SOUND_KEY) != nil) { //load sound name if it exists
            restEndSoundName = defaults.string(forKey: END_REST_SOUND_KEY)! //can't be nil here
        } else {
            //restEndSoundName = "Tone"
            defaults.set(restEndSoundName, forKey: END_REST_SOUND_KEY)
        }
        
//        if (defaults.float(forKey: TONE_VOLUME_KEY) != 0) {
//            toneVolume = defaults.float(forKey: TONE_VOLUME_KEY)
//        } else {
//            defaults.set(toneVolume, forKey: TONE_VOLUME_KEY)
//        }
    }
    
    
    
    
    //MARK: - Timer and Audio Control
    private func startTimerIfWorkoutExists() { //start the timer for the given duration or end the workout session if the current workout has no duration
        if (currentWorkout.duration != nil) {
            mainPlayer.numberOfLoops = 0
            timerRing.shouldShowValueText = true
            timerRing.startTimer(to: currentWorkout.duration!, handler: self.handleTimer)
        } else { // nil duration signifies being done with all exercises
            mainPlayer.numberOfLoops = 1
            timerRing.shouldShowValueText = false;
            disableAndHideButton(startButton)
            enableAndShowButton(restartButton)
            settingsBtn.isEnabled = true
            workoutViewBtn.isEnabled = true
            
            if !UserDefaults.standard.bool(forKey: "removeAdsPurchased") {
                IronSource.showRewardedVideo(with: self)
            }
        }
    }
    
    
    func audioSessionEnabled(enabled: Bool) {
        if (enabled) {
            do {
                try AVAudioSession.sharedInstance().setActive(true, options: AVAudioSession.SetActiveOptions.notifyOthersOnDeactivation)
            } catch {
                print("Session failed to activate!")
                print("Error occured: \(error)")
            }
        } else {
            do {
                try AVAudioSession.sharedInstance().setActive(false, options: AVAudioSession.SetActiveOptions.notifyOthersOnDeactivation)
            } catch {
                print("Session failed to deactivate! (Session was busy?)")
                print("Error occured: \(error)")
            }
        }
    }
    
    
    private func handleTimer(state: UICircularTimerRing.State?) {
        if case .finished = state { //when the timer finishes, do this...
            timerRing.resetTimer()
            
            
            
            if (workouts.getNextWorkout().duration != nil) {
                restFor(restDuration)
            } else {
                startNextWorkout() //code that must be run regardless of whether there should be a rest
            }
            
        }
    }
    
//MARK: - Used for timer countdown
    private var count:Int = 0
    
//MARK: - Rest Timer Stuff
    private func restFor(_ duration: Int) {
        restTimerLabel.isHidden = false
        restTimerLabel.text = "\(secondsToMinutesSeconds(secondsInput: duration))"
//        restTimerLabel.text = String(duration)
        restTimerLabel.frame = timerRing.frame
        count = duration
        workoutNameLabel.text = "Отдых!".localized()
        timerRing.shouldShowValueText = false
        restTimerLabel.font = UIFont.systemFont(ofSize: 55)
        restTimerLabel.layer.cornerRadius = 20
        restTimerLabel.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        restTimerLabel.layer.shadowRadius = 5
        restTimerLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        restTimerLabel.layer.shadowOpacity = 0.3
        
        let positTop: CGFloat!
        if totalSize.height >= 890 {
            positTop = 285
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positTop = 245
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positTop = 220
        } else if totalSize.height <= 670 {
            positTop = 190
        } else {
            positTop = 285
        }
        restTimerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positTop)
        }
        
        isRestTimerActive = true
        restTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateLabelForCountdown), userInfo: nil, repeats: true)
        
        
        
        if (count >= 0) {
            mainPlayer.numberOfLoops = 0
            timerRing.shouldShowValueText = false
            timerRing.startTimer(to: TimeInterval(count), handler: self.handleTimer)
        } else { // nil duration signifies being done with all exercises
            mainPlayer.numberOfLoops = 1
            timerRing.shouldShowValueText = false;
            disableAndHideButton(startButton)
            enableAndShowButton(restartButton)
            settingsBtn.isEnabled = true
            workoutViewBtn.isEnabled = true
        }
        
        
        startTimerRest()
    }
    
    private func startTimerRest() { //start the timer for the given duration or end the workout session if the current workout has no duration
        
    }
    
    func secondsToMinutesSeconds(secondsInput: Int) -> String {
        let seconds = secondsInput % 60
        let minutes = secondsInput / 60
        if (minutes <= 0) {
            return "\(seconds)"
        } else if (seconds == 0) {
            if (minutes == 1) {
                return "\(minutes)"
            } else {
                return "\(minutes)"
            }
        }
        return "\(minutes) : \(seconds)"
    }
    
    @objc private func updateLabelForCountdown() {
        if (count > 1) {
            count -= 1
//            restTimerLabel.text = String(count)
            restTimerLabel.text = "\(secondsToMinutesSeconds(secondsInput: count))"
        } else {
            restTimerLabel.isHidden = true
            isRestTimerActive = false
            restTimer.invalidate()
            startNextWorkout()
        }
    }
    
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
                self.labelCircleMenuMoveRight.text = "Восстановление после родов".localized()
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
                self.labelCircleMenuMoveRight.text = "Восстановление после родов".localized()
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
    func menuItemSelected(id: Int) {
//        idLabel.text = "id: \(id)"
        selectedItemId = id
        guard id != 100 else {
            return
        }
        print(id)
        
        if id == 0 {
            let vc = MainViewController()
            vc.modalPresentationStyle = .fullScreen

            let transition = CATransition()
            transition.duration = 0.4
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromBottom
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
extension TimerViewController: ISBannerDelegate, ISImpressionDataDelegate, ISRewardedVideoDelegate {
    
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
