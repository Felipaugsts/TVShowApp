//
//  CreatePasswordModel.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 10/10/23.

import UIKit

// MARK: - CreatePasswordModel

enum CreatePasswordModel {
	struct ScreenValues {
        var title: String?
        var placeholder: String?
        var button: String?
	}
    
    struct User: Codable {
        var username: String? = ""
        var name: String? = ""
        var email: String? = ""
        var userUID: String? = ""
    }
}
