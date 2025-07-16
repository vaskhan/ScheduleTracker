//
//  UserAgreementView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 25.06.2025.
//

import WebKit
import SwiftUI

struct UserAgreementView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Environment(\.dismiss) var dismiss
    private let agreementURLString = "https://yandex.ru/legal/practicum_offer"
    
    var body: some View {
        ZStack {
            Color("nightOrDayColor").ignoresSafeArea()
            if let agreementURL = URL(string: agreementURLString) {
                WebView(url: agreementURL)
                    .id(isDarkMode)
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: { dismiss() }) {
                                Image("leftChevron")
                                    .renderingMode(.template)
                                    .foregroundStyle(Color("dayOrNightColor"))
                            }
                        }
                        
                        ToolbarItem(placement: .principal) {
                            Text("Пользовательское соглашение")
                                .font(.custom("SFPro-Bold", size: 17))
                                .foregroundStyle(Color("dayOrNightColor"))
                        }
                    }
            }
        }
    }
}
