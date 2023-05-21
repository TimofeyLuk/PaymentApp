//
//  PaymentScreenView.swift
//  PaymentApp
//
//  Created by Тимофей Лукашевич on 20.05.23.
//

import SwiftUI

struct PaymentScreenView: View {
    
    @ObservedObject var paymentViewModel: PaymentViewModel
    
    var body: some View {
        ZStack {
            fillCardView
            if paymentViewModel.paymentStatus != .closed {
                PaymentProcessView(paymentViewModel: paymentViewModel)
            }
        }
    }
    
    var fillCardView: some View {
        VStack {
            CardView(viewModel: paymentViewModel)
            if paymentViewModel.isCardFilled, paymentViewModel.validationErrors.isEmpty {
                payButton
            } else if !paymentViewModel.validationErrors.isEmpty {
                List($paymentViewModel.validationErrors) { error in
                    Text("\(error.wrappedValue.message)")
                        .foregroundColor(.red)
                }
            }
        }
    }
    
    var payButton: some View {
        Button {
            paymentViewModel.pay(withCard: paymentViewModel.cardModel)
        } label: {
            Text("Pay")
                .font(.title)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 5)
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.red, .blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .cornerRadius(10)
        )
        .padding()
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentScreenView(
            paymentViewModel: PaymentViewModel()
        )
    }
}
