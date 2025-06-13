//
//  ContentView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 12.06.2025.
//

import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    var body: some View {
        VStack {
            Image("bus")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Расписание")
                .font(.system(size: 30))
                .fontWeight(.medium)
        }
        .padding()
        .onAppear {
            // Вызываем нашу тестовую функцию при появлении View
//            testFetchStations()
//            testCopyright()
//            testSearchRoute()
//            testScheduleStation()
//            testThreadService()
//            testNearestSettlement()
//            testCarrierInfo()
//            testAllStations()
        }
    }
    // Функция для тестового вызова API
    func testFetchStations() {
        // Создаём Task для выполнения асинхронного кода
        Task {
            do {
                let service = try APIServicesContainer()
                
                // 3. Вызываем метод сервиса
                print("Fetching stations...")
                let stations = try await service.nearestStationsService.getNearestStations(
                    lat: 59.864177, // Пример координат
                    lng: 30.319163, // Пример координат
                    distance: 2    // Пример дистанции
                )
                
                // 4. Если всё успешно, печатаем результат в консоль
                print("Successfully fetched stations: \(stations)")
            } catch {
                // 5. Если произошла ошибка на любом из этапов (создание клиента, вызов сервиса, обработка ответа),
                //    она будет поймана здесь, и мы выведем её в консоль
                print("Error fetching stations: \(error)")
                // В реальном приложении здесь должна быть логика обработки ошибок (показ алерта и т. д.)
            }
        }
    }
    
    func testCopyright() {
        Task {
            do {
                let service = try APIServicesContainer()
                let copyright = try await service.copyrightService.getCopyright()
                
                print("Successfully fetched copyright: \(copyright)")
            }
            catch {
                print("Error fetching copyright: \(error)")
            }
        }
    }
    
    func testSearchRoute() {
        Task {
            do {
                let service = try APIServicesContainer()
                let search = try await service.searchService.getSchedualBetweenStations(from: "s9600213", to: "c146")
                
                print("Successfully fetched search route: \(search)")
            }
            catch {
                print("Error fetching search route: \(error)")
            }
        }
    }
    
    func testScheduleStation() {
        Task {
            do {
                let service = try APIServicesContainer()
                let schedule = try await service.scheduleService.getStationSchedule(station: "s9600215")
                
                print("Successfully fetched station shedule: \(schedule)")
            }
            catch {
                print("Error fetching station shedule: \(error)")
            }
        }
    }
    
    func testThreadService() {
        Task {
            do {
                let service = try APIServicesContainer()
                let threadService = try await service.threadService.getRouteStations(uid: "ZF-1005_250630_c59268_12")
                
                print("Succesfully fetched threadRouteStations: \(threadService)")
            }
            catch {
                print("Error fetching threadRouteStations: \(error)")
            }
        }
    }
    
    func testNearestSettlement() {
        Task {
            do {
                let service = try APIServicesContainer()
                let settlement = try await service.settlementService.getNearestCity(lat: 59.864177, lng: 30.319163)
        
                print("Successfully fetched settlement: \(settlement)")
            } catch {
                print("Error fetching settlement: \(error)")
            }
        }
    }
    
    func testCarrierInfo() {
        Task {
            do {
                let service = try APIServicesContainer()
                let carrier = try await service.carrierService.getCarrierInfo(code: "153")
        
                print("Successfully fetched carrier: \(carrier)")
            } catch {
                print("Error fetching carrier: \(error)")
            }
        }
    }
    
    func testAllStations() {
        Task {
            do {
                let service = try APIServicesContainer()
                let stations = try await service.allStationService.getAllStations()
                
                print("Successfully fetched all stations: \(String(describing: stations.countries?.count))")
            }
            catch {
                print("Error fetching all stations: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
