//
//  AppErrorType.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 24.07.2025.
//


import Foundation

enum AppErrorType {
    case none
    case server
    case internet
}

@MainActor
protocol ErrorHandleable: ObservableObject {
    var errorType: AppErrorType { get set }
}

extension ErrorHandleable {
    func handle(error: Error) {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                errorType = .internet
            default:
                errorType = .server
            }
        } else {
            errorType = .server
        }
    }
}
