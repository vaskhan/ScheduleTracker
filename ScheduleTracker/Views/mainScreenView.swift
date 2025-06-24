//
//  mainScreenView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 24.06.2025.
//

import SwiftUI

struct mainScreenView: View {
    @State private var viewModel = MockReelsModel()
    
    var body: some View {
        TabView {
            ZStack {
                VStack {
                    ScrollView (.horizontal, showsIndicators: false) {
                        LazyHStack(alignment: .center, spacing: 12) {
                            ForEach(viewModel.reels) { reels in
                                ReelsCell(reels: reels)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    Spacer()
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .tabItem {
                Label("", systemImage: "1.square.fill")
            }
            ZStack {
                //page2
            }
            .tabItem {
                Label("", systemImage: "2.square.fill")
            }
        }
    }
}

#Preview {
    mainScreenView()
}
