//
//  PinConstraints.swift
//  
//
//  Created by Wesley Calazans on 25/04/23.
//

import UIKit

extension UIView {
    public func pin(to superView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superView.topAnchor),
            self.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor),
        ])
    }
}
