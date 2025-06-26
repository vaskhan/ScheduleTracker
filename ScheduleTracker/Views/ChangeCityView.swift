//
//  ChangeCityView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 26.06.2025.
//

import SwiftUI

struct ChangeCityView: View {
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss
    
    let items = ["Москва", "Санкт-Петербург", "Сочи", "Горный воздух", "Краснодар", "Казань", "Омск"]
    
    var filteredItems: [String] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView (.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading) {
                    if filteredItems.isEmpty {
                        VStack {
                            Spacer()
                            Text("Город не найден")
                                .font(.custom("SFPro-Bold", size: 24))
                                .foregroundStyle(Color("dayOrNightColor"))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                            Spacer()
                        }
                    } else {
                        ForEach(filteredItems, id: \.self) { item in
                            HStack {
                                NavigationLink(destination: ChangeStationView()) {
                                    Text("\(item)")
                                        .font(.custom("SFPro-Regular", size: 17))
                                        .foregroundStyle(Color("dayOrNightColor"))
                                    
                                    Spacer()
                                    
                                    Image("rightChevron")
                                }
                                .padding(.vertical, 19)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .searchable(text: $searchText, prompt: "Введите запрос")
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image("leftChevron")
                        .renderingMode(.original)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("Выбор города")
                    .font(.custom("SFPro-Bold", size: 17))
                    .foregroundStyle(Color("dayOrNightColor"))
            }
        }
    }
}

#Preview {
    ChangeCityView()
}
