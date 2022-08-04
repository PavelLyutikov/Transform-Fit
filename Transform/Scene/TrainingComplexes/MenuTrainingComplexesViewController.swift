//
//  MenuTrainingComplexesViewController.swift
//  Transform
//
//  Created by Pavel Lyutikov on 02.06.2021.
//

import UIKit
import SnapKit

//временно не используется, так как тренировки только HomeWorkout, сразу переход на HomeWorkoutTreining

class MenuTrainingComplexesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        
        homeWorkoutTrainingButton.addTarget(self, action: #selector(homeWorkoutTrainingButtonAction(sender:)), for: .touchUpInside)
    }
    
    lazy var homeWorkoutTrainingButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Фитнес дома", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        btn.backgroundColor = #colorLiteral(red: 0.158110857, green: 0.6528071761, blue: 0.6134576201, alpha: 1)
        btn.layer.cornerRadius = 10
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.5
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(280)
            make.height.equalTo(100)
        }
        
        return btn
    }()
    @objc func homeWorkoutTrainingButtonAction(sender: UIButton) {
        
        sender.zoomOut()
        
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
}
