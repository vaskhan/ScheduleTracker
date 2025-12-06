//
//  ThreadServiceProtocol.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 13.06.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Thread = Components.Schemas.Thread

@preconcurrency protocol ThreadServiceProtocol {
    func getRouteStations(uid: String) async throws -> Thread
}

actor ThreadService: ThreadServiceProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getRouteStations(uid: String) async throws -> Thread {
        let response = try await client.getThread(query: .init(apikey: apikey, uid: uid))
        
        return try response.ok.body.json
    }
}
