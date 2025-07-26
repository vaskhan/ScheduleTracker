//
//  StationListServiceProtocol.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 13.06.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias AllStation = Components.Schemas.StationsList

@preconcurrency protocol StationListServiceProtocol {
    func getAllStations() async throws -> AllStation
}

actor StationtService: StationListServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getAllStations() async throws -> AllStation {
        let response = try await client.getStationsList(query: .init(apikey: apikey))
        
        let responseBody = try response.ok.body.html
        
        let limit = 50 * 1024 * 1024 // 50Mb
        let fullData = try await Data(collecting: responseBody, upTo: limit)
        
        let allStations = try JSONDecoder().decode(AllStation.self, from: fullData)
        
        return allStations
    }
}

