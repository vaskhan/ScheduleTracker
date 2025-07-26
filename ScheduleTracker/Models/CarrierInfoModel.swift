//
//  CarrierInfoModel.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 24.07.2025.
//

import Foundation

struct CarrierInfoModel: Identifiable, Sendable {
    var id: Int { code }
    let code: Int
    let title: String
    let logo: String?
    let email: String?
    let phone: String?
}

