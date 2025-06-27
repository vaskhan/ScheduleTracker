//
//  EnumAppRoute.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 27.06.2025.
//


enum EnumAppRoute: Hashable {
    case cityPicker(fromField: Bool)
    case stationPicker(city: String, fromField: Bool)
}
