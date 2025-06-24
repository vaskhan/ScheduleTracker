//
//  NearestSettlementServiceProtocol.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 13.06.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Settlement = Components.Schemas.Settlement

protocol NearestSettlementServiceProtocol {
    func getNearestCity(lat: Double, lng: Double) async throws -> Settlement
}

final class SettlementService: NearestSettlementServiceProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getNearestCity(lat: Double, lng: Double) async throws -> Settlement {
        let response = try await client.getNearestSettlement(query: .init(apikey: apikey, lat: lat, lng: lng))
        
        return try response.ok.body.json
    }
}



