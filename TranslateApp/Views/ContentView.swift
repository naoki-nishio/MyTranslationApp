import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = TranslationViewModel()
    @State private var showResult = false
    
    private let languages = ["EN", "JA", "DE", "FR", "ES", "IT", "NL", "PL", "RU", "PT"]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("テキストを入力")) {
                        TextEditor(text: $viewModel.inputText)
                            .frame(height: 150)
                            .padding(4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                    }
                    Section(header: Text("言語選択")) {
                        Picker("原文の言語", selection: $viewModel.sourceLanguage) {
                            ForEach(languages, id: \.self) { lang in
                                Text(lang)
                            }
                        }
                        Picker("翻訳先の言語", selection: $viewModel.targetLanguage) {
                            ForEach(languages, id: \.self) { lang in
                                Text(lang)
                            }
                        }
                    }
                }
                
                if viewModel.isLoading {
                    ProgressView().padding()
                }
                if let errorMessage = viewModel.errorMessage {
                    Text("エラー: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                }
                
                NavigationLink(destination: TranslationResultView(viewModel: viewModel),
                               isActive: $showResult) {
                    EmptyView()
                }
                
                Button("翻訳") {
                    Task {
                        await viewModel.translate()
                        if viewModel.errorMessage == nil {
                            showResult = true
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

