//
//  UIFont+Extension.swift
//  MinhasDespesas
//
//  Created by Felipe Augusto Silva on 12/10/23.
//

import UIKit

extension UIFont {
    public static func circularBook(size: CGFloat) -> UIFont {
        if let font = UIFont(name: "CircularXX-Book", size: size) {
            return font
        } else {
            // Handle the case where the font couldn't be loaded.
            // You can return a default font or handle the error as needed.
            return UIFont.systemFont(ofSize: size)
        }
    }
    
    public static func circularBold(size: CGFloat) -> UIFont {
        if let font = UIFont(name: "CircularXX-Bold", size: size) {
            return font
        } else {
            // Handle the case where the font couldn't be loaded.
            // You can return a default font or handle the error as needed.
            return UIFont.boldSystemFont(ofSize: size)
        }
    }
}
