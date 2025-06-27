//
//  ChangeStationView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 26.06.2025.
//

import SwiftUI

struct ChangeStationView: View {
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss
    @ObservedObject var coordinator: NavigationCoordinator
    let city: String
    let fromField: Bool
    
    let stations = [
        "Киевский вокзал", "Курский вокзал", "Ярославский вокзал",
        "Белорусский вокзал", "Савеловский вокзал", "Ленинградский вокзал"
    ]
    
    var filteredItems: [String] {
        if searchText.isEmpty {
            return stations
        } else {
            return stations.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomSearchBar(text: $searchText, placeholder: "Введите запрос")
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading) {
                    if filteredItems.isEmpty {
                        VStack {
                            Text("Станция не найдена")
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
                                    coordinator.selectedCityFrom = city
                                    coordinator.selectedStationFrom = item
                                } else {
                                    coordinator.selectedCityTo = city
                                    coordinator.selectedStationTo = item
                                }
                                coordinator.path = NavigationPath()
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
                .padding(.horizontal, 16)
            }
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
                Text("Выбор станции")
                    .font(.custom("SFPro-Bold", size: 17))
                    .foregroundStyle(Color("dayOrNightColor"))
            }
        }
    }
}


#Preview {
    ChangeStationView(
        coordinator: NavigationCoordinator(),
        city: "Москва",
        fromField: true
    )
}
