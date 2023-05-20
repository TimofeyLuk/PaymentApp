//
//  PaymentProcessView.swift
//  PaymentApp
//
//  Created by Тимофей Лукашевич on 20.05.23.
//

import SwiftUI

struct PaymentProcessView: View {
    
    @ObservedObject var paymentViewModel: PaymentViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(8)
                .shadow(radius: 6)
            stausView
        }
        .frame(width: 250, height: 300)
    }
    
    var stausView: some View {
        Group {
            switch paymentViewModel.paymentStatus {
            case .inProgress:
                inProgressView
            case .success:
                successView
            case .fail:
                failView
            case .closed:
                EmptyView()
            }
        }
        .animation(.easeInOut(duration: 3),
                   value: paymentViewModel.paymentStatus)
    }
    
    var inProgressView: some View {
        VStack {
            ProgressView()
                .padding()
            Text("Payment is in progress")
        }
    }
    
    var successView: some View {
        VStack {
            Image(systemName: "checkmark.seal.fill")
                .resizable()
                .foregroundColor(.green)
                .frame(width: 100, height: 100)
            Text("Payment complited with success")
                .multilineTextAlignment(.center)
                .padding()
            closeButton
        }
    }
    
    var failView: some View {
        VStack {
            Image(systemName: "xmark.seal.fill")
                .resizable()
                .foregroundColor(.red)
                .frame(width: 100, height: 100)
            Text(
                "Payment failed" + "\n" +
                "\(paymentViewModel.paymentError?.message ?? "Unknown error")"
            )
                .multilineTextAlignment(.center)
                .padding()
            closeButton
            
        }
    }
    
    var closeButton: some View {
        Button("Close") {
            paymentViewModel.close()
        }
    }
}

fileprivate extension PaymentError {
    var message: String {
        switch self {
        case .notConnectedToInternet:
            return "No internet connection"
        case .unknown:
            return "Unknown error"
        }
    }
}

struct PaymentProcessView_Previews: PreviewProvider {
    
    static var previews: some View {
        let paymentViewModel = {
            let paymentViewModel = PaymentViewModel()
            paymentViewModel.paymentStatus = .success
            return paymentViewModel
        }()
        
        return PaymentProcessView(paymentViewModel: paymentViewModel)
    }
}
