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
    
    var body: some View {
        ZStack {
            Color("nightOrDayColor").ignoresSafeArea()
            NavigationStack(path: $coordinator.path) {
                TabView {
                    MainView(viewModel: viewModel, coordinator: coordinator)
                        .tabItem {
                            Image("scheduleTabItem")
                                .renderingMode(.template)
                        }
                    
                    SettingsView()
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
                    case .tickets:
                        TicketListView(coordinator: coordinator)
                    case .filters:
                        FiltersView(coordinator: coordinator)
                    case .carrierInfo(let ticket):
                        CarrierInfoView(carrier: ticket)
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
