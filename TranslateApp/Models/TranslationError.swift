//
//  TranslationError.swift
//  TranslateApp
//
//  Created by Nishio Naoki on 2024/05/02.
//


import Foundation
import Swift

enum TranslationError: Error, LocalizedError {
    case noTranslation
    case serverError(message: String, code: Int)
    
    var errorDescription: String? {
        switch self {
        case .noTranslation:
            return "翻訳結果がありません。"
        case .serverError(let message, let code):
            return "サーバーエラー (コード \(code)): \(message)"
        }
    }
}
