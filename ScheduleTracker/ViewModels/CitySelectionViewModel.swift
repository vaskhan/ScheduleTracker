//
//  CitySelectionViewModel.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 21.07.2025.
//

import Foundation
import Combine

@MainActor
final class CitySelectionViewModel: ObservableObject, ErrorHandleable {
    @Published private(set) var allCities: [String] = []
    @Published private(set) var filteredCities: [String] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = "" {
        didSet { filterCities() }
    }
    @Published var errorType: AppErrorType = .none
    private let stationListService: StationListServiceProtocol
    private var allSettlements: [Components.Schemas.StationsList.countriesPayloadPayload.regionsPayloadPayload.settlementsPayloadPayload] = []
    private var loadTask: Task<Void, Never>?
    
    init(stationListService: StationListServiceProtocol) {
        self.stationListService = stationListService
        loadCities()
    }
    
    func loadCities() {
        isLoading = true
        errorType = .none
        loadTask?.cancel()
        loadTask = Task { [weak self] in
            guard let self else { return }
            do {
                let stationsList = try await stationListService.getAllStations()
                let settlements = stationsList.countries?
                    .flatMap { $0.regions ?? [] }
                    .flatMap { $0.settlements ?? [] }
                    ?? []
                self.allSettlements = settlements
                let cities = settlements
                    .compactMap { $0.title }
                    .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
                    .removingDuplicates()
                self.allCities = cities
                self.filterCities()
            } catch {
                self.handle(error: error)
            }
            self.isLoading = false
        }
    }
    
    private func filterCities() {
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if text.isEmpty {
            filteredCities = allCities
        } else {
            filteredCities = allCities.filter { $0.localizedCaseInsensitiveContains(text) }
        }
    }
}

private extension Array where Element == String {
    func removingDuplicates() -> [String] {
        var set = Set<String>()
        return filter { set.insert($0).inserted }
    }
}
