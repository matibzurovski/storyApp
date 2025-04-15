# 📸 StoryApp

**StoryApp** is a SwiftUI-based iOS project that replicates the **Instagram Stories experience**. It demonstrates modular architecture, gesture-driven navigation, and state persistence — all built using modern Swift best practices.

---

## ✨ Features

This app includes a simplified version of Instagram Stories with the following views:

- **`FeedView`**
  - Serves as the home screen.
  - Contains a horizontally scrollable, infinite list of stories at the top (mimicking Instagram's story row).
  - Tapping a story opens it in full-screen via `StoryCarouselView`.

- **`StoryCarouselView`**
  - A full-screen, horizontally swipeable view.
  - Mimics Instagram's story viewer with drag gestures for navigating between stories.
  - Supports swipe-down-to-dismiss gesture.
  
- **`StoryView`**
  - Displays individual story content (image).
  - Includes **like/unlike** functionality.

All views are powered by a shared **MVVM-style `StoryListViewModel`**, which manages the story data and user interactions consistently across the app.

---

## 🧠 Architecture

- **MVVM** with a single source of truth (`StoryListViewModel`)
- **SwiftUI-native**, declarative views
- **State persistence** using `UserDefaults` (can be replaced with `CoreData` or a database later)
- **Locally mocked data**, with story generation logic for infinite scrolling

---

## ⚙️ Behavior & Logic

- Users are loaded from a local JSON file on first launch.
- The infinite story list in `FeedView` auto-generates more stories when the user scrolls near the end (`N - 3`).
- The **story seen/unseen and like/unlike states persist** across app launches.
- Unlike Instagram, stories are not grouped by user — each story appears as its own item in the feed, even if posted by the same user.
- When entering the story viewer (`StoryCarouselView`), users can swipe left/right through available stories. Once they reach the end, no new stories are loaded **unless** they exit and return to the feed.

---

## 🚧 Limitations & Areas for Improvement

- ✅ Stories and their state are persisted via `UserDefaults`, which works well for small-scale testing. However, this could be replaced with a more robust solution like **`CoreData`** or **`Realm`**.
- 🚫 When navigating through stories in `StoryCarouselView`, new stories are **not generated on-the-fly** as they are in the feed. The user must exit and scroll the feed to trigger new content generation. This could be improved by integrating infinite scroll into the carousel as well.
- 👥 Story grouping by user (as Instagram does) is not implemented, to keep the scope focused and the UI logic simple.


