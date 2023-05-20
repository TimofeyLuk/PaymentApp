//
//  PaymentScreenView.swift
//  PaymentApp
//
//  Created by Тимофей Лукашевич on 20.05.23.
//

import SwiftUI

struct PaymentScreenView: View {
    
    let cardViewModel = CardViewModel()
    
    var body: some View {
        CardView(viewModel: cardViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentScreenView()
    }
}
