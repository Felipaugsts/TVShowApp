//
//  WelcomeInteractor.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 08/07/23.
//

import Foundation

public protocol WelcomeInteractorLogic {
    var presenter: WelcomePresenterLogic? { get set }
    
    func loadScreenValues()
}

public class WelcomeInteractor: WelcomeInteractorLogic {
    
    public var presenter: WelcomePresenterLogic?
    
    public init () { }
    
    public func loadScreenValues() {
        presenter?.presentScreenValues()
    }
}
