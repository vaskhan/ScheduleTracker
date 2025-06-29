//
//  CustomSearchBar.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 27.06.2025.
//


import SwiftUI

struct CustomSearchBar: View {
    @Binding var text: String
    var placeholder: String = "Введите запрос"
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color("grayUniversal"))
            
            TextField(placeholder, text: $text)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color("grayUniversal"))
                }
            }
        }
        .padding(10)
        .background(Color(.backgroundSearchbar))
        .cornerRadius(10)
        .padding(.horizontal, 16)
    }
}
