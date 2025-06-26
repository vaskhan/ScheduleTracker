//
//  ChangeStationView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 26.06.2025.
//

import SwiftUI

struct ChangeStationView: View {
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss
    
    let items = ["Киевский вокзал", "Курский вокзал", "Ярославский вокзал", "Белорусский вокзал", "Савеловский вокзал", "Ленинградский вокзал"]
    
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
                Text("Выбор станции")
                    .font(.custom("SFPro-Bold", size: 17))
                    .foregroundStyle(Color("dayOrNightColor"))
            }
        }
        
    }
}

#Preview {
    ChangeStationView()
}
