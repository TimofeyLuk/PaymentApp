//
//  CardFront.swift
//  PaymentApp
//
//  Created by Тимофей Лукашевич on 20.05.23.
//

import SwiftUI

struct CardFront: View {
    
    @ObservedObject var viewModel: CardViewModel
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading) {
                
                HStack {
                    Spacer()
                    Text(viewModel.type)
                        .font(.title2)
                }
                .frame(minHeight:  proxy.size.height / 2.5)
                .accessibilityIdentifier("CardTypeLable")
                
                
                field("Card Number", text: $viewModel.cardModel.number, formater: CardNumberFormater())
                    .keyboardType(.numberPad)
                    .accessibilityIdentifier("CardNumberField")
                
                HStack {
                    field("MM/YY", text: $viewModel.cardModel.expireDate, formater: CardExpireDateFormater())
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .frame(width: proxy.size.width / 4)
                        .accessibilityIdentifier("CardExpireDateField")
                    Spacer()
                }
                    
                field("NAME SURNAME", text: $viewModel.cardModel.holderName, formater: CardHolderFormater())
                    .accessibilityIdentifier("CardHolderNameField")
                Spacer()
            }
            .padding(.horizontal)
        }
    }
    
    private func field(
        _ titleKey: String,
        text: Binding<String>,
        formater: StringFormater
    ) -> some View {
        FormattedTextField(titleKey,
                           value: text,
                           formater: formater)
        .padding(3)
        .background()
        .cornerRadius(5)
        
    }
    
    
}

struct CardFront_Previews: PreviewProvider {
    static var previews: some View {
        CardFront(viewModel: CardViewModel())
            .background(.blue)
            .frame(width: 350, height: 230)
    }
}
