//
//  UIButton+Extension.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 03/10/23.
//

import UIKit

extension UIButton {
    func addAction(_ action: @escaping () -> Void, for controlEvents: UIControl.Event = .touchUpInside) {
        let actionHandler = ActionHandler(action)
        addTarget(actionHandler, action: #selector(ActionHandler.handleAction), for: controlEvents)
        objc_setAssociatedObject(self, &AssociatedKeys.ActionHandlerKey, actionHandler, .OBJC_ASSOCIATION_RETAIN)
    }
}

private struct AssociatedKeys {
    static var ActionHandlerKey = "ActionHandlerKey"
}

private class ActionHandler {
    typealias Action = () -> Void
    var action: Action
    
    init(_ action: @escaping Action) {
        self.action = action
    }
    
    @objc func handleAction() {
        action()
    }
}
