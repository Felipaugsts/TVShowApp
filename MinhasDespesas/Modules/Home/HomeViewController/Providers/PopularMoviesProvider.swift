//
//  PopularMoviesProvider.swift
//  MinhasDespesas
//
//  Created by Felipe Augusto Silva on 19/10/23.
//

import Foundation
import SDKCommon


class PopularMoviesProvider: APIRequestProvider {
    var isPublic: Bool = false
    
    var module: String = ""
    
    var path: String = "3/movie/popular?language=pt-BR&page=1"
    
    var httpMethod: SDKCommon.RequestHTTPMethod = .get
    
    var body: [String : Any] = [:]
    
    var headers: [String : String] = ["accept": "application/json",
                                      "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NmU4YzExZGIxMDFkMjJlNTQ5MTlhNzAyZmE4NTFiNCIsInN1YiI6IjYyNDQzNzI4NWE5OTE1MDA1ZDVlMDg2MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Od8hpM_wGQ8Kgm4kOjiDxgxWeaQlX9Mbzm0WI1ZtuTg"]
                                    
}
