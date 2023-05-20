//
//  CreditCardType.swift
//  PaymentApp
//
//  Created by Тимофей Лукашевич on 20.05.23.
//

import Foundation

enum CreditCardType: String, CaseIterable{
    case amex = "^3[47][0-9]{5,}$"
    case visa = "^4[0-9]{6,}$"
    case masterCard = "^(?:5[1-5][0-9]{2}|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[0-9]{12}$"
    case maestro = "^(?:5[0678]\\d\\d|6304|6390|67\\d\\d)\\d{8,15}$"
    case dinersClub = "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$"
    case jcb = "^(?:2131|1800|35[0-9]{3})[0-9]{3,}$"
    case discover = "^6(?:011|5[0-9]{2})[0-9]{3,}$"
    case unionPay = "^62[0-5]\\d{13,16}$"
    case mir = "^2[0-9]{6,}$"

    /// Possible C/C number lengths for each C/C type
    /// reference: https://en.wikipedia.org/wiki/Payment_card_number
    var validNumberLength: IndexSet {
        switch self {
        case .visa:
            return IndexSet([13,16])
        case .amex:
            return IndexSet(integer: 15)
        case .maestro:
            return IndexSet(integersIn: 12...19)
        case .dinersClub:
            return IndexSet(integersIn: 14...19)
        case .jcb, .discover, .unionPay, .mir:
            return IndexSet(integersIn: 16...19)
        default:
            return IndexSet(integer: 16)
        }
    }
}
