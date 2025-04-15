//
//  User.swift
//  StoryApp
//
//  Created by Matias Bzurovski on 15/04/2025.
//

struct User: Sendable, Codable, Hashable {
	let id: Int
	let name: String
	let profilePictureUrl: String?
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case profilePictureUrl = "profile_picture_url"
	}
}

