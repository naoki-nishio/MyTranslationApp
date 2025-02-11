//
//  DeepLTranslationResponse.swift
//  TranslateApp
//
//  Created by Nishio Naoki on 2024/05/02.
//


import Foundation

struct DeepLTranslationResponse: Codable {
    let translations: [TranslationDetail]
}
