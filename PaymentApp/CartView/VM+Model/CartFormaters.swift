//
//  CartFormaters.swift
//  PaymentApp
//
//  Created by Тимофей Лукашевич on 20.05.23.
//

import Foundation

final class CartNumberFormater: StringFormater {
    let format: String = "#### #### #### ####"
    let replacementCharacter: Character = "#"
    
    func modify(_ str: String) -> String {
        str.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
            .applyPattern(pattern: format, replacementCharacter: replacementCharacter)
    }
}

final class CartExpireDateFormater: StringFormater {
    let format: String = "##/##"
    let replacementCharacter: Character = "#"
    
    func modify(_ str: String) -> String {
        str.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
            .applyPattern(pattern: format, replacementCharacter: replacementCharacter)
    }
}

final class CartHolderFormater: StringFormater {
    func modify(_ str: String) -> String {
        str.uppercased().replacingOccurrences(of: "[^A-Z ]", with: "", options: .regularExpression)
    }
}

final class CartCVVFormater: StringFormater {
    func modify(_ str: String) -> String {
        String(str.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression).prefix(3))
    }
}
