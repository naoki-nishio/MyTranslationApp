//
//  Untitled.swift
//  TranslateApp
//
//  Created by Nishio Naoki on 2024/05/02.
//



import Foundation


// - DeepL翻訳APIを使用して翻訳
class DeepLService {
    
    private var apiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "DEEPL_API_KEY") as? String,
              !key.isEmpty else {
            fatalError("aaa")
        }
        return key
    }

    func translate(text: String, sourceLang: String?, targetLang: String) async throws -> String {
        guard let url = URL(string: "https://api-free.deepl.com/v2/translate") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        var params: [String: String] = [
            "auth_key": apiKey,
            "text": text,
            "target_lang": targetLang.uppercased()
        ]
        if let source = sourceLang, !source.isEmpty {
            params["source_lang"] = source.uppercased()
        }
        
        request.httpBody = params.percentEncoded()
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        guard (200...299).contains(httpResponse.statusCode) else {

            if let serverError = try? JSONDecoder().decode(DeepLErrorResponse.self, from: data),
               let message = serverError.message {
                throw TranslationError.serverError(message: message, code: httpResponse.statusCode)
            }
            throw URLError(.badServerResponse)
        }
        
        let translationResponse = try JSONDecoder().decode(DeepLTranslationResponse.self, from: data)
        guard let firstTranslation = translationResponse.translations.first else {
            throw TranslationError.noTranslation
        }
        return firstTranslation.text
    }
}
