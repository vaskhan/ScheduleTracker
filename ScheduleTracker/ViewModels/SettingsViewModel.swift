//
//  SettingsViewModel.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 24.07.2025.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject, ErrorHandleable {
    @Published var copyrightText: String = ""
    @Published var copyrightURL: URL?
    @Published var errorType: AppErrorType = .none
    @Published var isLoading = false

    private let copyrightService: CopyrightServiceProtocol

    init(copyrightService: CopyrightServiceProtocol) {
        self.copyrightService = copyrightService
    }

    func fetchCopyright() async {
        isLoading = true
        errorType = .none
        defer { isLoading = false }
        do {
            let copyright = try await copyrightService.getCopyright()
            if let text = copyright.copyright?.text {
                self.copyrightText = text
            }
            if let urlStr = copyright.copyright?.url, let url = URL(string: urlStr) {
                self.copyrightURL = url
            }
        } catch {
            handle(error: error)
        }
    }
}

