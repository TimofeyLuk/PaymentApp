//
//  CardFormaters.swift
//  PaymentApp
//
//  Created by Тимофей Лукашевич on 20.05.23.
//

import Foundation

final class CardNumberFormater: StringFormater {
    let format: String = "#### #### #### #### ####"
    let replacementCharacter: Character = "#"
    
    func modify(_ str: String) -> String {
        str.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
            .applyPattern(pattern: format, replacementCharacter: replacementCharacter)
    }
}

final class CardExpireDateFormater: StringFormater {
    let format: String = "##/##"
    let replacementCharacter: Character = "#"
    
    func modify(_ str: String) -> String {
        str.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
            .applyPattern(pattern: format, replacementCharacter: replacementCharacter)
    }
}

final class CardHolderFormater: StringFormater {
    func modify(_ str: String) -> String {
        String(str.uppercased().replacingOccurrences(of: "[^A-Z ]", with: "", options: .regularExpression).prefix(24))
    }
}

final class CardCVVFormater: StringFormater {
    func modify(_ str: String) -> String {
        String(str.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression).prefix(4))
    }
}
