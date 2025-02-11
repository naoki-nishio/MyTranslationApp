//
//  TranslationViewModel.swift
//  TranslateApp
//
//  Created by Nishio Naoki on 2025/02/02.
//

import Foundation

@MainActor
class TranslationViewModel: ObservableObject {
    @Published var inputText = ""
    @Published var translatedText = ""
    @Published var sourceLanguage = "EN"
//    @Published var sourceLanguage = "EN"
    @Published var targetLanguage = "JA"
//    @Published var targetLanguage = "JA"
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let deepLService = DeepLService()
    
    func translate() async {
        translatedText = ""
        errorMessage = nil
        
        guard !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "入力が空です。"
            return
        }
        
        isLoading = true
        
        do {
            let result = try await deepLService.translate(text: inputText,
                                                          sourceLang: sourceLanguage,
                                                          targetLang: targetLanguage)
            translatedText = result
        } catch let error as TranslationError {
            errorMessage = error.errorDescription
        } catch let error as URLError {
            errorMessage = "ネットワークエラー: \(error.localizedDescription)"
        } catch {
            errorMessage = "予期しないエラー: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
