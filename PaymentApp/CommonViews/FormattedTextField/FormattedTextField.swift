//
//  FormattedTextField.swift
//  PaymentApp
//
//  Created by Тимофей Лукашевич on 20.05.23.
//

import SwiftUI

protocol StringFormater {
    func modify(_: String) -> String
}

struct FormattedTextField: View {
    public init(_ title: String,
                value: Binding<String>,
                formater: StringFormater) {
        self.title = title
        self.value = value
        self.formater = formater
    }

    let title: String
    let value: Binding<String>
    let formater: StringFormater

    public var body: some View {
        TextField(title, text: Binding(get: {
            return formater.modify(value.wrappedValue)
        }, set: { string in
            self.value.wrappedValue = formater.modify(string)
        }))
    }

}

public protocol TextFieldFormatter {
    associatedtype Value
    func displayString(for value: Value) -> String
    func editingString(for value: Value) -> String
    func value(from string: String) -> Value
}

