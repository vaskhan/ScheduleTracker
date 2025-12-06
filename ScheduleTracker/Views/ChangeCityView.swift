//
//  ChangeCityView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 26.06.2025.
//

import SwiftUI

struct ChangeCityView: View {
    @ObservedObject var coordinator: NavigationCoordinator
    let fromField: Bool
    let stationListService: StationListServiceProtocol
    @StateObject private var viewModel: CitySelectionViewModel
    @Environment(\.dismiss) var dismiss
    
    init(coordinator: NavigationCoordinator, fromField: Bool, stationListService: StationListServiceProtocol) {
        self.coordinator = coordinator
        self.fromField = fromField
        self.stationListService = stationListService
        _viewModel = StateObject(wrappedValue: CitySelectionViewModel(stationListService: stationListService))
    }
    
    var body: some View {
        ZStack {
            Color("nightOrDayColor").ignoresSafeArea()
            VStack(spacing: 0) {
                CustomSearchBar(text: $viewModel.searchText, placeholder: "Введите запрос")
                StateWrapperView(isLoading: viewModel.isLoading, errorType: viewModel.errorType) {
                    Group {
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVStack(alignment: .leading) {
                                if viewModel.filteredCities.isEmpty {
                                    VStack {
                                        Text("Город не найден")
                                            .font(.custom("SFPro-Bold", size: 24))
                                            .foregroundStyle(Color("dayOrNightColor"))
                                            .multilineTextAlignment(.center)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 176)
                                    }
                                } else {
                                    ForEach(viewModel.filteredCities, id: \.self) { item in
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
                                                    .foregroundStyle(Color("dayOrNightColor"))
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
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image("leftChevron")
                            .renderingMode(.template)
                            .foregroundStyle(Color("dayOrNightColor"))
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
}
