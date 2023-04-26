//
//  Validate.swift
//  
//
//  Created by Wesley Calazans on 25/04/23.
//

import Foundation

public enum ValidateType: Int {
    case none
    case email
    case password
}

public class Validate {
    static let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    static let passwordPattern = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$"
    
    public class func text(_ text: String, type: ValidateType) -> Bool {
        let t = text
        var pattern = ""
        let extra = true
        
        switch type {
        case .email:
            pattern = emailPattern
        case .password:
            pattern = passwordPattern
        case .none:
            return true
        }
        
        let range = NSRange(location: 0, length: t.count)
        guard let regex = try? NSRegularExpression(pattern: pattern,
                                                   options: NSRegularExpression.Options()) else { return false }
        let valid = regex.firstMatch(in: t, options: NSRegularExpression.MatchingOptions(), range: range) != nil
        
        return valid && extra
    }
}

