//
//  PaymentAppApp.swift
//  PaymentApp
//
//  Created by Тимофей Лукашевич on 20.05.23.
//

import SwiftUI


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        NetworkMonitor.shared.startMonitoring()
        return true
    }
}

@main
struct PaymentAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let cardViewModel = CardViewModel()
    let paymentViewModel = PaymentViewModel()
    
    var body: some Scene {
        WindowGroup {
            PaymentScreenView(cardViewModel: cardViewModel, paymentViewModel: paymentViewModel)
        }
    }
}
