//
//  BasicCircleMenuButton.swift
//  CircleMenu
//
//  Created by Pavel Chehov on 08/11/2018.
//

import UIKit

public class BasicCircleMenuButton : UIButton {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        layer.shadowColor = UIColor.black.cgColor //BackgroundIcon
        layer.shadowOffset = CGSize(width: 6, height: 6)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.4
        layer.zPosition = 101
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        layer.cornerRadius = frame.height / 2
    }
}
