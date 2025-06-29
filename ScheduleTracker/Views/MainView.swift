//
//  MainView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 29.06.2025.
//

import SwiftUI

struct MainView: View {
    @State private var viewModel = MockReelsModel()
    @State private var fromTofromTo = true
    @State private var showAgreement = false
    @ObservedObject var coordinator: NavigationCoordinator
    
    var body: some View {
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
            VStack(spacing: 16) {
                ZStack {
                    Color("blueUniversal")
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            NavigationLink(value: EnumAppRoute.cityPicker(fromField: true)) {
                                Text(fromTofromTo ? (coordinator.selectedCityFrom.isEmpty ? "Откуда" : "\(coordinator.selectedCityFrom) (\(coordinator.selectedStationFrom))")
                                     : (coordinator.selectedCityTo.isEmpty ? "Куда" : "\(coordinator.selectedCityTo) (\(coordinator.selectedStationTo))")
                                )
                                .foregroundStyle(
                                    (fromTofromTo
                                     ? coordinator.selectedCityFrom.isEmpty
                                     : coordinator.selectedCityTo.isEmpty
                                    )
                                    ? Color("grayUniversal")
                                    : Color("blackUniversal")
                                )
                                .padding(.vertical, 14)
                                .padding(.horizontal, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            NavigationLink(value: EnumAppRoute.cityPicker(fromField: false)) {
                                Text(fromTofromTo ? (coordinator.selectedCityTo.isEmpty ? "Куда" : "\(coordinator.selectedCityTo) (\(coordinator.selectedStationTo))")
                                     : (coordinator.selectedCityFrom.isEmpty ? "Откуда" : "\(coordinator.selectedCityFrom) (\(coordinator.selectedStationFrom))")
                                )
                                .foregroundStyle(
                                    (fromTofromTo
                                     ? coordinator.selectedCityTo.isEmpty
                                     : coordinator.selectedCityFrom.isEmpty
                                    )
                                    ? Color("grayUniversal")
                                    : Color("blackUniversal")
                                )
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
                                .foregroundStyle(Color("blueUniversal"))
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
                
                if !coordinator.selectedCityTo.isEmpty && !coordinator.selectedCityFrom.isEmpty {
                    Button(action: {coordinator.path.append(EnumAppRoute.tickets)}) {
                        Text("Найти")
                            .font(.custom("SFPro-Bold", size: 17))
                            .foregroundStyle(Color(.white))
                    }
                    .padding(.horizontal, 47.5)
                    .padding(.vertical, 20)
                    .background(Color("blueUniversal"))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            Spacer()
            
            Divider()
                .frame(height: 3)
        }
        .padding(.top, 24)
    }
}

#Preview {
    MainView(coordinator: NavigationCoordinator())
}
