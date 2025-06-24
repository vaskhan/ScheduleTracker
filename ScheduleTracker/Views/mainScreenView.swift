//
//  mainScreenView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 24.06.2025.
//

import SwiftUI

struct mainScreenView: View {
    @State private var viewModel = MockReelsModel()
    @State private var fromTofromTo = true
    
    var body: some View {
        TabView {
            VStack (spacing: 44){
                ScrollView (.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .center, spacing: 12) {
                        ForEach(viewModel.reels) { reels in
                            ReelsCell(reels: reels)
                        }
                    }
                    .padding(.horizontal, 16)
                    
                }
                
                .frame(height: 140)
                
                ZStack {
                    Color("blueUniversal")
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Button(action: {}) {
                                Text(fromTofromTo ? "Откуда" : "Куда")
                                    .foregroundColor(Color("grayUniversal"))
                                    .padding(.vertical, 14)
                                    .padding(.horizontal, 16)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                            }
                            
                            Button(action: {}) {
                                Text(fromTofromTo ? "Куда" : "Откуда")
                                    .foregroundColor(Color("grayUniversal"))
                                    .padding(.vertical, 14)
                                    .padding(.horizontal, 16)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                        )
                        .padding(.horizontal, 16)
                        
                        Button(action: { fromTofromTo.toggle() }) {
                            Image(systemName: "arrow.2.squarepath")
                                .font(.system(size: 24))
                                .foregroundColor(Color("blueUniversal"))
                                .padding(6)
                                .background(.white)
                                .clipShape(Circle())
                        }
                        .padding(.trailing, 16)
                    }
                    .padding(.vertical, 16)
                }
                .frame(height: 128)
                .padding(.horizontal, 16)
                
                Spacer()
                
                Divider()
                    .frame(height: 3)
            }
            .padding(.top, 24)
            .tabItem {
                Image("scheduleTabItem")
            }
            
            ZStack {
                //page2
            }
            .tabItem {
                Image("gearTabItem")
            }
        }
    }
}

#Preview {
    mainScreenView()
}
