//
//  DeepLErrorResponse.swift
//  TranslateApp
//
//  Created by Nishio Naoki on 2024/05/02.
//
import Foundation
import Swift


/// DeepL API からエラーが返された場合のレスポンスモデル
struct DeepLErrorResponse: Codable {
    let message: String?
}
