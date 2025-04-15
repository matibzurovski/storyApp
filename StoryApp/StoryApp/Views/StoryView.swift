//
//  StoryView.swift
//  StoryApp
//
//  Created by Matias Bzurovski on 15/04/2025.
//

import SwiftUI

/// A view showing the detail of a Story.
/// It also interacts with the `StoryListViewModel` since it needs to update its like/seen status.
struct StoryView: View {
	@State private(set) var story: Story
	@Bindable var viewModel: StoryListViewModel
	let isActive: Bool
	
	var body: some View {
		VStack(spacing: 8) {
			AsyncImage(url: story.imageUrl) { image in
				image.resizable().aspectRatio(contentMode: .fit)
			} placeholder: {
				ProgressView()
					.tint(.white)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
			}
			
			HStack {
				Spacer()
				Button {
					story.isLiked.toggle()
					viewModel.update(story)
				} label: {
					Image(systemName: story.isLiked ? "heart.fill" : "heart")
						.resizable()
						.padding(8)
				}
				.frame(width: 44, height: 44)
			}
			.padding(.trailing, 24)
			.foregroundStyle(story.isLiked ? .red : .white)
		}
		.background(.black)
		.onChange(of: isActive) { _, newValue in
			// We need to do this custom solution because if we used `onAppear()`, it would be called before actually showing up
			// due to the way the `TabView` (inside `StoryCarouselView`) works.
			if newValue, !story.isSeen {
				story.isSeen = true
				viewModel.update(story)
			}
		}
	}
}

