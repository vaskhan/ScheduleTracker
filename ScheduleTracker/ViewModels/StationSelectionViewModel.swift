//
//  StationSelectionViewModel.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 21.07.2025.
//


import Foundation
import Combine

@MainActor
final class StationSelectionViewModel: ObservableObject, ErrorHandleable {
    @Published private(set) var allStations: [StationModel] = []
    @Published private(set) var filteredStations: [StationModel] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = "" {
        didSet { filterStations() }
    }
    @Published var errorType: AppErrorType = .none
    
    private let stationListService: StationListServiceProtocol
    private let city: String
    private var loadTask: Task<Void, Never>?

    init(stationListService: StationListServiceProtocol, city: String) {
        self.stationListService = stationListService
        self.city = city
        loadStations()
    }

    func loadStations() {
        isLoading = true
        errorType = .none
        loadTask = Task { [weak self] in
            guard let self else { return }
            do {
                let stationsList = try await stationListService.getAllStations()
                let settlements = stationsList.countries?
                    .flatMap { $0.regions ?? [] }
                    .flatMap { $0.settlements ?? [] }
                    ?? []
                let settlement = settlements.first { $0.title == self.city }
                let stations = settlement?.stations ?? []

                let StationModels = stations
                    .compactMap { station in
                        guard let title = station.title,
                              let code = station.codes?.yandex_code
                        else { return nil }
                        return StationModel(id: code, title: title)
                    }
                    .removingDuplicates()
                self.allStations = StationModels
                self.filterStations()
            } catch {
                handle(error: error)
            }
            self.isLoading = false
        }
    }

    private func filterStations() {
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if text.isEmpty {
            filteredStations = allStations
        } else {
            filteredStations = allStations.filter { $0.title.localizedCaseInsensitiveContains(text) }
        }
    }
}

private extension Array where Element == StationModel {
    func removingDuplicates() -> [StationModel] {
        var set = Set<String>()
        return filter { set.insert($0.id).inserted }
    }
}
