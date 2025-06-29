//
//  ErrorInternetView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 28.06.2025.
//

import SwiftUI

struct ErrorInternetView: View {
    var body: some View {
        VStack (alignment: .center, spacing: 16) {
            Image("errorInternetImage")
            Text("Нет интернета")
                .font(.custom("SFPro-Bold", size: 24))
                .foregroundStyle(Color("dayOrNightColor"))
        }
    }
}

#Preview {
    ErrorInternetView()
}
