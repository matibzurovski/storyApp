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
	let isSeen: Bool
	let status: Status?
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
			status: nil
		)
	}
}

extension Story {
	enum Status: String, Sendable, Codable, Hashable {
		case liked
		case disliked
	}
}
