//
//  CardBack.swift
//  PaymentApp
//
//  Created by Тимофей Лукашевич on 20.05.23.
//

import SwiftUI

struct CardBack: View {
    
    @ObservedObject var viewModel: CardViewModel
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer()
                HStack {
                    Spacer(minLength: proxy.size.width * (2.0 / 3.0))
                    FormattedTextField("CVV/CVV2", value: $viewModel.cardModel.cvv, formater: CardCVVFormater())
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .padding(3)
                        .background()
                        .cornerRadius(5)
                        .accessibilityIdentifier("CardCVVField")
                    Spacer(minLength: proxy.size.width / 15)
                }
                Spacer()
            }
        }
    }
}

struct CardBack_Previews: PreviewProvider {
    static var previews: some View {
        CardBack(viewModel: CardViewModel())
            .background(.blue)
            .frame(width: 350, height: 230)
    }
}
