//
//  StoryListView.swift
//  StoryApp
//
//  Created by Matias Bzurovski on 15/04/2025.
//

import SwiftUI

struct StoryListView: View {
	@State private(set) var viewModel: StoryListViewModel
	
	var body: some View {
		VStack {
			carousel
			Spacer()
			Text("Here we would show rest of the content unrelated to stories")
				.foregroundStyle(.white)
				.padding()
			Spacer()
		}
		.multilineTextAlignment(.center)
		.padding(12)
		.frame(maxWidth: .infinity)
		.background(Color.black)
	}
	
	private var carousel: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack(spacing: 12) {
				ForEach(viewModel.stories) { story in
					Button {
						
					} label: {
						StoryBubbleView(story: story)
					}
					.padding(.vertical, 4)
				}
			}
			.padding(.horizontal, 20)
		}
	}
}

extension StoryListView {
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
			AsyncImage(url: story.bubbleImageUrl) { phase in
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
	var bubbleImageUrl: URL? {
		guard let urlString = creator.profilePictureUrl else { return nil }
		return URL(string: urlString)
	}
	
	var gradientColors: [Color] {
		if isSeen {
			[.gray]
		} else {
			[.pink, .purple]
		}
	}
}

#Preview {
	StoryListView(viewModel: .init())
}
