//
//  CarrierInfoViewModel.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 24.07.2025.
//

import Foundation

@MainActor
final class CarrierInfoViewModel: ObservableObject, ErrorHandleable {
    @Published var carrier: CarrierInfoModel?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var errorType: AppErrorType = .none
    
    private let service: CarrierServiceProtocol
    
    init(service: CarrierServiceProtocol) {
        self.service = service
    }
    
    func fetchCarrier(code: String) async {
        isLoading = true
        errorType = .none
        do {
            let response = try await service.getCarrierInfo(code: code)
            guard let carrier = response.carrier else {
                errorMessage = "Не найдено информации о перевозчике"
                isLoading = false
                return
            }
            self.carrier = CarrierInfoModel(
                code: carrier.code ?? 0,
                title: carrier.title ?? "—",
                logo: carrier.logo,
                email: carrier.email,
                phone: carrier.phone
            )
        } catch {
            self.handle(error: error)
        }
        isLoading = false
    }
}

