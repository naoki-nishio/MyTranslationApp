import SwiftUI

struct TranslationResultView: View {
    @ObservedObject var viewModel: TranslationViewModel
    @State private var showPlacard: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("原文:")
                .font(.headline)
            ScrollView {
                Text(viewModel.inputText)
                    .padding()
            }
            Divider()
            Text("翻訳結果")
                .font(.headline)
            ScrollView {
                Text(viewModel.translatedText)
                    .padding()
            }
            Spacer()
            Button("プラカード表示") {
                showPlacard = true
            }
            .padding()
        }
        .padding()
//        .navigationTitle("翻訳結果")
        .fullScreenCover(isPresented: $showPlacard) {
            PlacardView(text: viewModel.translatedText)
        }
    }
}

struct TranslationResultView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TranslationResultView(viewModel: TranslationViewModel())
        }
    }
}

