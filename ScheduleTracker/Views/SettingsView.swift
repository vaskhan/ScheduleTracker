//
//  SettingsView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 29.06.2025.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        VStack {
            Toggle(isOn: $isDarkMode) {
                Text("Темная тема")
                    .font(.custom("SFPro-Regular", size: 17))
                    .foregroundStyle(Color("dayOrNightColor"))
            }
            .tint(Color("blueUniversal"))
            .padding(.vertical, 19)
            
            HStack {
                NavigationLink(destination: UserAgreementView()) {
                    Text("Пользовательское соглашение")
                        .font(.custom("SFPro-Regular", size: 17))
                        .foregroundStyle(Color("dayOrNightColor"))
                    
                    Spacer()
                    
                    Image("rightChevron")
                        .renderingMode(.template)
                        .foregroundStyle(Color("dayOrNightColor"))
                }
                .padding(.vertical, 19)
            }
            
            Spacer()
            
            Text("Приложение использует API «Яндекс.Расписания»\nВерсия 1.0 (beta)")
                .multilineTextAlignment(.center)
                .lineSpacing(16)
                .font(.custom("SFPro-Regular", size: 12))
                .foregroundStyle(Color("dayOrNightColor"))
            
            Divider()
                .frame(height: 3)
                .padding(.top, 24)
        }
        .padding(.horizontal, 16)
        .padding(.top, 24)
    }
}

#Preview {
    SettingsView()
}
