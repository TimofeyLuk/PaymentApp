//
//  PaymentService.swift
//  PaymentApp
//
//  Created by Тимофей Лукашевич on 20.05.23.
//

import Foundation
import Combine

final class PaymentService {
    
    private var isNetworkAvalable: Bool = false
    private var isNetworkAvalableSubscription: AnyCancellable?
    
    init() {
        isNetworkAvalableSubscription = NetworkMonitor.shared.isReachablePublisher
            .receive(on: DispatchQueue.global(qos: .userInitiated))
            .sink { [weak self] isNetworkAvalable in
                self?.isNetworkAvalable = isNetworkAvalable
            }
    }
    
    deinit {
        isNetworkAvalableSubscription?.cancel()
    }
    
    func payWithCard(_ card: Card) async throws {
        if !isNetworkAvalable {
            throw PaymentError.notConnectedToInternet
        }
        try await Task.sleep(nanoseconds: UInt64(3 * Double(NSEC_PER_SEC)))
        
        // 9/10 succsess simulation
        if Int.random(in: 1...10) == 10 {
            throw PaymentError.unknown
        }
    }
    
}

enum PaymentError: Error {
    case notConnectedToInternet
    case unknown
}
