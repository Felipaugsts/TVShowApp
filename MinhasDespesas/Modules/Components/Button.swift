//
//  Button.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 15/07/23.
//

import UIKit
import SDKCommon

class Button: UIButton, Themeable {
    var theme: SDKCommon.PanTheme = .primary {
        didSet {
            setTheme()
        }
    }
    
    func setTheme(_ isPressed: Bool = false) {
        switch theme {
        case .primary:
            backgroundColor = DSColor.primary
            tintColor = DSColor.lightest
        case .black:
            backgroundColor = DSColor.secondaryDark
            tintColor = DSColor.lightest
        case .negative:
            backgroundColor = DSColor.negative
            tintColor = DSColor.lightest
        case .green:
            backgroundColor = DSColor.positive
            tintColor = DSColor.lightest
        case .white:
            backgroundColor = DSColor.lightest
            tintColor = DSColor.secondaryDark
        case .secondary:
            backgroundColor = DSColor.secondary
            tintColor = DSColor.lightest
        }
    }
    
    public var rounded: CGFloat = 0 {
        didSet {
            layer.cornerRadius = rounded
        }
    }
    
    private var originalTitle: String?
    private var loadingIndicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        originalTitle = title(for: .normal)
        theme = .primary
        
        titleLabel?.font = .circularBook(size: 16)
        loadingIndicator = UIActivityIndicatorView(style: .medium)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.color = .white
        loadingIndicator.hidesWhenStopped = true
        addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setButtonTitle(title: String?) {
        originalTitle = title
        setTitle(title, for: .normal)
    }
    
    func startLoading() {
        setTitle(nil, for: .normal)
        isEnabled = false
        loadingIndicator.startAnimating()
    }
    
    func stopLoading() {
        setTitle(originalTitle, for: .normal)
        isEnabled = true
        loadingIndicator.stopAnimating()
    }
}
