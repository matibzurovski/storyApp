//
//  UserManager.swift
//  StoryApp
//
//  Created by Matias Bzurovski on 15/04/2025.
//

import Foundation

/// A manager responsible for reading the Users from the local JSON file.
class UserManager {
	private(set) var users: [User] = []
	
	init() {
		loadUsers()
	}
	
	private func loadUsers() {
		guard let url = Bundle.main.url(forResource: "Users", withExtension: "json") else {
			print("‼️ Users JSON file not found, loading default users")
			return loadDefaultUsers()
		}
		
		do {
			let data = try Data(contentsOf: url)
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			let response = try decoder.decode(UserResponse.self, from: data)
			self.users = response.pages.flatMap { $0.users }
		} catch {
			print("‼️ Failed to load users: \(error). Please check the JSON file")
			loadDefaultUsers()
		}
	}
	
	private func loadDefaultUsers() {
		// We are gonna statically load some users so that we can use app.
		users = [
			User(id: 1, name: "Neo", profilePictureUrl: "https://i.pravatar.cc/300?u=1"),
			User(id: 2, name: "Trinity", profilePictureUrl: "https://i.pravatar.cc/300?u=2")
		]
	}
	
	func getRandomUser() -> User {
		let randomIndex = Int.random(in: 0..<users.count)
		return users[randomIndex]
	}
}
