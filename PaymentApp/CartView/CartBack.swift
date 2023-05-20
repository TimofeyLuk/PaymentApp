//
//  CartBack.swift
//  PaymentApp
//
//  Created by Тимофей Лукашевич on 20.05.23.
//

import SwiftUI

struct CartBack: View {
    
    @ObservedObject var viewModel: CartViewModel
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer()
                HStack {
                    Spacer(minLength: proxy.size.width * (2.0 / 3.0))
                    FormattedTextField("CVV/CVV2", value: $viewModel.model.cvv, formater: CartCVVFormater())
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .padding(3)
                        .background()
                        .cornerRadius(5)
                    Spacer(minLength: proxy.size.width / 15)
                }
                Spacer()
            }
        }
    }
}

struct CartBack_Previews: PreviewProvider {
    static var previews: some View {
        CartBack(viewModel: CartViewModel())
            .background(.blue)
            .frame(width: 350, height: 230)
    }
}
