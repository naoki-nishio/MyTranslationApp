//
//  TranslationDetail.swift
//  TranslateApp
//
//  Created by Nishio Naoki on 2024/05/02.
//

import Foundation

struct TranslationDetail: Codable {
    let detected_source_language: String?
    let text: String
}
