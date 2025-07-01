//
//  ReelsCell.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 24.06.2025.
//

import SwiftUI

struct ReelsCell: View {
    var reels: ReelsModel
    
    var body: some View {
        let reelsHeight: Double = 140
        let reelsWidth: Double = 92
        
        ZStack {
            Image(reels.imageName)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(width: reelsWidth, height: reelsHeight)
            
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color("blueUniversal"), lineWidth: 4)
                .frame(width: reelsWidth, height: reelsHeight)
        }
    }
}

#Preview {
    let mockReels = ReelsModel(imageName: "mockReels1")
    return ReelsCell(reels: mockReels)
        .padding()
        .background(Color(.systemBackground))
}
