//
//  PaymentAppApp.swift
//  PaymentApp
//
//  Created by Тимофей Лукашевич on 20.05.23.
//

import SwiftUI

@main
struct PaymentAppApp: App {
    
    let cardViewModel = CardViewModel()
    
    var body: some Scene {
        WindowGroup {
            PaymentScreenView(cardViewModel: cardViewModel)
        }
    }
}
