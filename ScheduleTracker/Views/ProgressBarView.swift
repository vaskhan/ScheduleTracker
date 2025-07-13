import SwiftUI

extension CGFloat {
    static let progressBarCornerRadius: CGFloat = 6
    static let progressBarHeight: CGFloat = 6
}

struct ProgressBar: View {
    let numberOfSections: Int
    let progress: CGFloat
    
    var body: some View {
        // Используем `GeometryReader` для получения размеров экрана
        GeometryReader { geometry in
            
            ZStack(alignment: .leading) {
                // Белая подложка прогресс бара
                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    .frame(width: geometry.size.width, height: .progressBarHeight)
                    .foregroundColor(.white)

                // Синяя полоска текущего прогресса
                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    .frame(
                        // Ширина прогресса зависит от текущего прогресса.
                        // Используем `min` на случай, если `progress` > 1
                        width: min(
                            progress * geometry.size.width,
                            geometry.size.width
                        ),
                        height: .progressBarHeight
                    )
                    .foregroundColor(.blueUniversal)
            }
            // Добавляем маску
            .mask {
                HStack {
                    // С помощью конструктора `ForEach` добавляем нужное колечество секций
                    ForEach(0..<numberOfSections, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    }
                }
            }
        }
    }
}

#Preview {
    Color("blackUniversal")
            .ignoresSafeArea()
        .overlay(
            ProgressBar(numberOfSections: 4, progress: 0.5)
                .padding()
        )
}
