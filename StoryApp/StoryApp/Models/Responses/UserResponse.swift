//
//  UserResponse.swift
//  StoryApp
//
//  Created by Matias Bzurovski on 15/04/2025.
//

import Foundation

struct UserResponse: Sendable, Hashable, Codable {
	let pages: [Page]
}

extension UserResponse {
	struct Page: Sendable, Hashable, Codable {
		let users: [User]
	}
}
