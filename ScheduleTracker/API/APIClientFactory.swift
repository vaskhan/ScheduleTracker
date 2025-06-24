//
//  APIClientFactory.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 12.06.2025.
//

import OpenAPIURLSession

final class APIClientFactory {
    static func makeClient() throws -> Client {
        try Client(
            serverURL: Servers.Server1.url(),
            transport: URLSessionTransport()
        )
    }
}
