//
//  EnumTimePeriod.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 29.06.2025.
//


enum TimePeriod: String, CaseIterable, Hashable {
    case morning = "Утро 06:00 - 12:00"
    case day = "День 12:00 - 18:00"
    case evening = "Вечер 18:00 - 00:00"
    case night = "Ночь 00:00 - 06:00"
}
