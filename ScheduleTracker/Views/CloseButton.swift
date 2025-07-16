//
//  CloseButton.swift
//  Stories-Demo
//
//  Created by Василий Ханин on 12.07.2025.
//

import SwiftUI

struct CloseButton: View {
    let action: () -> Void
    
    var body: some View {
        Button("", image: .closeButton) {
            action()
        }
    }
}
