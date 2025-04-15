//
//  HomeView.swift
//  StoryApp
//
//  Created by Matias Bzurovski on 15/04/2025.
//

import SwiftUI

/// A view that mimics Instagram Feed View.
/// On the top, it will display an infinite number of stories. When one of them is tapped,
/// the StoryView will be presented.
struct FeedView: View {
	@State private(set) var viewModel: StoryListViewModel
	
	var body: some View {
		VStack {
			stories
			Spacer()
			Text("Here we would show rest of the Instagram feed")
				.foregroundStyle(.white)
				.padding()
			Spacer()
		}
		.multilineTextAlignment(.center)
		.padding(12)
		.frame(maxWidth: .infinity)
		.background(Color.black)
		.sheet(isPresented: $viewModel.showCarousel) {
			StoryCarouselView(viewModel: viewModel, selectedIndex: $viewModel.selectedIndex)
		}
	}
	
	private var stories: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			LazyHStack(spacing: 12) {
				ForEach(viewModel.stories) { story in
					Button {
						viewModel.onStoryTapped(story: story)
					} label: {
						StoryBubbleView(story: story)
					}
					.padding(.vertical, 4)
					.onAppear {
						viewModel.onStoryAppear(story: story)
					}
				}
				
				if viewModel.isDownloadingMore {
					ProgressView()
						.tint(.white)
				}
					
			}
			.frame(maxHeight: 50)
			.padding(.horizontal, 20)
		}
	}
	
	
}

extension FeedView {
	struct StoryBubbleView: View {
		let story: Story
		
		var body: some View {
			image
				.padding(4)
				.overlay(Circle().stroke(
					LinearGradient(
						colors: story.gradientColors,
						startPoint: .topLeading,
						endPoint: .bottomTrailing
					),
					lineWidth: 3
				))
		}
		
		private var image: some View {
			AsyncImage(url: story.creatorImageUrl) { phase in
				switch phase {
				case .empty, .failure:
					Circle()
						.fill(Color.white.opacity(0.1))
						.frame(width: 40, height: 40)
					
				case let .success(image):
					image
						.resizable()
						.aspectRatio(1, contentMode: .fit)
						.frame(width: 40, height: 40)
						.clipShape(Circle())
					
				@unknown default:
					EmptyView()
				}
			}
		}
		
	
	}
}

private extension Story {
	var gradientColors: [Color] {
		if isSeen {
			[.gray]
		} else {
			[.pink, .purple]
		}
	}
}

#Preview {
	FeedView(viewModel: .init())
}
