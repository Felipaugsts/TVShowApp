//
//  SplashInteractor.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 08/07/23.
//

import Foundation
import SDKCommon

public protocol SplashInteractor {
    var presenter: SplashPresenter? { get set }
    
    func loadScreenValues()
}

public class SplashInteractorDefault: SplashInteractor {
    
    public var presenter: SplashPresenter?
    public var userRepository: UserDataSource
    public var service: AuthServiceLogic
    
    public init (userRepository: UserDataSource = UserRepository.shared,
                 service: AuthServiceLogic = AuthService()) {
        self.userRepository = userRepository
        self.service = service
    }
    
    public func loadScreenValues() {
        presenter?.presentScreenValues()

        isUserSignedIn()
    }
    
    private func isUserSignedIn() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if self.userRepository.user != nil && self.service.isUserAuthenticated() {
                self.presenter?.presentHomeView()
                return
            }
            
            self.presenter?.presentLogin()
        }
    }
}
