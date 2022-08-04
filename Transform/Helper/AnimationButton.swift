//
//  AnimationButton.swift
//  Transform
//
//  Created by Pavel Lyutikov on 14.03.2021.
//

import UIKit

class AnimationButton: UIView {

}

extension UIView {

    func zoomCircleMenuIn(duration: TimeInterval = 0.3) {
        self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = .identity
            }) { (animationCompleted: Bool) -> Void in
        }
    }
    func zoomCircleMenuOut(duration: TimeInterval = 0.8) {
        self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = .identity
            }) { (animationCompleted: Bool) -> Void in
        }
    }
    
    func zoomIn(duration: TimeInterval = 0.2) {
        self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = .identity
            }) { (animationCompleted: Bool) -> Void in
        }
    }

    func zoomOut(duration : TimeInterval = 0.4) {
        self.transform = .identity
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }) { (animationCompleted: Bool) -> Void in
        }
    }
    func zoomOutClose(duration : TimeInterval = 0.4) {
        self.transform = .identity
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }) { (animationCompleted: Bool) -> Void in
        }
    }
    
    func zoomInInfo(duration: TimeInterval = 0.4) {
        self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = .identity
            self.alpha = 1
            }) { (animationCompleted: Bool) -> Void in
        }
    }
    
    func zoomOutInfo(duration : TimeInterval = 0.3) {
        self.transform = .identity
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            self.alpha = 0
            }) { (animationCompleted: Bool) -> Void in
        }
    }
    func zoomInCircleMenu(duration: TimeInterval = 0.1) {
        self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = .identity
            self.alpha = 1
            }) { (animationCompleted: Bool) -> Void in
        }
    }
    
    func zoomOutCircleMenu(duration : TimeInterval = 0.1) {
        self.transform = .identity
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.alpha = 0
            }) { (animationCompleted: Bool) -> Void in
        }
    }
    func zoomInBackCircleMenu(duration: TimeInterval = 0.1) {
        self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = .identity
            self.alpha = 0.7
            }) { (animationCompleted: Bool) -> Void in
        }
    }
    
    func zoomOutBackCircleMenu(duration : TimeInterval = 0.1) {
        self.transform = .identity
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            self.alpha = 0
            }) { (animationCompleted: Bool) -> Void in
        }
    }
    func fadeLeft(duration : TimeInterval = 0.3) {
        self.transform = .identity
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = CGAffineTransform(translationX: -200, y: 0)
            self.alpha = 0
            }) { (animationCompleted: Bool) -> Void in
        }
    }
    func alphaLeft(duration : TimeInterval = 0.3) {
        self.transform = .identity
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = CGAffineTransform(translationX: -200, y: 0)
            self.alpha = 1
            }) { (animationCompleted: Bool) -> Void in
        }
    }
    func fadeRightLabelMenu(duration : TimeInterval = 0.1) {
        self.transform = .identity
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = CGAffineTransform(translationX: 10, y: 0)
            self.alpha = 0
            }) { (animationCompleted: Bool) -> Void in
        }
    }
    func fadeLeftLabelMenu(duration : TimeInterval = 0.1) {
        self.transform = .identity
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = CGAffineTransform(translationX: -10, y: 0)
            self.alpha = 0
            }) { (animationCompleted: Bool) -> Void in
        }
    }
    func alphaRightLabelMenu(duration : TimeInterval = 0.1) {
        self.transform = .identity
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = CGAffineTransform(translationX: 10, y: 0)
            self.alpha = 1
            }) { (animationCompleted: Bool) -> Void in
        }
    }
    func alphaLeftLabelMenu(duration : TimeInterval = 0.1) {
        self.transform = .identity
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = CGAffineTransform(translationX: -10, y: 0)
            self.alpha = 1
            }) { (animationCompleted: Bool) -> Void in
        }
    }
    func fade(duration : TimeInterval = 0.3) {
        self.transform = .identity
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.alpha = 0
            }) { (animationCompleted: Bool) -> Void in
        }
    }
    func alpha(duration : TimeInterval = 0.3) {
        self.transform = .identity
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.alpha = 1
            }) { (animationCompleted: Bool) -> Void in
        }
    }
    
    func zoomInSuccess(duration: TimeInterval = 0.3) {
        self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = .identity
            self.alpha = 1
            }) { (animationCompleted: Bool) -> Void in
        }
    }
    
    func zoomOutSuccess(duration : TimeInterval = 0.4) {
        self.transform = .identity
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            self.alpha = 0
            }) { (animationCompleted: Bool) -> Void in
        }
    }
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0

        layer.add(pulse, forKey: "pulse")
    }

        func flash() {

        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.2
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3

        layer.add(flash, forKey: nil)
        }

        func shake() {

        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.05
        shake.repeatCount = 2
        shake.autoreverses = true

        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)

        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)

        shake.fromValue = fromValue
        shake.toValue = toValue

        layer.add(shake, forKey: "position")
    }
        
    func buttonDown() {

        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.allowUserInteraction, .curveEaseIn], animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: nil)
    }

    func buttonUp() {

        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.allowUserInteraction, .curveEaseOut], animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
        
    }
    
    func rotate() {
            let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotation.toValue = NSNumber(value: Double.pi * 2)
            rotation.duration = 3
            rotation.isCumulative = true
            rotation.repeatCount = Float.greatestFiniteMagnitude
            self.layer.add(rotation, forKey: "rotationAnimation")
        }

}
