//
//  ChangeStationView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 26.06.2025.
//

import SwiftUI

struct ChangeStationView: View {
    @ObservedObject var coordinator: NavigationCoordinator
    let city: String
    let fromField: Bool
    let stationListService: StationListServiceProtocol
    
    @StateObject private var viewModel: StationSelectionViewModel
    @Environment(\.dismiss) var dismiss
    
    init(
        coordinator: NavigationCoordinator,
        city: String,
        fromField: Bool,
        stationListService: StationListServiceProtocol
    ) {
        self.coordinator = coordinator
        self.city = city
        self.fromField = fromField
        self.stationListService = stationListService
        _viewModel = StateObject(wrappedValue: StationSelectionViewModel(stationListService: stationListService, city: city))
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
                                if viewModel.filteredStations.isEmpty {
                                    VStack {
                                        Text("Станция не найдена")
                                            .font(.custom("SFPro-Bold", size: 24))
                                            .foregroundStyle(Color("dayOrNightColor"))
                                            .multilineTextAlignment(.center)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 176)
                                    }
                                } else {
                                    ForEach(viewModel.filteredStations, id: \.id) { station in
                                        Button(action: {
                                            if fromField {
                                                coordinator.selectedCityFrom = city
                                                coordinator.selectedStationFrom = station.title
                                                coordinator.selectedStationFromCode = station.id
                                            } else {
                                                coordinator.selectedCityTo = city
                                                coordinator.selectedStationTo = station.title
                                                coordinator.selectedStationToCode = station.id
                                            }
                                            coordinator.path = NavigationPath()
                                        }) {
                                            HStack {
                                                Text(station.title)
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
                            .padding(.horizontal, 16)
                        }
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
                    Text("Выбор станции")
                        .font(.custom("SFPro-Bold", size: 17))
                        .foregroundStyle(Color("dayOrNightColor"))
                }
            }
        }
        .onAppear { viewModel.loadStations() }
    }
}

