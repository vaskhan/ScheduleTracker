//
//  CarrierServiceProtocol.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 13.06.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Carrier = Components.Schemas.CarrierResponse

protocol CarrierServiceProtocol {
    func getCarrierInfo(code: String) async throws -> Carrier
}

final class CarrierService: CarrierServiceProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCarrierInfo(code: String) async throws -> Carrier {
        let response = try await client.getCarrierInfo(query: .init(apikey: apikey, code: code))
        
        return try response.ok.body.json
    }
}
