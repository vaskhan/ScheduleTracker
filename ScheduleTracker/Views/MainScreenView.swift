//
//  MainScreenView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 24.06.2025.
//

import SwiftUI

struct MainScreenView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var viewModel = MockReelsModel()
    @State private var fromTofromTo = true
    @State private var showAgreement = false
    @StateObject private var coordinator = NavigationCoordinator()
    
    var body: some View {
        
        NavigationStack(path: $coordinator.path) {
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
                        .renderingMode(.template)
                }
                
                VStack {
                    Toggle(isOn: $isDarkMode) {
                        Text("Темная тема")
                            .font(.custom("SFPro-Regular", size: 17))
                            .foregroundStyle(Color("dayOrNightColor"))
                    }
                    .tint(Color("blueUniversal"))
                    .padding(.vertical, 19)
                    
                    HStack {
                        NavigationLink(destination: UserAgreementView()) {
                            Text("Пользовательское соглашение")
                                .font(.custom("SFPro-Regular", size: 17))
                                .foregroundStyle(Color("dayOrNightColor"))
                            
                            Spacer()
                            
                            Image("rightChevron")
                                .renderingMode(.template)
                                .foregroundColor(Color("dayOrNightColor"))
                        }
                        .padding(.vertical, 19)
                    }
                    
                    Spacer()
                    
                    Text("Приложение использует API «Яндекс.Расписания»\nВерсия 1.0 (beta)")
                        .multilineTextAlignment(.center)
                        .lineSpacing(16)
                        .font(.custom("SFPro-Regular", size: 12))
                        .foregroundStyle(Color("dayOrNightColor"))
                    
                    Divider()
                        .frame(height: 3)
                        .padding(.top, 24)
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)
                .tabItem {
                    Image("gearTabItem")
                        .renderingMode(.template)
                }
            }
            .tint(Color("dayOrNightColor"))
            .navigationDestination(for: EnumAppRoute.self) { route in
                switch route {
                case .cityPicker(let fromField):
                    ChangeCityView(coordinator: coordinator, fromField: fromField)
                case .stationPicker(let city, let fromField):
                    ChangeStationView(coordinator: coordinator, city: city, fromField: fromField)
                }
            }
        }
    }
}

#Preview {
    MainScreenView()
}
