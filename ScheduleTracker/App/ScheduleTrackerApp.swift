//
//  ScheduleTrackerApp.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 12.06.2025.
//

import SwiftUI

@main
struct ScheduleTrackerApp: App {
    private static var servicesInstance: APIServicesContainer = {
        do {
            return try APIServicesContainer()
        } catch {
            fatalError("Failed to initialize APIServicesContainer: \(error)")
        }
    }()
    
    @StateObject private var services = servicesInstance
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            BaseView()
                .environmentObject(services)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
