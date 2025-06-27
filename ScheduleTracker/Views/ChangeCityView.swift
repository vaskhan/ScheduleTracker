//
//  ChangeCityView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 26.06.2025.
//

import SwiftUI

struct ChangeCityView: View {
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss
    @ObservedObject var coordinator: NavigationCoordinator
    let fromField: Bool
    
    let cities = ["Москва", "Санкт-Петербург", "Сочи", "Горный воздух", "Краснодар", "Казань", "Омск"]
    
    var filteredItems: [String] {
        if searchText.isEmpty {
            return cities
        } else {
            return cities.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomSearchBar(text: $searchText, placeholder: "Введите запрос")
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading) {
                    if filteredItems.isEmpty {
                        VStack {
                            Text("Город не найден")
                                .font(.custom("SFPro-Bold", size: 24))
                                .foregroundStyle(Color("dayOrNightColor"))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 176)
                        }
                    } else {
                        ForEach(filteredItems, id: \.self) { item in
                            Button(action: {
                                if fromField {
                                    coordinator.selectedCityFrom = item
                                    coordinator.selectedStationFrom = ""
                                } else {
                                    coordinator.selectedCityTo = item
                                    coordinator.selectedStationTo = ""
                                }
                                coordinator.path.append(EnumAppRoute.stationPicker(city: item, fromField: fromField))
                            }) {
                                HStack {
                                    Text("\(item)")
                                        .font(.custom("SFPro-Regular", size: 17))
                                        .foregroundStyle(Color("dayOrNightColor"))
                                    
                                    Spacer()
                                    
                                    Image("rightChevron")
                                        .renderingMode(.template)
                                        .foregroundColor(Color("dayOrNightColor"))
                                }
                                .padding(.vertical, 19)
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image("leftChevron")
                        .renderingMode(.template)
                        .foregroundColor(Color("dayOrNightColor"))
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("Выбор города")
                    .font(.custom("SFPro-Bold", size: 17))
                    .foregroundStyle(Color("dayOrNightColor"))
            }
        }
    }
}

#Preview {
    ChangeCityView(coordinator: NavigationCoordinator(), fromField: true)
}

