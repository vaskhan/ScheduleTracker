//
//  TicketListView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 28.06.2025.
//


import SwiftUI

struct TicketListView: View {
    @ObservedObject var coordinator: NavigationCoordinator
    @Environment(\.dismiss) var dismiss
    
    let tickets: [TicketModel] = [
        .init(operatorName: "РЖД", date: "14 января", departure: "22:30", arrival: "08:15", duration: "20 часов", withTransfer: true, operatorLogo: "RJDImage", note: "С пересадкой в Костроме"),
        .init(operatorName: "ФГК", date: "15 января", departure: "01:15", arrival: "09:00", duration: "9 часов", withTransfer: false, operatorLogo: "FGKImage", note: nil),
        .init(operatorName: "Урал логистика", date: "16 января", departure: "12:30", arrival: "21:00", duration: "9 часов", withTransfer: false, operatorLogo: "URALImage", note: nil),
        .init(operatorName: "РЖД", date: "17 января", departure: "22:30", arrival: "08:15", duration: "20 часов", withTransfer: true, operatorLogo: "RJDImage", note: "С пересадкой в Костроме"),
        .init(operatorName: "РЖД", date: "17 января", departure: "22:30", arrival: "08:15", duration: "20 часов", withTransfer: false, operatorLogo: "RJDImage", note: nil),
        .init(operatorName: "РЖД", date: "17 января", departure: "22:30", arrival: "08:15", duration: "20 часов", withTransfer: false, operatorLogo: "RJDImage", note: nil),
        .init(operatorName: "РЖД", date: "17 января", departure: "22:30", arrival: "08:15", duration: "20 часов", withTransfer: false, operatorLogo: "RJDImage", note: nil)
    ]
    
    
    var filteredTickets: [TicketModel] {
        tickets.filter { ticket in
            // Фильтр по пересадкам
            if let show = coordinator.showTransfers, show != ticket.withTransfer { return false }
            // Фильтр по времени
            if !coordinator.timeFilters.isEmpty {
                let depHour = Int(ticket.departure.prefix(2)) ?? 0
                let period: TimePeriod = {
                    switch depHour {
                    case 6..<12: return .morning
                    case 12..<18: return .day
                    case 18..<24: return .evening
                    default: return .night
                    }
                }()
                if !coordinator.timeFilters.contains(period) { return false }
            }
            return true
        }
    }
    
    var body: some View {
        ZStack {
            Color("nightOrDayColor").ignoresSafeArea()
            VStack(spacing: 16) {
                // Заголовок
                HStack {
                    Text("\(coordinator.selectedCityFrom) (\(coordinator.selectedStationFrom)) → \(coordinator.selectedCityTo) (\(coordinator.selectedStationTo))")
                        .font(.custom("SFPro-Bold", size: 24))
                        .foregroundStyle(Color("dayOrNightColor"))
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                // Расписание
                ZStack(alignment: .bottom) {
                    
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            if filteredTickets.isEmpty {
                                VStack {
                                    Text("Вариантов нет")
                                        .font(.custom("SFPro-Bold", size: 24))
                                        .foregroundStyle(Color("dayOrNightColor"))
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 231)
                                }
                            } else {
                                ForEach(filteredTickets) { ticket in
                                    Button(action: {
                                        coordinator.path.append(EnumAppRoute.carrierInfo(ticket))
                                    }) {
                                        TicketCell(ticket: ticket)
                                    }
                                }
                            }
                        }
                    }
                    
                    Button(action: {coordinator.path.append(EnumAppRoute.filters)}) {
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
    }
}

