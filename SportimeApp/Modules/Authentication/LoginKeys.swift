//
//  LoginKeys.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 14/09/23.
//

import Foundation
import SDKCommon

public enum LoginKeys {
    public enum Localized: String, Localizable {
        
        case welcomeLogin
        case welcomeRegister
        
        case loginTitle
        case username
        case password
        case confirmButton
        case forgotPassword
        
        public var tableName: String { "LoginKeysValues" }
        public var bundle: Bundle? { Bundle(for: LoginInteractor.self) }
        
    }
}
