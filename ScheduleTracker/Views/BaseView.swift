//
//  BaseView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 24.06.2025.
//

import SwiftUI

struct BaseView: View {
    @StateObject private var coordinator = NavigationCoordinator()
    @StateObject private var viewModel = MockReelsModel()
    @EnvironmentObject var services: APIServicesContainer
    
    var body: some View {
        ZStack {
            Color.nightOrDay.ignoresSafeArea()
            NavigationStack(path: $coordinator.path) {
                TabView {
                    MainView(viewModel: viewModel, coordinator: coordinator)
                        .tabItem {
                            Image(.scheduleTabItem)
                                .renderingMode(.template)
                        }
                    
                    SettingsView(viewModel: SettingsViewModel(copyrightService: services.copyrightService))
                    
                        .tabItem {
                            Image(.gearTabItem)
                                .renderingMode(.template)
                        }
                }
                .tint(.dayOrNight)
                .navigationDestination(for: EnumAppRoute.self) { route in
                    switch route {
                    case .cityPicker(let fromField):
                        ChangeCityView(
                            coordinator: coordinator,
                            fromField: fromField,
                            stationListService: services.allStationService
                        )
                    case .stationPicker(let city, let fromField):
                        ChangeStationView(
                            coordinator: coordinator,
                            city: city,
                            fromField: fromField,
                            stationListService: services.allStationService
                        )
                    case .tickets:
                        TicketListView(
                            coordinator: coordinator,
                            viewModel: TicketListViewModel(
                                searchService: services.searchService,
                                fromStation: coordinator.selectedStationFromCode,
                                toStation: coordinator.selectedStationToCode,
                                showTransfers: coordinator.showTransfers,
                                timeFilters: coordinator.timeFilters
                            )
                        )
                    case .filters:
                        FiltersView(coordinator: coordinator)
                    case .carrierInfo(let ticket):
                        CarrierInfoView(
                            viewModel: CarrierInfoViewModel(service: services.carrierService),
                            code: ticket.carrierCode.map(String.init) ?? ""
                        )
                    }
                    
                }
            }
            .onChange(of: coordinator.path) {
                if coordinator.path.isEmpty {
                    coordinator.timeFilters.removeAll()
                    coordinator.showTransfers = nil
                }
            }
        }
    }
}

#Preview {
    BaseView()
}
