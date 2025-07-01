//
//  FiltersView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 28.06.2025.
//


import SwiftUI

struct FiltersView: View {
    @ObservedObject var coordinator: NavigationCoordinator
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Время отправления")
                .font(.custom("SFPro-Bold", size: 24))
                .foregroundStyle(Color("dayOrNightColor"))
            ForEach(TimePeriod.allCases, id: \.self) { period in
                HStack {
                    Text(period.rawValue)
                        .font(.custom("SFPro-Regular", size: 17))
                        .foregroundStyle(Color("dayOrNightColor"))
                    Spacer()
                    Button(action: {
                        if coordinator.timeFilters.contains(period) {
                            coordinator.timeFilters.remove(period)
                        } else {
                            coordinator.timeFilters.insert(period)
                        }
                    }) {
                        Image(systemName: coordinator.timeFilters.contains(period) ? "checkmark.square.fill" : "square")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(Color("dayOrNightColor"))
                    }
                }
                .frame(height: 60)
                .padding(.trailing, 2)
            }
            
            Text("Показывать варианты с пересадками")
                .font(.system(size: 20, weight: .bold))
                .padding(.top, 16)
            HStack {
                Text("Да")
                    .font(.custom("SFPro-Regular", size: 17))
                    .foregroundStyle(Color("dayOrNightColor"))
                Spacer()
                Button(action: { coordinator.showTransfers = true }) {
                    Image(coordinator.showTransfers == true ? "middleCircleFill" : "justCircle")
                        .renderingMode(.template)
                        .resizable()
                        .foregroundStyle(Color("dayOrNightColor"))
                        .frame(width: 24, height: 24)
                }
                .frame(height: 60)
                .padding(.trailing, 2)
            }
            HStack {
                Text("Нет")
                    .font(.custom("SFPro-Regular", size: 17))
                    .foregroundStyle(Color("dayOrNightColor"))
                Spacer()
                Button(action: { coordinator.showTransfers = false }) {
                    Image(coordinator.showTransfers == false ? "middleCircleFill" : "justCircle")
                        .renderingMode(.template)
                        .resizable()
                        .foregroundStyle(Color("dayOrNightColor"))
                        .frame(width: 24, height: 24)
                }
                .frame(height: 60)
                .padding(.trailing, 2)
            }
            Spacer()
            if coordinator.isFiltersValid {
                Button(action: {coordinator.path.removeLast()}) {
                    Text("Применить")
                        .font(.custom("SFPro-Bold", size: 17))
                        .foregroundStyle(Color(.white))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                }
                .background(Color("blueUniversal"))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.bottom, 24)
            }
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image("leftChevron")
                        .renderingMode(.template)
                        .foregroundStyle(Color("dayOrNightColor"))
                }
            }
        }
    }
}
