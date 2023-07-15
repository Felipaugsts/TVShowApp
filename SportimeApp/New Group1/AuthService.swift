//
//  AuthService.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 15/07/23.
//

import Foundation
import FirebaseAuth

public protocol AuthServiceLogic {
    func authenticate(with email: String, password: String, completion: @escaping (Void?, Error?) -> Void)
}

public class AuthService: AuthServiceLogic {
    
    public init() { }
    
    public func authenticate(with email: String, password: String, completion: @escaping (Void?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { AuthDataResult, Error in
            if Error != nil {
                completion(nil, Error)
            } else if AuthDataResult != nil {
                
                let resp = AuthDataResult?.user
                
                var user = User()
                user.email = resp?.email
                user.name = resp?.displayName
                
                UserRepository.shared.user = user
                
                completion((), nil)
            }
        }
    }
}
