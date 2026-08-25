# 🎬 Movie Library App

A feature-rich Flutter application for browsing movies, viewing details, and receiving real-time push notifications. Built using Clean Architecture, SOLID Principles, and GetX for reactive state management.

## 📸 Overview

The Movie Library app fetches real-time movie data from The Movie Database (TMDB) API and integrates Firebase Cloud Messaging (FCM) alongside Flutter Local Notifications to deliver deep-linked push notifications directly to movie detail screens.

## 🚀 Features

* **Now Playing & Popular Movies:** Explore up-to-date movie releases and recommendations powered by TMDB API.
* **Movie Details Screen:** View backdrop images, genres, runtime, ratings, overviews, and similar recommendations.
* **Push Notifications (FCM):**
  * **Foreground Alerts:** Displays custom high-priority heads-up banners using `flutter_local_notifications`.
  * **Background & Terminated State Handling:** Tapping a notification opens the app and directly routes the user to the specific movie details screen.
  * **Topic Subscriptions:** Broadcast alerts via FCM topics (e.g., `all_users`).
* **Reactive UI:** Smooth state updates powered by GetX.

## 🛠️ Tech Stack & Architecture

### **Architecture & Design Patterns**
* **Clean Architecture:** Separated into Data, Domain, and Presentation layers for modularity and testability.
* **SOLID Principles:** Applied throughout data sources, repositories, and use cases.
* **Dependency Injection:** Powered by GetIt as a service locator.

### **Libraries & Packages**
* **Framework:** Flutter & Dart
* **State Management:** GetX
* **Service Locator:** GetIt
* **Networking:** Dio & TMDB API
* **Push Notifications:** Firebase Cloud Messaging
* **Local Notifications:** Flutter Local Notifications
* **UI & Animations:** `animate_do`, `cached_network_image`, `shimmer`, `google_fonts`

## 🔔 Push Notification Setup & Data Payload

> **Note:** The TMDB API does not natively support server push notifications. The notification feature is configured for testing using deep-linking payloads.

To test deep-linking into a movie screen via Firebase Console or Postman, send a notification payload containing a custom `movieId` key:

| Key | Value | Description |
| :--- | :--- | :--- |
| `movieId` | `969681` | TMDB Movie ID to fetch and display on tap |

## 📁 Project Structure

```text
lib/
└── movie_app/
    ├── core/
    │   ├── services/
    │   │   └── service_locator.dart      # GetIt DI Configuration
    │   └── utilizes/
    │       └── constance.dart            # API Constants & Image Helpers
    ├── modules/
    │   └── movies/
    │       ├── data/                     # Models, Data Sources & Repositories
    │       ├── domain/                   # Entities, Repository Interfaces & Use Cases
    │       └── presentation/
    │           ├── controller/           # MovieController & NotificationController
    │           └── screens/              # MovieDetailScreen & UI Components
    └── main.dart
