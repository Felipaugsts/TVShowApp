//
//  HomeWorker.swift
//  MinhasDespesas
//
//  Created by Felipe Augusto Silva on 24/10/23.
//

import Foundation
import SDKCommon

protocol HomeWorkerLogic {
    func fetchPopularMovies<T: Decodable>(_ model: T.Type, using provider: RequestProvider, completionHandler: @escaping (Result<T, APIError>) -> Void)
}

public class HomeWorker: HomeWorkerLogic {
    
    var service: AuthServiceLogic
    var serviceProvider: ServiceProviderProtocol
    
    init(service: AuthServiceLogic = AuthService(),
         serviceProvider: ServiceProviderProtocol = ServiceProvider.shared) {
        self.service = service
        self.serviceProvider = serviceProvider
    }
    
    func fetchPopularMovies<T: Decodable>(_ model: T.Type, using provider: RequestProvider, completionHandler: @escaping (Result<T, APIError>) -> Void) {
        
        serviceProvider.makeAPIRequest(model, using: provider) { response in
            switch response {
            case .success(let resp):
                completionHandler(.success(resp))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
