//
//  MockReelsModel.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 24.06.2025.
//

import Foundation

@Observable class MockReelsModel: ObservableObject {
    var reels: [ReelsModel]
    
    init() {
        let reels1 = ReelsModel(imageName: "mockReels4")
        let reels2 = ReelsModel(imageName: "mockReels3")
        let reels3 = ReelsModel(imageName: "mockReels2")
        let reels4 = ReelsModel(imageName: "mockReels1")
        
        self.reels = [reels1, reels2, reels3, reels4]
    }
}
