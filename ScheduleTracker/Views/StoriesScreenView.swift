import SwiftUI
import Combine

struct StoriesScreenView: View {
    struct Configuration {
        let timerTickInternal: TimeInterval
        let progressPerTick: CGFloat
        
        init(
            storiesCount: Int,
            secondsPerStory: TimeInterval = 5,
            timerTickInternal: TimeInterval = 0.05
        ) {
            self.timerTickInternal = timerTickInternal
            self.progressPerTick = 1.0 / secondsPerStory * timerTickInternal
        }
    }
    
    let onViewed: (Set<Int>) -> Void
    private let stories: [Story]
    private let configuration: Configuration
    @State private var selection: Int
    @State private var progress: CGFloat = 0
    @State private var timer: Timer.TimerPublisher
    @State private var cancellable: Cancellable?
    @State private var localViewedStories: Set<Int> = []
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Environment(\.dismiss) var dismiss
    
    init(onViewed: @escaping (Set<Int>) -> Void, stories: [Story], initialIndex: Int) {
        self.onViewed = onViewed
        self.stories = stories
        _selection = State(initialValue: initialIndex)
        configuration = Configuration(storiesCount: stories.count)
        timer = Self.createTimer(configuration: configuration)
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color("blackUniversal")
                    .ignoresSafeArea()
            TabView(selection: $selection) {
                ForEach(stories.indices, id: \.self) { index in
                    ZStack {
                        StoryView(story: stories[index])
                        HStack(spacing: 0) {
                            Color.clear
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    if selection > 0 {
                                        selection -= 1
                                        progress = 0
                                        resetTimer()
                                    }
                                }
                            Color.clear
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    goToNextStoryOrDismiss()
                                }
                        }
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onChange(of: selection) {
                localViewedStories.insert(selection)
                progress = 0
                resetTimer()
            }
            
            ProgressBar(numberOfSections: stories.count, progress: CGFloat(selection) + progress)
                .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            CloseButton(action: { dismiss() })
                .padding(.top, 57)
                .padding(.trailing, 12)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
        .onAppear {
            localViewedStories.insert(selection)
            timer = Self.createTimer(configuration: configuration)
            cancellable = timer.connect()
        }
        .onDisappear {
            cancellable?.cancel()
            onViewed(localViewedStories)
        }
        .onReceive(timer) { _ in
            timerTick()
        }
    }
    
    private func timerTick() {
        let nextProgress = progress + configuration.progressPerTick
        if nextProgress >= 1 {
            goToNextStoryOrDismiss()
        }
        withAnimation {
            progress = nextProgress
        }
    }
    
    private func goToNextStoryOrDismiss() {
        if selection < stories.count - 1 {
            selection += 1
            progress = 0
        } else {
            onViewed(localViewedStories)
            dismiss()
        }
    }
    
    private func resetTimer() {
        cancellable?.cancel()
        timer = Self.createTimer(configuration: configuration)
        cancellable = timer.connect()
    }
    
    private static func createTimer(configuration: Configuration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
}
