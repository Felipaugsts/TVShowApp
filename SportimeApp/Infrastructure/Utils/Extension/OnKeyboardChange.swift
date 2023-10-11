//
//  OnKeyboardChange.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 03/10/23.
//

import Foundation
import UIKit
import SDKCommon

protocol ListenKeyboardChanges {
    func listenKeyBoardChangeWith(
        _ panNotification: PanNotificationsService,
        keyboardWillAppear: Selector,
        keyboardWillDisappear: Selector
    )
    
    func customizeViewWhenKeyboardAppear(keyboardHeight: CGFloat)
    func customizeViewWhenKeyboardDisappear()
}

extension ListenKeyboardChanges where Self: UIViewController {
    
    func listenKeyBoardChangeWith(
        _ panNotification: PanNotificationsService,
        keyboardWillAppear: Selector,
        keyboardWillDisappear: Selector
    ) {
        panNotification.addObserver(
            self,
            selector: keyboardWillAppear,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        panNotification.addObserver(
            self,
            selector: keyboardWillDisappear,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    func moveViewWithKeyboard(notification: NSNotification, keyboardWillShow: Bool) {
        
        // Get keyboard's size
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardHeight = keyboardSize.height
        
        // Keyboard's animation duration
        let keyboardDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.0
        
        // Keyboard's animation curve
        guard let keyboardCurve = UIView.AnimationCurve(rawValue: notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int ?? 0) else { return }
        
        // Change the constraints
        if keyboardWillShow {
            customizeViewWhenKeyboardAppear(keyboardHeight: keyboardHeight)
        }
        else {
            customizeViewWhenKeyboardDisappear()
        }
        
        // Animate the view the same way the keyboard animates
        let animator = UIViewPropertyAnimator(duration: keyboardDuration, curve: keyboardCurve) { [weak self] in
            self?.view.layoutIfNeeded()
        }
        
        // Perform the animation
        animator.startAnimation()
    }
}
