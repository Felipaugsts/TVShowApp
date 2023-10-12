//
//  ModuleScreen.swift
//  MinhasDespesas
//
//  Created by Felipe Augusto Silva on 12/10/23.
//

import UIKit
import SnapKit
import Lottie
import SDKCommon

public protocol ModuleScreenProtocol: AnyObject {
    func didTapPrimary()
    func didTapSecondary()
}

class ModuleScreen: UIView {
    
    lazy var animationView: LottieAnimationView = {
       var view = LottieAnimationView()
        view = .init(name: "error404")
        view.loopMode = .playOnce
        view.translatesAutoresizingMaskIntoConstraints = false
        view.play()
        return view
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = .circularBold(size: 32)
        return label
    }()
    
    private var labelSubtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = .circularBook(size: 16)
        return label
    }()
    
    lazy var primaryButton: Button = {
       let button = Button()
        button.tintColor = DSColor.lightest
        button.backgroundColor = DSColor.primary
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(self, action: #selector(confirmButton), for: .touchUpInside)
        return button
    }()
    
    lazy var secondButton: Button = {
       let button = Button()
        button.tintColor = DSColor.lightest
        button.backgroundColor = DSColor.primary
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var delegate: ModuleScreenProtocol?
    
    init(image: String, labelText: String, labelSubtitle: String?, button: String, secondaryButton: String) {
        super.init(frame: .zero)
        
        setupUI()
        
        animationView = .init(name: image)
        label.text = labelText
        self.labelSubtitle.text = labelSubtitle
        primaryButton.setButtonTitle(title: button)
        secondButton.setButtonTitle(title: secondaryButton)
        addActions()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func addActions() {
        primaryButton.addAction {
            self.delegate?.didTapPrimary()
        }
        
        secondButton.addAction {
            self.delegate?.didTapSecondary()
        }
    }
    
    private func setupUI() {
        
        addSubview(animationView)
        addSubview(label)
        addSubview(labelSubtitle)
        addSubview(primaryButton)
        addSubview(secondButton)
        
        animationView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20) // Add top padding
            make.width.height.equalTo(100)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(animationView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        labelSubtitle.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        primaryButton.snp.makeConstraints { make in
            make.top.equalTo(labelSubtitle.snp.bottom).offset(50)
            make.height.height.equalTo(50)
            make.leading.equalTo(self).offset(32)
            make.trailing.equalTo(self).offset(-32)
        }
        
        secondButton.snp.makeConstraints { make in
            make.top.equalTo(primaryButton.snp.bottom).offset(10)
            make.leading.equalTo(self).offset(32)
            make.height.height.equalTo(50)
            make.trailing.equalTo(self).offset(-32)
            make.bottom.equalToSuperview()
        }
    }
}
