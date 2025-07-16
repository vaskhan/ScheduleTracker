//
//  StoryCell.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 24.06.2025.
//

import SwiftUI

struct StoryCell: View {
    let story: Story
    let isViewed: Bool
    
    var body: some View {
        let storyHeight: Double = 140
        let storyWidth: Double = 92
        
        ZStack {
            Image(story.previewImageName)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(width: storyWidth, height: storyHeight)
                .opacity(isViewed ? 0.5 : 1.0)
            if !isViewed {
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(Color("blueUniversal"), lineWidth: 4)
                    .frame(width: storyWidth, height: storyHeight)
            }
        }
        .overlay {
            VStack {
                Spacer()
                HStack {
                    Text("Text Text Text Text Text Text Text Text Text")
                        .font(.custom("SFPro-Regular", size: 12))
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .padding(.leading, 8)
                        .padding(.bottom, 12)
                    Spacer()
                }
            }
        }
    }
}
