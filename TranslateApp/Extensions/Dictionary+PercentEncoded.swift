//
//  Dictionary+PercentEncoded.swift
//  TranslateApp
//
//  Created by Nishio Naoki on 2024/05/02.
//
import Foundation

extension Dictionary {
    func percentEncoded() -> Data? {
        let parameterArray = self.map { key, value -> String in
            let keyString = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let valueString = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return "\(keyString)=\(valueString)"
        }
        let joined = parameterArray.joined(separator: "&")
        return joined.data(using: .utf8)
    }
}
