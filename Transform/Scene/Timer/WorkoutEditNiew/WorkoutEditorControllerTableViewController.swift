//
//  WorkoutEditorControllerTableViewController.swift
//  10MinWorkout
//
//  Created by Gavin Ryder on 8/15/20.
//  Copyright © 2020 Gavin Ryder. All rights reserved.
//

import UIKit
import Foundation

//MARK: - Font Extension for Italic and Bold
extension UIFont {
	func withTraits(traits:UIFontDescriptor.SymbolicTraits) -> UIFont {
		let descriptor = fontDescriptor.withSymbolicTraits(traits)
		return UIFont(descriptor: descriptor!, size: 0) //size 0 means keep the size as it is
	}
	
	func boldYgWorkt() -> UIFont {
		return withTraits(traits: .traitBold)
	}
	
	func italic() -> UIFont {
		return withTraits(traits: .traitItalic)
	}
	
}

//MARK: - Double Extension for No Decimals
extension Double {
	var clean: String {
		return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
	}
}


//MARK: - Cell extension for "disabled" look
extension UITableViewCell {
	func appearsEnabled(_ enabled: Bool) {
		for view in contentView.subviews {
			view.isUserInteractionEnabled = enabled
			view.alpha = enabled ? 1 : 0.5
		}
	}
}

//MARK: - Class
class WorkoutEditorControllerTableViewController: UITableViewController, UITextFieldDelegate {
	
    let totalSize = UIScreen.main.bounds.size
    
	private var isInitialized = false
	private var shouldAlert = true
    private let cellFontMedium = UIFont.systemFont(ofSize: 18)
	private let cellFontRegular = UIFont.systemFont(ofSize: 18)

	
	private let WorkoutsMaster: Workouts = Workouts.shared
	
	var VCMaster: TimerViewController = TimerViewController()
	var reorderTableView: LongPressReorderTableView!
	
	private var workoutList:[Workouts.Workout] = [] {
		didSet {
			if (isInitialized) {
				self.WorkoutsMaster.allWorkouts = self.workoutList
			}
		}
	}
    //ironSource
    var bannerView: ISBannerView! = nil
    let kAPPKEY = "11dfcc91d"
	
	//MARK: - Properties
	@IBOutlet weak var addButton: UIBarButtonItem!
	
	//MARK: - Text Input Input Restriction via Delegate
	func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string:String) -> Bool { //restrict fields using this class as a delegate
		
		let allowedChars = "1234567890" //only numerical digits
		let allowedCharSet = CharacterSet(charactersIn: allowedChars)
		let typedCharSet = CharacterSet(charactersIn: string)
		return allowedCharSet.isSuperset(of: typedCharSet)
	}
	
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
		return " \(minutes) \(min) : \(seconds) \(sec)"
	}
	
	//MARK: - View Overrides
	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.setNavigationBarHidden(false, animated: false)
		
		setUpTableViewHeader()
        
        
		if (!WorkoutsMaster.allWorkouts.isEmpty) {
			setUpTableViewFooter()

		}
	}
	
	
	override func viewWillDisappear(_ animated: Bool) {
		//self.navigationController?.navigationBar.setIsHidden(true, animated: false)
	}
	
	//MARK: - View Did Load
	override func viewDidLoad() {
		super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		
        emptyTableViewLabel.isHidden = false
        
		self.workoutList = WorkoutsMaster.allWorkouts
		reorderTableView = LongPressReorderTableView(self.tableView)
		reorderTableView.enableLongPressReorder()
		reorderTableView.delegate = self
		self.isInitialized = true
		self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        
        infoButton.addTarget(self, action: #selector(buttonInfoAction(sender:)), for: .touchUpInside)
        
        //Ads
        if !UserDefaults.standard.bool(forKey: "removeAdsPurchased") {
            setupIronSourceSdk()
            loadBanner()
        }
        
//MARK: - Swipe
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeRight.direction = .right
            self.view.addGestureRecognizer(swipeRight)
    
	}
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                backTapped()
//                self.dismiss(animated: true, completion: nil)
                print("Swiped right")
            case .down:
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
    
//MARK: - IronSource
    func loadBanner() {
        let BNSize: ISBannerSize = ISBannerSize(description: "BANNER", width: Int(self.view.frame.size.width), height: 50)
           IronSource.loadBanner(with: self, size: BNSize)
        UserDefaults.standard.set(true, forKey: "bannerLoaded")
    }
    func setupIronSourceSdk() {

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
//MARK: - BackgroundInfo
lazy var backgroundInfo: UIImageView = {
    
    var image = UIImageView(image: #imageLiteral(resourceName: "infoBackgroundTurquoise"))
//        image.clipsToBounds = true
    image.contentMode = .scaleAspectFit
    image.layer.zPosition = 8
    image.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    image.layer.shadowRadius = 20
    image.layer.shadowOffset = CGSize(width: 0, height: 0)
    image.layer.shadowOpacity = 0.6
    self.view.addSubview(image)
    
    image.snp.makeConstraints { make in
        make.center.equalToSuperview()
        make.leading.trailing.equalToSuperview().inset(40)
    }
    return image
}()
//MARK: - InfoLabel
    lazy var infoLabel: UILabel = {
       let lbl = UILabel()
        lbl.text = "Проведите пальцем вправо, чтобы отредактировать ячейку или удалить \n \nДлительное нажатие ячейки для перестановки".localized()
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lbl.layer.zPosition = 20
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        self.view.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(50)
        }
        
        return lbl
    }()
//MARK: InfoButton
    @objc lazy var infoButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "informationWorkout"), for: .normal)
        btn.layer.zPosition = 4
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 3
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.4
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)
        
        return btn
    }()
    @objc func buttonInfoAction(sender: UIButton) {
        backgroundInfo.isHidden = false
        backgroundInfo.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.4) {
            self.backgroundInfo.transform = CGAffineTransform.identity
            self.backgroundInfo.alpha = 1
        }
        
        infoLabel.isHidden = false
        infoLabel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.4) {
            self.infoLabel.transform = CGAffineTransform.identity
            self.infoLabel.alpha = 1
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
        let positX: CGFloat!
        if totalSize.height >= 920 {
            positX = 240
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positX = 235
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = 220
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = 168
        } else if totalSize.height <= 670 {
            positX = 160
        } else {
            positX = 215
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "cancelWhite"), for: .normal)
        btn.layer.zPosition = 100
        btn.alpha = 0
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(55)
            make.top.equalToSuperview().inset(positX)
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
            self.infoLabel.isHidden = true
        }
        infoLabel.zoomOutInfo()
        
        closeInfoButton.zoomOutInfo()
        
        self.closeInfoButton.isHidden = true
        
        infoButton.isHidden = false
    }
    
	@objc func buttonAction() {
		showClearAlert()
	}
	
	func reloadTableViewDataAnimated(animation: UITableView.RowAnimation = .fade) {
		self.tableView.reloadSections(IndexSet(0..<tableView.numberOfSections), with: animation)
	}
	
	func showClearAlert() {
        let alert = UIAlertController(title: "Очистить список?".localized(), message: "Все записи будут удалены!".localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Очистить".localized(), style: .destructive, handler: { (clearAction) in
            self.emptyTableViewLabel.isHidden = false
            
			self.workoutList.removeAll()
			self.reloadTableViewDataAnimated()
			self.tableView.tableFooterView?.setIsHidden(true, animated: true)
			//self.VCMaster.currentWorkout = self.WorkoutsMaster.getCurrentWorkout()
			//self.VCMaster.nextWorkout = self.WorkoutsMaster.getNextWorkout()
		}))
		
        alert.addAction(UIAlertAction(title: "Отмена".localized(), style: .cancel, handler: { (cancelAction) in
		}))
		self.present(alert, animated: true)
	}
	
	//MARK: - View customization and UI Event handling
	private func setUpTableViewHeader(){
		//self.navigationController?.navigationBar.isHidden = false
		self.navigationController?.navigationBar.setIsHidden(false, animated: true)
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.isTranslucent = false
//		self.navigationController?.navigationBar.barTintColor = tableGradient.startColor
		self.navigationController?.view.backgroundColor = .white
		self.navigationController?.navigationBar.tintColor = .black
		navigationItem.hidesBackButton = false
		//navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done,target: self, action: #selector(backTapped))
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: 350, height: 30))
		label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 19)
		label.textAlignment = .center
		label.numberOfLines = 2
        label.text = "Моя тренировка".localized()
		
		label.textColor = .black
		
		self.navigationItem.titleView = label
		addButton.action = #selector(self.addCellTapped)
		addButton.target = self
		self.navigationController?.navigationBar.setIsHidden(false, animated: true)
	}
//MARK: - ClearWorkoutsButton
	private func setUpTableViewFooter() {
        emptyTableViewLabel.isHidden = true
        
		let customFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
		customFooterView.backgroundColor = .clear

		let clearWorkoutsButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 150))
		clearWorkoutsButton.backgroundColor = #colorLiteral(red: 0.1674883962, green: 0.6921558976, blue: 0.6487865448, alpha: 1)
        clearWorkoutsButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
		clearWorkoutsButton.setTitleColor(.white, for: .normal)
        clearWorkoutsButton.setTitle("Очистить список".localized(), for: .normal)
        clearWorkoutsButton.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        clearWorkoutsButton.layer.shadowRadius = 5
        clearWorkoutsButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        clearWorkoutsButton.layer.shadowOpacity = 0.3
        
		clearWorkoutsButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
		roundButton(button: clearWorkoutsButton)
		customFooterView.addSubview(clearWorkoutsButton)
        customFooterView.addSubview(infoButton)
		self.tableView.tableFooterView = customFooterView

        
		clearWorkoutsButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			clearWorkoutsButton.widthAnchor.constraint(equalToConstant: 200),
            clearWorkoutsButton.heightAnchor.constraint(equalToConstant: 50),
            clearWorkoutsButton.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor),
			clearWorkoutsButton.centerYAnchor.constraint(equalTo: customFooterView.centerYAnchor)
		])
        
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoButton.widthAnchor.constraint(equalToConstant: 40),
            infoButton.heightAnchor.constraint(equalToConstant: 40),
            infoButton.trailingAnchor.constraint(equalTo: self.tableView.trailingAnchor, constant: -20),
            infoButton.topAnchor.constraint(equalTo: customFooterView.topAnchor, constant: 30)
        ])
	}
    
    lazy var emptyTableViewLabel: UILabel = {
        let positionX: CGFloat!
        if totalSize.height >= 830 {
            positionX = 200
        } else if totalSize.height <= 800 {
            positionX = 195
        } else {
            positionX = 200
        }
        
       let lbl = UILabel()
        lbl.text = "Ваш список упражнений пуст, нажмите на + в правом углу чтобы добавить упражнение".localized()
        lbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 19)
        lbl.textAlignment = .center
        lbl.numberOfLines = 5
        self.view.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positionX)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(80)
            make.trailing.equalToSuperview().inset(80)
        }
        return lbl
    }()
    private func roundButton(button:UIButton) { //round the corners of the button passed in
        button.layer.cornerRadius = 25
//        button.clipsToBounds = true
    }
	
//MARK: - ButtonBack
	@objc func backTapped(){
		navigationController?.popToRootViewController(animated: true)
	}
//MARK: - Add Cells
	@objc func addCellTapped() {
        let alert = UIAlertController(title: "", message: "Добавить упражнение".localized(), preferredStyle: .alert)
		alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Название упражнения".localized()
		})
		
		alert.addTextField(configurationHandler: { (numberField) in
			numberField.keyboardType = .numberPad
			numberField.delegate = self //should restrict to nums only
            numberField.placeholder = "Продолжительность (сек)".localized()
		})
		
        alert.addAction(UIAlertAction(title: "Добавить".localized(), style: .default, handler: { (updateAction) in
			let wasEmpty = self.workoutList.isEmpty
			let durationInput = alert.textFields![1].text!
			var newWorkout:Workouts.Workout
			newWorkout = Workouts.Workout(duration: Double(durationInput), name: alert.textFields!.first!.text!) //input should be numeric only
			self.workoutList.append(newWorkout)
			self.VCMaster.currentWorkout = self.WorkoutsMaster.getCurrentWorkout()
			self.VCMaster.nextWorkout = self.WorkoutsMaster.getNextWorkout()
			if (wasEmpty) {
				self.setUpTableViewFooter()
			}
			self.tableView.reloadData()
			self.tableView.tableFooterView?.setIsHidden(false, animated: true)
		}))
        alert.addAction(UIAlertAction(title: "Отмена".localized(), style: .cancel, handler: nil))
		self.present(alert, animated: true)
	}
	
	
	
	// MARK: - Table View Data Source Config
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return WorkoutsMaster.numWorkouts()
	}
	
	
	
	//MARK: - Initialize Cells
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
		tableView.separatorColor = UIColor(red:0.18, green:0.18, blue:0.18, alpha:0.5)
		let cellIdentifier = "WorkoutCell"
		
		let currentWorkoutName = WorkoutsMaster.getCurrentWorkout().name
		let indexWorkoutName = WorkoutsMaster.allWorkouts[indexPath.row].name
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? WorkoutCellTableViewCell else {
			fatalError("Dequeued cell not an instance of WorkoutCell")
		}
		if (currentWorkoutName == indexWorkoutName) {
			cell.workoutLabel.font = cellFontMedium //make the font bold?
		} else if (indexPath.row < WorkoutsMaster.currentWorkoutIndex) {
			cell.appearsEnabled(false) //give the cell the "disabled" look
		} else {
			cell.workoutLabel.font = cellFontRegular
		}
		cell.workoutLabel.textColor = .black
		
		cell.backgroundColor = .clear
		
		let name = workoutList[indexPath.row].name
		let duration = workoutList[indexPath.row].duration
		let num:Double = Double(duration ?? -1.0)
		let durationAsInt: Int = Int(num)
		var combinedText:String
		if (duration != nil) {
			combinedText = "\(name) - \(secondsToMinutesSeconds(secondsInput: durationAsInt))"
		} else {
			combinedText = "\(name)"
		}
		cell.workoutLabel.text = combinedText
		return cell
	}
	
	
	
//MARK: - Enable Cell Editing
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		if (VCMaster.timerInitiallyStarted) {
			return indexPath.row != WorkoutsMaster.currentWorkoutIndex
		} else {
			return true
		}
	}
	
//MARK: - SwipeCellTableView
	override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		//self.list = PeriodNames.getPeriodNames()
		let editAction = UIContextualAction(style: .normal, title: "", handler: { (action, view, boolValue) in
            let alert = UIAlertController(title: "", message: "Редактировать упражнение".localized(), preferredStyle: .alert)
			alert.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "Название упражнения".localized()
				textField.text = self.workoutList[indexPath.row].name
			})
			
			alert.addTextField(configurationHandler: { (numberField) in
                numberField.placeholder = "Продолжительность (сек)".localized()
				numberField.keyboardType = .numberPad
				numberField.delegate = self //restricts input to numeric only
				let durationAsDouble:Double = Double(self.workoutList[indexPath.row].duration ?? 0)
				numberField.text = String(durationAsDouble.clean)
			})
			
            alert.addAction(UIAlertAction(title: "Обновить".localized(), style: .default, handler: { (updateAction) in
				let durationInput = alert.textFields!.last!.text!
				let nameInput = alert.textFields!.first!.text!
				if (!(alert.textFields?.first?.text?.isEmpty ?? true) && !(alert.textFields?.last?.text?.isEmpty ?? true)) {
					self.workoutList[indexPath.row].name = nameInput
					self.workoutList[indexPath.row].duration = Double(durationInput) //input should be numeric only via delegate
					//self.VCMaster.resetAll()
					self.VCMaster.currentWorkout = self.WorkoutsMaster.getCurrentWorkout()
					self.VCMaster.nextWorkout = self.WorkoutsMaster.getNextWorkout()
					self.tableView.reloadRows(at: [indexPath], with: .left)
					self.updateCellStyles()
                    self.tableView.reloadData()
				} else {
					self.tableView.cellForRow(at: indexPath)?.shake(duration: 0.5, pathLength: 30)
				}
			}))
            alert.addAction(UIAlertAction(title: "Отмена".localized(), style: .cancel, handler: nil))
			self.present(alert, animated: false)
			
		})
        editAction.image = #imageLiteral(resourceName: "edit")
        editAction.backgroundColor = #colorLiteral(red: 0.1562540944, green: 0.6850157823, blue: 0.6430352619, alpha: 1)
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить".localized(), handler: { (action, view, boolValue) in
			self.workoutList.remove(at: indexPath.row)
			self.VCMaster.resetAll()
			self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
            
		})
        deleteAction.image = #imageLiteral(resourceName: "trash")
        deleteAction.backgroundColor = #colorLiteral(red: 0.780459702, green: 0.2858942747, blue: 0.286295712, alpha: 1)
        
		let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        swipeActions.performsFirstActionWithFullSwipe = false
        
		return swipeActions
	}
	
	
	//MARK: - Define Delete Behavior [UNUSED]
	
	override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
		return false
	}
	
	private func updateCellStyles() {
		var counter = 0
		let currentWorkoutIndex = WorkoutsMaster.currentWorkoutIndex
		let currentWorkoutName = WorkoutsMaster.getCurrentWorkout().name
		
		for cell in tableView.visibleCells as! [WorkoutCellTableViewCell] { //no end row passed
			let cellWorkoutName = WorkoutsMaster.allWorkouts[counter].name
			if (counter < currentWorkoutIndex) {
				cell.appearsEnabled(false)
				counter += 1
			} else if (counter == currentWorkoutIndex && currentWorkoutName == cellWorkoutName) {
				cell.workoutLabel.textColor = .black
				cell.workoutLabel.font = cellFontMedium
				counter += 1
			} else {
				cell.workoutLabel.textColor = .black
				cell.workoutLabel.font = cellFontRegular
				counter += 1
			}
		}
	}
    
    override func reorderFinished(initialIndex: IndexPath, finalIndex: IndexPath) {
        workoutList.swapAt(initialIndex.row, finalIndex.row)
        updateCellStyles()
        VCMaster.currentWorkout = WorkoutsMaster.getCurrentWorkout()
        VCMaster.nextWorkout = WorkoutsMaster.getNextWorkout()
        if (!VCMaster.isRestTimerActive) {
            VCMaster.updateLabels()
        } else {
            VCMaster.updateLabels(nextWorkoutOnly: true)
        }
        
    }
    
    override func allowChangingRow(atIndex: IndexPath) -> Bool{
        if (atIndex.row <= WorkoutsMaster.currentWorkoutIndex && VCMaster.timerInitiallyStarted) {
            return false
        } else {
            return true
        }
    }
	
}

//MARK: - ExtensionIronSource
extension WorkoutEditorControllerTableViewController: ISBannerDelegate, ISImpressionDataDelegate {
    
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
