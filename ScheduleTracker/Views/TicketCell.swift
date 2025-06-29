//
//  TicketCell.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 28.06.2025.
//


import SwiftUI

struct TicketCell: View {
    let ticket: TicketModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(ticket.operatorLogo)
                    .resizable()
                    .frame(width: 38, height: 38)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                VStack(alignment: .leading, spacing: 2) {
                    Text(ticket.operatorName)
                        .font(.custom("SFPro-Regular", size: 17))
                        .foregroundStyle(Color("blackUniversal"))
                    if let note = ticket.note {
                        Text(note)
                            .font(.custom("SFPro-Regular", size: 17))
                            .foregroundStyle(Color("redUniversal"))
                    }
                }
                Spacer()
                Text(ticket.date)
                    .font(.custom("SFPro-Regular", size: 12))
                    .foregroundStyle(Color("blackUniversal"))
            }
            .padding(.bottom, 5)
            HStack {
                Text(ticket.departure)
                    .font(.custom("SFPro-Regular", size: 17))
                    .foregroundStyle(Color("blackUniversal"))
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(Color("grayUniversal"))
                Text(ticket.duration)
                    .font(.custom("SFPro-Regular", size: 12))
                    .foregroundStyle(Color("blackUniversal"))
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(Color("grayUniversal"))
                Text(ticket.arrival)
                    .font(.custom("SFPro-Regular", size: 17))
                    .foregroundStyle(Color("blackUniversal"))
            }
        }
        .padding()
        .background(Color(.lightGrayUniversal))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

