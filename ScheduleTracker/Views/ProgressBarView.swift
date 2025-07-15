import SwiftUI

extension CGFloat {
    static let progressBarCornerRadius: CGFloat = 6
    static let progressBarHeight: CGFloat = 6
}

struct ProgressBar: View {
    let numberOfSections: Int
    let progress: CGFloat
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<numberOfSections, id: \.self) { index in
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                            .frame(height: .progressBarHeight)
                            .foregroundColor(.white)
                        RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                            .frame(width: geo.size.width * fillFor(index: index), height: .progressBarHeight)
                            .foregroundColor(Color("blueUniversal"))

                    }
                }
                .frame(height: .progressBarHeight)
            }
        }
        .frame(height: .progressBarHeight)
    }
    
    private func fillFor(index: Int) -> CGFloat {
        if progress >= CGFloat(index + 1) { return 1 }
        else if progress > CGFloat(index) { return progress - CGFloat(index) }
        else { return 0 }
    }
}

#Preview {
    Color("blackUniversal")
            .ignoresSafeArea()
        .overlay(
            ProgressBar(numberOfSections: 4, progress: 2.3)
                .padding()
        )
}
