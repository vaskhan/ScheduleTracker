//
//  UserAgreementView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 25.06.2025.
//

import WebKit
import SwiftUI

struct UserAgreementView: View {
    @Environment(\.dismiss) var dismiss
    let agreementURL = URL(string: "https://yandex.ru/legal/practicum_offer")!
    
    var body: some View {
        WebView(url: agreementURL)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image("leftChevron")
                            .renderingMode(.original)
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
