//
//  PaymentViewModel.swift
//  PaymentApp
//
//  Created by Тимофей Лукашевич on 20.05.23.
//

import Foundation

enum PaymentStatus {
    case inProgress, success, fail, closed
}

final class PaymentViewModel: ObservableObject {
    @Published var paymentStatus: PaymentStatus = .closed
    @Published var paymentError: PaymentError?
    
    private let paymentService = PaymentService()
    
    func pay(withCard card: Card) {
        paymentStatus = .inProgress
        Task { [weak self] in
            do {
                try await self?.paymentService.payWithCard(card)
                await MainActor.run { [weak self] in
                    self?.paymentError = nil
                    self?.paymentStatus = .success
                }
            } catch(let error) {
                let paymentError = error as? PaymentError ?? .unknown
                await MainActor.run { [weak self] in
                    self?.paymentError = paymentError
                    self?.paymentStatus = .fail
                }
            }
        }
    }
    
    func close() {
        paymentStatus = .closed
        paymentError = nil
    }
    
}
