//
//  CartFront.swift
//  PaymentApp
//
//  Created by Тимофей Лукашевич on 20.05.23.
//

import SwiftUI

struct CartFront: View {
    
    @ObservedObject var viewModel: CartViewModel
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading) {
                Spacer(minLength: proxy.size.height / 2.5)
                field("Cart Number", text: $viewModel.model.number, formater: CartNumberFormater())
                    .keyboardType(.numberPad)
                HStack {
                    field("MM/YY", text: $viewModel.model.expireDate, formater: CartExpireDateFormater())
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .frame(width: proxy.size.width / 4)
                    Spacer()
                }
                    
                field("NAME SURNAME", text: $viewModel.model.holdername, formater: CartHolderFormater())
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

struct CartFront_Previews: PreviewProvider {
    static var previews: some View {
        CartFront(viewModel: CartViewModel())
            .background(.blue)
            .frame(width: 350, height: 230)
    }
}
