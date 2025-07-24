//
//  APIServicesContainer.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 12.06.2025.
//
import Combine

final class APIServicesContainer: ObservableObject {
    let nearestStationsService: NearestStationsServiceProtocol
    let copyrightService: CopyrightServiceProtocol
    let searchService: SearchServiceProtocol
    let scheduleService: ScheduleServiceProtocol
    let threadService: ThreadServiceProtocol
    let settlementService: NearestSettlementServiceProtocol
    let carrierService: CarrierServiceProtocol
    let allStationService: StationListServiceProtocol
    
    init() throws {
        let client = try APIClientFactory.makeClient()
        let key = Constants.API.keyApi
        
        self.nearestStationsService = NearestStationsService(client: client, apikey: key)
        self.copyrightService = CopyrightService(client: client, apikey: key)
        self.searchService = SearchService(client: client, apikey: key)
        self.scheduleService = ScheduleService(client: client, apikey: key)
        self.threadService = ThreadService(client: client, apikey: key)
        self.settlementService = SettlementService(client: client, apikey: key)
        self.carrierService = CarrierService(client: client, apikey: key)
        self.allStationService = StationtService(client: client, apikey: key)
    }
}
