//
//  Story.swift
//  StoryApp
//
//  Created by Matias Bzurovski on 15/04/2025.
//

import Foundation

struct Story: Sendable, Codable, Hashable, Identifiable {
	let id: UUID
	let creator: User
	let imageUrl: URL
	var isSeen: Bool
	var isLiked: Bool
}

extension Story {
	/// Creates a story with random content for the given creator.
	static func buildRandom(creator: User) -> Self {
		let randomNumber = Int.random(in: 1...1000)
		return .init(
			id: UUID(),
			creator: creator,
			imageUrl: URL(string: "https://picsum.photos/seed/\(randomNumber)/390/844")!,
			isSeen: false,
			isLiked: false
		)
	}
	
	var creatorImageUrl: URL? {
		guard let urlString = creator.profilePictureUrl else { return nil }
		return URL(string: urlString)
	}
}

