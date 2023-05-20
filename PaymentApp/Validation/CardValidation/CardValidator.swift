//
//  CardValidator.swift
//  PaymentApp
//
//  Created by Тимофей Лукашевич on 20.05.23.
//

import Foundation

enum CardValidationError: Int, Identifiable {
    case wrongCreditCardNumber = 1
    case wrongCreditCardExpireDate = 2
    case wrongCreditCardHolderName = 3
    case wrongCreditCardCVV = 4
    
    var id: Int {
        self.rawValue
    }
    
    var message: String {
        switch self {
        case .wrongCreditCardNumber:
            return "Invalid credit card number"
        case .wrongCreditCardExpireDate:
            return "Invalid credit card expire date"
        case .wrongCreditCardHolderName:
            return "Invalid credit card holder name"
        case .wrongCreditCardCVV:
            return "Invalid credit card CVV"
        }
    }
}

final class CardValidator {
    
    func validate(_ card: Card) -> [CardValidationError] {
        var errors = [CardValidationError]()
        
        if !validateCardNumber(card.number) {
            errors.append(.wrongCreditCardNumber)
        }
        
        if !validateCardExpireDate(card.expireDate) {
            errors.append(.wrongCreditCardExpireDate)
        }
        
        if !validateCardHolderName(card.holderName) {
            errors.append(.wrongCreditCardHolderName)
        }
        
        if !validateCardCVV(card.cvv) {
            errors.append(.wrongCreditCardCVV)
        }
        
        
        return errors
    }
    
    func validateCardNumber(_ number: String) -> Bool {
        CreditCardNumberValidator(number).isValid
    }
    
    func validateCardExpireDate(_ date: String) -> Bool {
        let regex = #"^((0[1-9])|(1[0-2]))(\\|\/)([0-9]{2})$"#
        let matches = date.matches(for: regex)
        return matches.first == date
    }
    
    func validateCardHolderName(_ name: String) -> Bool {
        let matches = name.matches(for: "[A-Z]+ [A-Z]+")
        return matches.first == name && name.count <= 24
    }
    
    func validateCardCVV(_ cvv: String) -> Bool {
        let matches = cvv.matches(for: "^[0-9]{3,4}$")
        return matches.first == cvv
    }
}


