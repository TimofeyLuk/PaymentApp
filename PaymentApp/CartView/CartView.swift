//
//  CartView.swift
//  PaymentApp
//
//  Created by Тимофей Лукашевич on 20.05.23.
//

import SwiftUI

struct CartView: View {
    
    @ObservedObject var viewModel: CartViewModel
    
    @State private var isCartFrontShown = true
    @State private var degrees = 0.0
    
    var body: some View {
        VStack {
            Spacer()
            
            cartView
            
            Button {
                withAnimation {
                    isCartFrontShown.toggle()
                    degrees += 180
                }
            } label: {
                Text(isCartFrontShown ? "Next" : "Back")
            }
            .padding(.top, 30)

            Spacer()
        }
    }
    
    var cartView: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.red, .blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            if isCartFrontShown {
                CartFront(viewModel: viewModel)
            } else {
                CartBack(viewModel: viewModel)
                    .rotation3DEffect( .degrees(180),
                                       axis: (x: 0, y: 1, z: 0))
            }
        }
        .frame(width: 350, height: 230)
        .cornerRadius(10)
        .rotation3DEffect( .degrees(degrees),
                           axis: (x: 0, y: 1, z: 0))
    }
    
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: CartViewModel())
    }
}
