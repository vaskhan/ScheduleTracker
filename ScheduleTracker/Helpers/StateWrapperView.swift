//
//  StateWrapperView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 25.07.2025.
//
import SwiftUI

struct StateWrapperView<Content: View>: View {
    let isLoading: Bool
    let errorType: AppErrorType?
    let content: () -> Content

    var body: some View {
        Group {
            if isLoading {
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            } else if errorType == .internet {
                ErrorInternetView()
            } else if errorType == .server {
                ErrorServerView()
            } else {
                content()
            }
        }
    }
}
