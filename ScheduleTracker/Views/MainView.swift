//
//  MainView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 29.06.2025.
//

import SwiftUI

struct MainView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: MockReelsModel
    @State private var fromTofromTo = true
    @State private var showAgreement = false
    @ObservedObject var coordinator: NavigationCoordinator
    
    @State private var showStories = false
    @State private var selectedStoryIndex = 0
    @State private var viewedStories: Set<Int> = []
    @State private var pendingStoryIndex: Int?
    
    var body: some View {
        ZStack {
            Color("nightOrDayColor").ignoresSafeArea()
            VStack (spacing: 44){
                ScrollView (.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 12) {
                        ForEach(viewModel.stories.indices.sorted { lhs, rhs in
                            let isViewedL = viewedStories.contains(lhs)
                            let isViewedR = viewedStories.contains(rhs)
                            if isViewedL == isViewedR { return lhs < rhs }
                            return !isViewedL && isViewedR
                        }, id: \.self) { index in
                            Button {
                                selectedStoryIndex = index
                                showStories = true
                                viewedStories.insert(index)
                            } label: {
                                StoryCell(
                                    story: viewModel.stories[index],
                                    isViewed: viewedStories.contains(index)
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .frame(height: 140)
                .fullScreenCover(isPresented: $showStories) {
                    StoriesScreenView(
                        onViewed: { indices in
                            viewedStories.formUnion(indices)
                        }, stories: viewModel.stories,
                        initialIndex: selectedStoryIndex
                    )
                    .preferredColorScheme(.dark)
                }
                VStack(spacing: 16) {
                    ZStack {
                        Color("blueUniversal")
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                NavigationLink(value: EnumAppRoute.cityPicker(fromField: true)) {
                                    Text(fromTofromTo ? (coordinator.selectedCityFrom.isEmpty ? "Откуда" : "\(coordinator.selectedCityFrom) (\(coordinator.selectedStationFrom))")
                                         : (coordinator.selectedCityTo.isEmpty ? "Куда" : "\(coordinator.selectedCityTo) (\(coordinator.selectedStationTo))")
                                    )
                                    .foregroundStyle(
                                        (fromTofromTo
                                         ? coordinator.selectedCityFrom.isEmpty
                                         : coordinator.selectedCityTo.isEmpty
                                        )
                                        ? Color("grayUniversal")
                                        : Color("blackUniversal")
                                    )
                                    .padding(.vertical, 14)
                                    .padding(.horizontal, 16)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                NavigationLink(value: EnumAppRoute.cityPicker(fromField: false)) {
                                    Text(fromTofromTo ? (coordinator.selectedCityTo.isEmpty ? "Куда" : "\(coordinator.selectedCityTo) (\(coordinator.selectedStationTo))")
                                         : (coordinator.selectedCityFrom.isEmpty ? "Откуда" : "\(coordinator.selectedCityFrom) (\(coordinator.selectedStationFrom))")
                                    )
                                    .foregroundStyle(
                                        (fromTofromTo
                                         ? coordinator.selectedCityTo.isEmpty
                                         : coordinator.selectedCityFrom.isEmpty
                                        )
                                        ? Color("grayUniversal")
                                        : Color("blackUniversal")
                                    )
                                    .padding(.vertical, 14)
                                    .padding(.horizontal, 16)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                            )
                            .padding(.horizontal, 16)
                            
                            Button(action: { fromTofromTo.toggle() }) {
                                Image(systemName: "arrow.2.squarepath")
                                    .font(.system(size: 24))
                                    .foregroundStyle(Color("blueUniversal"))
                                    .padding(6)
                                    .background(.white)
                                    .clipShape(Circle())
                            }
                            .padding(.trailing, 16)
                        }
                        .padding(.vertical, 16)
                    }
                    .frame(height: 128)
                    .padding(.horizontal, 16)
                    
                    if !coordinator.selectedCityTo.isEmpty && !coordinator.selectedCityFrom.isEmpty {
                        Button(action: {coordinator.path.append(EnumAppRoute.tickets)}) {
                            Text("Найти")
                                .font(.custom("SFPro-Bold", size: 17))
                                .foregroundStyle(Color(.white))
                        }
                        .padding(.horizontal, 47.5)
                        .padding(.vertical, 20)
                        .background(Color("blueUniversal"))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
                Spacer()
                
                Divider()
                    .frame(height: 3)
            }
            .padding(.top, 24)
        }
    }
}

