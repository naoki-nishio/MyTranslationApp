//
//  CharacterSet+URLQueryValueAllowed.swift
//  TranslateApp
//
//  Created by Nishio Naoki on 2024/05/02.
//


import Foundation

extension CharacterSet {

    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimiters = ":#[]@"
        let subDelimiters = "!$&'()*+,;="
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimiters)\(subDelimiters)")
        return allowed
    }()
}



