//
//  StoryView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 13.07.2025.
//

import SwiftUI

struct StoryView: View {
    let story: Story
    
    var body: some View {
        ZStack {
            Color("blackUniversal")
                    .ignoresSafeArea()
            Image(story.backgroundImageName)
                .resizable()
                .scaledToFill()
                .frame(width: 400, height: 780)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .overlay(
                    VStack {
                        Spacer()
                        VStack(alignment: .leading, spacing: 16) {
                            Text(story.title)
                                .font(.custom("SFPro-Bold", size: 34))
                                .lineLimit(2)
                                .foregroundColor(.white)
                            
                            Text(story.description)
                                .font(.custom("SFPro-Regular", size: 20))
                                .lineLimit(3)
                                .foregroundColor(.white)
                        }
                        .padding(.init(top: 0, leading: 16, bottom: 40, trailing: 16))
                    }
                )
        }
        
    }
}

#Preview {
    StoryView(story: .story2)
}
