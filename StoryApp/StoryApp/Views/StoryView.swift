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
	@Environment(\.dismiss) var dismiss
	let isActive: Bool
	
	var body: some View {
		VStack(spacing: 8) {
			ZStack(alignment: .top) {
				mainContent
				top
			}
			
			bottom
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
	
	private var mainContent: some View {
		AsyncImage(url: story.imageUrl) { image in
			image.resizable().aspectRatio(contentMode: .fit)
		} placeholder: {
			ProgressView()
				.tint(.white)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
		}
	}
	
	private var top: some View {
		HStack(spacing: 4) {
			AsyncImage(url: story.creatorImageUrl) { phase in
				switch phase {
				case .empty, .failure:
					Circle()
						.fill(Color.white.opacity(0.1))
						.frame(width: 20, height: 20)
					
				case let .success(image):
					image
						.resizable()
						.aspectRatio(1, contentMode: .fit)
						.frame(width: 20, height: 20)
						.clipShape(Circle())
					
				@unknown default:
					EmptyView()
				}
			}
			
			Text(story.creator.name)
				.foregroundStyle(.white)
				.font(.body)
			
			Spacer()
			
			Button {
				dismiss()
			} label: {
				Image(systemName: "xmark")
					.resizable()
					.padding(8)
			}
			.frame(width: 30, height: 30)
		}
		.tint(.white)
		.padding(.top, 24)
		.padding(.horizontal, 24)
	}
	
	private var bottom: some View {
		HStack {
			Spacer()
			Button {
				story.isLiked.toggle()
				viewModel.update(story)
			} label: {
				Image(systemName: story.isLiked ? "heart.fill" : "heart")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.padding(8)
			}
			.frame(width: 44, height: 44)
		}
		.padding(.trailing, 24)
		.foregroundStyle(story.isLiked ? .red : .white)
	}
}

