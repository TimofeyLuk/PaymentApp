//
//  PaymentScreenView.swift
//  PaymentApp
//
//  Created by Тимофей Лукашевич on 20.05.23.
//

import SwiftUI

struct PaymentScreenView: View {
    
    @ObservedObject var cardViewModel: CardViewModel
    
    var body: some View {
        VStack {
            CardView(viewModel: cardViewModel)
            if cardViewModel.isCardFilled, cardViewModel.validationErrors.isEmpty {
                payButton
            } else if !cardViewModel.validationErrors.isEmpty {
                List($cardViewModel.validationErrors) { error in
                    Text("\(error.wrappedValue.message)")
                        .foregroundColor(.red)
                }
            }
        }
    }
        var payButton: some View {
            
            Button {
                cardViewModel.pay()
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
        PaymentScreenView(cardViewModel: CardViewModel())
    }
}
