//
//  TicketListView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 28.06.2025.
//


import SwiftUI

struct TicketListView: View {
    @ObservedObject var coordinator: NavigationCoordinator
    @ObservedObject var viewModel: TicketListViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color("nightOrDayColor").ignoresSafeArea()
            VStack(spacing: 16) {
                HStack {
                    Text("\(coordinator.selectedCityFrom) (\(coordinator.selectedStationFrom)) → \(coordinator.selectedCityTo) (\(coordinator.selectedStationTo))")
                        .font(.custom("SFPro-Bold", size: 24))
                        .foregroundStyle(Color("dayOrNightColor"))
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                ZStack(alignment: .bottom) {
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            StateWrapperView(isLoading: viewModel.isLoading, errorType: viewModel.errorType) {
                                Group {
                                    if viewModel.filteredTickets.isEmpty {
                                        VStack {
                                            Text("Вариантов нет")
                                                .font(.custom("SFPro-Bold", size: 24))
                                                .foregroundStyle(Color("dayOrNightColor"))
                                                .multilineTextAlignment(.center)
                                                .frame(maxWidth: .infinity)
                                                .padding(.vertical, 231)
                                        }
                                    } else {
                                        ForEach(viewModel.filteredTickets) { ticket in
                                            Button(action: {
                                                coordinator.path.append(EnumAppRoute.carrierInfo(ticket))
                                            }) {
                                                TicketCell(ticket: ticket)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Button(action: { coordinator.path.append(EnumAppRoute.filters) }) {
                            HStack(spacing: 4) {
                                Text("Уточнить время")
                                    .font(.custom("SFPro-Bold", size: 17))
                                    .foregroundStyle(Color(.white))
                                if coordinator.isFiltersValid {
                                    Circle()
                                        .foregroundStyle(Color("redUniversal"))
                                        .frame(width: 8, height: 8)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                        }
                        .background(Color("blueUniversal"))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.bottom, 24)
                    }
                }
                .padding(.horizontal, 16)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { dismiss() }) {
                            Image("leftChevron")
                                .renderingMode(.template)
                                .foregroundStyle(Color("dayOrNightColor"))
                        }
                    }
                }
            }
            .task {
                await viewModel.loadTickets()
            }
        }
    }
    
