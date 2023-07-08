//
//  SplashInteractor.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 08/07/23.
//

import Foundation

public protocol SplashInteractor {
    var presenter: SplashPresenter? { get set }
    
    func loadScreenValues()
}

public class SplashInteractorDefault: SplashInteractor {
    
    public var presenter: SplashPresenter?
    
    public init () { }
    
    public func loadScreenValues() {
        presenter?.presentScreenValues()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.presenter?.presentLogin()
        }
    }
}
