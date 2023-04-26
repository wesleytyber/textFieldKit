//
//  ViewCode.swift
//  
//
//  Created by Wesley Calazans on 25/04/23.
//

import Foundation

public protocol ViewCode: AnyObject {
    func initViewCode()
    func configureSubViews()
    func configureAdditionalBehaviors()
    func configureConstraints()
    func configureAccessibility()
}

public extension ViewCode {
    func initViewCode() {
        configureSubViews()
        configureAdditionalBehaviors()
        configureConstraints()
        configureAccessibility()
    }
}

