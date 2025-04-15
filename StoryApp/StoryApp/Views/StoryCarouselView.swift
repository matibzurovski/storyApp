//
//  StoryCarouselView.swift
//  StoryApp
//
//  Created by Matias Bzurovski on 15/04/2025.
//

import SwiftUI

/// A view displaying all the stories as a carousel, allowing the user to view and interact with the stories without going back to feed.
struct StoryCarouselView: View {
	@Bindable var viewModel: StoryListViewModel
	@Binding var selectedIndex: Int
	
	var body: some View {
		TabView(selection: $selectedIndex) {
			ForEach(viewModel.stories.indices, id: \.self) { index in
				StoryView(story: viewModel.stories[index], viewModel: viewModel, isActive: selectedIndex == index)
					.tag(index)
			}
		}
		.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
		.background(Color.black.ignoresSafeArea())
	}
}
