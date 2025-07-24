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
                if let url = URL(string: ticket.operatorLogo) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 38, height: 38)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 220, height: 38, alignment: .leading)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .clipped()
                }
                
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

