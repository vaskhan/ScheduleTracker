//
//  ErrorServerView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 28.06.2025.
//

import SwiftUI

struct ErrorServerView: View {
    var body: some View {
        ZStack {
            Color("nightOrDayColor").ignoresSafeArea()
            VStack (spacing: 16) {
                Image("errorServerImage")
                Text("Ошибка сервера")
                    .font(.custom("SFPro-Bold", size: 24))
                    .foregroundStyle(Color("dayOrNightColor"))
            }
        }
    }
}

#Preview {
    ErrorServerView()
}
