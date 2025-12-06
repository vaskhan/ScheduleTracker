//
//  Ticket.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 29.06.2025.
//

import SwiftUI

struct TicketModel: Hashable, Identifiable, Sendable {
    let id = UUID()
    let operatorName: String
    let date: String
    let departure: String
    let arrival: String
    let duration: String
    let withTransfer: Bool
    let operatorLogo: String
    let transfer: String?
    let carrierCode: Int?
}
