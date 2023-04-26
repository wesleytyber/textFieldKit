//
//  ValidatorInputSecure.swift
//  
//
//  Created by Wesley Calazans on 25/04/23.
//

import UIKit

public class ValidatorInputSecure: ValidatorInput {
    
    public lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public lazy var secureButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "eye.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .systemGray
        btn.imageView?.clipsToBounds = true
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(tappedEyeButton), for: .touchUpInside)
        return btn
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureConstraint()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViews()
        configureConstraint()
    }
    
    @objc public func tappedEyeButton() {
        isSecureTextEntry = !isSecureTextEntry
        
        UIView.transition(with: secureButton, duration: 0.2, options: .transitionCrossDissolve) {
            self.isSecureTextEntry
            ? self.secureButton.setImage(UIImage(systemName: "eye.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
            : self.secureButton.setImage(UIImage(systemName: "eye.slash.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
    
}

extension ValidatorInputSecure {
    
    public func configureViews() {
        addSubview(view)
        view.addSubview(secureButton)
    }
    
    public func configureConstraint() {
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 50),
            view.widthAnchor.constraint(equalToConstant: 50),
            view.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            view.rightAnchor.constraint(equalTo: self.rightAnchor),

            secureButton.heightAnchor.constraint(equalToConstant: 50),
            secureButton.widthAnchor.constraint(equalToConstant: 50),
            secureButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            secureButton.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
}
