//
//  SearchServiceProtocol.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 13.06.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Search = Components.Schemas.SearchSchema

protocol SearchServiceProtocol {
    func getSchedualBetweenStations(from: String, to: String) async throws -> Search
}

final class SearchService: SearchServiceProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getSchedualBetweenStations(from: String, to: String) async throws -> Search {
        let response = try await client.getSearch(query: .init(apikey: apikey, from: from, to: to))
        
        return try response.ok.body.json
    }
}


