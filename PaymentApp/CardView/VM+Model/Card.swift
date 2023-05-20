//
//  Card.swift
//  PaymentApp
//
//  Created by Тимофей Лукашевич on 20.05.23.
//

import Foundation

struct Card {
    var number: String = ""
    var holderName: String = ""
    var expireDate: String = ""
    var cvv: String = ""
    
    var isCardFilled: Bool {
        let isNumberFilled = number.count >= 12
        let iHoldernameFilled = !holderName.isEmpty
        let isExpireDateFilled = expireDate.count == 5
        let isCVVFilled = cvv.count >= 3
        return isNumberFilled && iHoldernameFilled && isExpireDateFilled && isCVVFilled
    }
}
