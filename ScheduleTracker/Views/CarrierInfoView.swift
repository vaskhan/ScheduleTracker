//
//  CarrierInfoView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 29.06.2025.
//

import SwiftUI


struct CarrierInfoView: View {
    @Environment(\.dismiss) var dismiss
    let carrier: TicketModel
    
    var body: some View {
        VStack(spacing: 24) {
            Image(carrier.operatorLogo)
                .resizable()
                .scaledToFit()
                .frame(width: 343, height: 104)
                .padding(.top, 16)
            VStack(alignment: .leading, spacing: 4) {
                Text(carrier.operatorName)
                    .font(.custom("SFPro-Bold", size: 24))
                    .padding(.vertical, 16)
                // email
                Text("E-mail")
                    .font(.custom("SFPro-Regular", size: 16))
                    .foregroundColor(.secondary)
                Link("i.lozgkina@yandex.ru", destination: URL(string: "mailto:i.lozgkina@yandex.ru")!)
                    .font(.custom("SFPro-Regular", size: 16))
                    .foregroundColor(.blue)
                // телефон
                Text("Телефон")
                    .font(.custom("SFPro-Regular", size: 16))
                    .foregroundColor(.secondary)
                Link("+7 (904) 329-27-71", destination: URL(string: "tel:+79043292771")!)
                    .font(.custom("SFPro-Regular", size: 16))
                    .foregroundColor(.blue)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 16)
            Spacer()
        }
        .padding()
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
                Text("Информация о перевозчике")
                    .font(.custom("SFPro-Bold", size: 17))
                    .foregroundStyle(Color("dayOrNightColor"))
            }
        }
    }
}
