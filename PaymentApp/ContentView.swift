//
//  ContentView.swift
//  PaymentApp
//
//  Created by Тимофей Лукашевич on 20.05.23.
//

import SwiftUI

struct ContentView: View {
    
    let cartViewModel = CartViewModel()
    
    var body: some View {
        CartView(viewModel: cartViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
