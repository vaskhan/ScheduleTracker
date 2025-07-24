//
//  ScheduleTrackerApp.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 12.06.2025.
//

import SwiftUI

@main
struct ScheduleTrackerApp: App {
    @StateObject private var services = try! APIServicesContainer()
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            BaseView()
                .environmentObject(services)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
