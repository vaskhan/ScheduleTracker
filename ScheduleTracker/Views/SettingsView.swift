//
//  SettingsView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 29.06.2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @StateObject var viewModel: SettingsViewModel

    var body: some View {
        ZStack {
            Color("nightOrDayColor").ignoresSafeArea()
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
                
                StateWrapperView(isLoading: viewModel.isLoading, errorType: viewModel.errorType) {
                    Group {
                        if !viewModel.copyrightText.isEmpty {
                            Text(viewModel.copyrightText)
                                .multilineTextAlignment(.center)
                                .lineSpacing(16)
                                .font(.custom("SFPro-Regular", size: 12))
                                .foregroundStyle(Color("dayOrNightColor"))
                        } else {
                            Text("Приложение использует API «Яндекс.Расписания»\nВерсия 1.0 (beta)")
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .lineSpacing(16)
                                .font(.custom("SFPro-Regular", size: 12))
                                .foregroundStyle(Color("dayOrNightColor"))
                        }
                    }
                }
                Divider()
                    .frame(height: 3)
                    .padding(.top, 24)
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
        }
        .task {
            await viewModel.fetchCopyright()
        }
    }
}
