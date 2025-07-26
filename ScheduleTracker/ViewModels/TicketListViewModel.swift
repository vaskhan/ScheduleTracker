//
//  TicketListViewModel.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 20.07.2025.
//

import Foundation
import Combine

@MainActor
final class TicketListViewModel: ObservableObject, ErrorHandleable {
    @Published var tickets: [TicketModel] = []
    @Published var isLoading = false
    @Published var errorType: AppErrorType = .none
    @Published var showTransfers: Bool?
    @Published var timeFilters: Set<TimePeriod> = []

    private let searchService: SearchServiceProtocol
    let fromStation: String
    let toStation: String

    init(
        searchService: SearchServiceProtocol,
        fromStation: String,
        toStation: String,
        showTransfers: Bool?,
        timeFilters: Set<TimePeriod> = []
    ) {
        self.searchService = searchService
        self.fromStation = fromStation
        self.toStation = toStation
        self.showTransfers = showTransfers
        self.timeFilters = timeFilters
    }

    func loadTickets() async {
        isLoading = true
        errorType = .none
        do {
            let search = try await searchService.getScheduleBetweenStations(from: fromStation, to: toStation)
            self.tickets = TicketListViewModel.parseTickets(from: search)
        } catch {
            self.handle(error: error)
            self.tickets = []
        }
        isLoading = false
    }

    var filteredTickets: [TicketModel] {
        tickets.filter { ticket in
            if let show = showTransfers, show != ticket.withTransfer { return false }
            if !timeFilters.isEmpty {
                let depHour = Int(ticket.departure.prefix(2)) ?? 0
                let period: TimePeriod = {
                    switch depHour {
                    case 6..<12: return .morning
                    case 12..<18: return .day
                    case 18..<24: return .evening
                    default: return .night
                    }
                }()
                if !timeFilters.contains(period) { return false }
            }
            return true
        }
    }

    static func parseTickets(from search: Search) -> [TicketModel] {
        guard let segments = search.segments else { return [] }
        return segments.compactMap { seg in
            let thread = seg.thread
            let carrier = thread?.carrier
            
            let departureTime = parseDateOrTime(seg.departure ?? "", asTime: true)
            let arrivalTime = parseDateOrTime(seg.arrival ?? "", asTime: true)
            let date = parseDateOrTime(seg.start_date ?? "", asTime: false)

            let durationSeconds = Int(seg.duration ?? 0)
            let hours = durationSeconds / 3600
            let minutes = (durationSeconds % 3600) / 60

            let durationString: String
            if hours > 0 {
                durationString = "\(hours) ч \(minutes) мин"
            } else if minutes > 0 {
                durationString = "\(minutes) мин"
            } else {
                durationString = "—"
            }

            return TicketModel(
                operatorName: carrier?.title ?? "—",
                date: date,
                departure: departureTime,
                arrival: arrivalTime,
                duration: durationString,
                withTransfer: seg.has_transfers ?? false,
                operatorLogo: carrier?.logo ?? "",
                transfer: seg.stops,
                carrierCode: carrier?.code.flatMap { Int($0) }
            )
        }
    }

    static func parseDateOrTime(_ isoString: String, asTime: Bool = false) -> String {
        if isoString.range(of: #"^\d{2}:\d{2}(:\d{2})?$"#, options: .regularExpression) != nil {
            return asTime ? String(isoString.prefix(5)) : "—"
        }
        let formats = [
            "yyyy-MM-dd'T'HH:mm:ssZ",
            "yyyy-MM-dd'T'HH:mm:ss",
            "yyyy-MM-dd HH:mm:ss",
            "yyyy-MM-dd HH:mm",
            "yyyy-MM-dd"
        ]
        for format in formats {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ru_RU")
            formatter.timeZone = .current
            formatter.dateFormat = format
            if let date = formatter.date(from: isoString) {
                let outFormatter = DateFormatter()
                outFormatter.locale = Locale(identifier: "ru_RU")
                outFormatter.timeZone = .current
                outFormatter.dateFormat = asTime ? "HH:mm" : "d MMMM"
                return outFormatter.string(from: date)
            }
        }
        return "—"
    }

}
