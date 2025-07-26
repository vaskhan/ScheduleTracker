import SwiftUI

struct Story: Identifiable, Sendable {
    let id = UUID()
    let previewImageName: String
    let fullImageName: String
    let title: String
    let description: String

    static let story1 = Story(
        previewImageName: "mockReels4Prev",
        fullImageName: "mockReels4Full",
        title: "Text Text Text Text Text Text Text Text Text Text",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    )

    static let story2 = Story(
        previewImageName: "mockReels3Prev",
        fullImageName: "mockReels3Full",
        title: "Text Text Text Text Text Text Text Text Text Text",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    )

    static let story3 = Story(
        previewImageName: "mockReels2Prev",
        fullImageName: "mockReels2Full",
        title: "Text Text Text Text Text Text Text Text Text Text",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    )
    
    static let story4 = Story(
        previewImageName: "mockReels1Prev",
        fullImageName: "mockReels1Full",
        title: "Text Text Text Text Text Text Text Text Text Text",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    )
}

