//
//  CardView.swift
//  PaymentApp
//
//  Created by Тимофей Лукашевич on 20.05.23.
//

import SwiftUI

struct CardView: View {
    
    @ObservedObject var viewModel: CardViewModel
    
    @State private var isCardFrontShown = true
    @State private var degrees = 0.0
    
    var body: some View {
        VStack {
            cardView
            Button {
                withAnimation {
                    isCardFrontShown.toggle()
                    degrees += 180
                }
            } label: {
                Text(isCardFrontShown ? "Next" : "Back")
            }
            .accessibilityIdentifier("FlipCardButton")
            .padding(.top, 30)
        }
    }
    
    var cardView: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.red, .blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            if isCardFrontShown {
                CardFront(viewModel: viewModel)
            } else {
                CardBack(viewModel: viewModel)
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

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(viewModel: CardViewModel())
    }
}
