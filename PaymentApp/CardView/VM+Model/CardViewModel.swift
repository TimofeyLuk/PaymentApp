//
//  CardViewModel.swift
//  PaymentApp
//
//  Created by Тимофей Лукашевич on 20.05.23.
//

import Foundation
import Combine

final class CardViewModel: ObservableObject {
    
    @Published var cardModel = Card()
    @Published var type = ""
    @Published var validationErrors = [CardValidationError]()
    @Published var isCardFilled = false
    
    private var cardNumberSubsribtion: AnyCancellable?
    private var cardValidator = CardValidator()
    
    
    init(model: Card = Card()) {
        self.cardModel = model
        cardNumberSubsribtion =  _cardModel.projectedValue
            .receive(on: DispatchQueue.main)
            .sink { [weak self] card in
                self?.validationErrors = []
                self?.isCardFilled = card.isCardFilled
                self?.type = self?.getType(forCardNumber: card.number) ?? ""
            }
            
    }
    
    private func getType(forCardNumber cardNumber: String) -> String? {
        guard
            let type = CreditCardNumberValidator(cardNumber).type
        else { return nil }
        return type.lable
    }
    
    func validateCard() -> Bool {
        validationErrors = cardValidator.validate(cardModel)
        return validationErrors.isEmpty
    }
    
}

fileprivate extension CreditCardType {
    var lable: String {
        switch self {
        case .amex:
            return "AMEX"
        case .visa:
            return "VISA"
        case .masterCard:
            return "MasterCard"
        case .maestro:
            return "Maestro"
        case .dinersClub:
            return "DinerClub"
        case .jcb:
            return "JCB"
        case .discover:
            return "Discover"
        case .unionPay:
            return "UnionPay"
        case .mir:
            return "МИР"
        }
    }
}
