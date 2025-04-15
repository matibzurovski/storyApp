//
//  StoryApp.swift
//  StoryApp
//
//  Created by Matias Bzurovski on 15/04/2025.
//

import SwiftUI

@main
struct StoryApp: App {
	var body: some Scene {
        WindowGroup {
			FeedView(viewModel: .init())
				.environment(\.colorScheme, .dark)
        }
    }
}
