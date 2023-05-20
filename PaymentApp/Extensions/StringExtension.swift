//
//  StringExtension.swift
//  PaymentApp
//
//  Created by Тимофей Лукашевич on 20.05.23.
//

import Foundation

extension String {
    func applyPattern(pattern: String, replacementCharacter: Character) -> String {
        var res = ""
        var stringCurrentIndex = 0
        for index in 0 ..< pattern.count {
            guard stringCurrentIndex < self.count else { return res }
            
            let stringIndex = String.Index(utf16Offset: stringCurrentIndex, in: self)
            let stringCharacter = self[stringIndex]
            
            let paternIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[paternIndex]

            
            if patternCharacter == replacementCharacter {
                res.append(stringCharacter)
                stringCurrentIndex += 1
            } else {
                res.append(patternCharacter)
            }
            
        }
        return res
    }
}
