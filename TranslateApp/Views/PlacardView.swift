import SwiftUI

struct PlacardView: View {
    var text: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            ZStack(alignment: isLandscape ? .topTrailing : .bottomTrailing) {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Text(text)
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .multilineTextAlignment(.center)
                        .rotationEffect(.degrees(90))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    Spacer()
                }
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .padding()
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct PlacardView_Previews: PreviewProvider {
    static var previews: some View {
        PlacardView(text: "テスト")
    }
}

