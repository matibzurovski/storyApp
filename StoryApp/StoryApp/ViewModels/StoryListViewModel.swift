//
//  StoryListViewModel.swift
//  StoryApp
//
//  Created by Matias Bzurovski on 15/04/2025.
//

import Foundation

/// A view model holding the logic for everything related to stories.
/// This includes logic to read and write data from local storage, as well
/// as the logic to simulate a remote download of more stories.
///
/// Given the stories status can be modified from different places (`FeedView`,
/// `StoryCarouselView` & `StoryView`), this view model must be shared across such screens.
@Observable
class StoryListViewModel {
	var stories: [Story] = []
	var isDownloadingMore = false
	var selectedIndex = 0
	var showCarousel = false
	
	let userManager: UserManager = .init()
	
	private let storageKey = "Stories"
	
	init() {
		loadPersistedStories()
		
		if stories.isEmpty {
			// First run of the app
			downloadMoreStories(shouldDelay: false)
		}
	}
	
	func onStoryAppear(story: Story) {
		guard !isDownloadingMore else { return }
		
		guard let index = stories.firstIndex(of: story) else {
			return
		}
		
		guard (stories.count - index) <= Constants.nextPageThreshold else {
			return
		}
		
		downloadMoreStories()
	}
	
	func onStoryTapped(story: Story) {
		if let index = stories.firstIndex(of: story) {
			selectedIndex = index
			showCarousel = true
			
			// Manually set as seen (since `StoryCarouselView` won't set the first one).
			var updated = story
			updated.isSeen = true
			update(updated)
		}
	}
	
	/// Updates the story with the given id on the in-memory list, and also in local storage
	func update(_ story: Story) {
		if let index = stories.firstIndex(where: { $0.id == story.id }) {
			stories[index] = story
			persistStories()
		}
	}
}

// MARK: - Persistence
// Note: Initial version stores the stories on UserDefaults. This should be migrated into a more scalable solution (such as CoreData)
extension StoryListViewModel {
	
	/// Persists the stories to UserDefaults
	private func persistStories() {
		if let data = try? JSONEncoder().encode(stories) {
			UserDefaults.standard.set(data, forKey: storageKey)
		}
	}
	
	/// Reads stories from UserDefaults
	private func loadPersistedStories() {
		if let data = UserDefaults.standard.data(forKey: storageKey),
		   let saved = try? JSONDecoder().decode([Story].self, from: data) {
			self.stories = saved
		}
	}
}

// MARK: - Helpers
private extension StoryListViewModel {
	/// Simulates the dowload of more stories, with a delay of 1.5 seconds if `shouldDelay: true`
	func downloadMoreStories(shouldDelay: Bool = true) {
		isDownloadingMore = true
		DispatchQueue.main.asyncAfter(deadline: .now() + (shouldDelay ? 1.5 : 0)) { [weak self] in
			guard let self else { return }
			let newStories = (0..<Constants.storyPageSize).map { _ in
				Story.buildRandom(creator: self.userManager.getRandomUser())
			}
			self.stories.append(contentsOf: newStories)
			persistStories()
			self.isDownloadingMore = false
		}
		
	}
}
