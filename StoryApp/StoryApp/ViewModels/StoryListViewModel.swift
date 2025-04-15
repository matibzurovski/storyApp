//
//  StoryListViewModel.swift
//  StoryApp
//
//  Created by Matias Bzurovski on 15/04/2025.
//

import Foundation

@Observable
class StoryListViewModel: @unchecked Sendable {
	var stories: [Story] = []
	let userManager: UserManager = .init()
	
	init() {
		loadPersistedStories()
	}
	
	private func loadPersistedStories() {
		// Load stories downloaded on previous sessions
		
		if stories.isEmpty {
			// First time using the app
			downloadMoreStories()
		}
		
	}
	
	private func downloadMoreStories() {
		let newStories = (0..<Constants.pageSize).map { _ in
			Story.buildRandom(creator: userManager.getRandomUser())
		}
		stories.append(contentsOf: newStories)
	}
}
