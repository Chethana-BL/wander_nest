# 🏕️ Wander Nest — Camping & Travel App

A Flutter-based cross-platform app to help campers discover, filter, and book unique campsites worldwide. Built with modern Flutter development practices, Riverpod for state management, and responsive UI design.

---
## ⚠️ Note

This app is a demonstration project built to showcase features and coding practices. Currently, campsite data is loaded from a mock API to simulate real-world usage.

---

## ✨ Features

- 🔍 Browse and filter campsites by amenities, price, and host languages  
- 📍 View detailed campsite info with photos, features, and location  
- 🗺️ Explore campsites on an interactive map with clustering support
- 🎨 Supports both light and dark themes for improved user experience  
- 🎯 Responsive design optimized for both mobile and web  
- 🧪 Unit tested with clean Riverpod architecture for maintainability  

---

## 📦 Tech Stack

- **Flutter** — Cross-platform UI development (Web, Android, iOS)  
- **Riverpod** — State management  
- **Dart** — Programming language  
- **flutter_map** + **latlong2** — Interactive maps and geolocation  
- **http** — REST API communication  

---

## 🌐 Live Demo

🔗 Try the app live at: [[wander_nest](https://chethana-bl.github.io/wander_nest/)]

---

## 🏗 Architecture Overview

The app uses a modular, scalable architecture with Riverpod for state management, ensuring a clean separation of concerns and easy testability.

---

## 📁 Project Structure

```
lib/
├── core/
│ ├── themes/
│ └── constants/
├── data/
│ ├── models/
│ └── datasources/remote/
├── application/
│ └── campsite/
│ └── providers/
├── presentation/
│ ├── screens/
│ └── widgets/
├── shared/
│ └── extensions/
└── main.dart
```
---

## ⚙️ Setup Instructions

### Prerequisites

- Flutter SDK (>= 3.0.0)  
- Dart SDK  
- Flutter-compatible IDE (VSCode, Android Studio, etc.)  

### Clone the repository

```bash
git clone https://github.com/Chethana-BL/wander_nest
cd wander_nest
```
**Install Dependencies**

Run the following to install required packages:
```bash
flutter pub get
```
**Running the App**

```bash
flutter run
```
To check code style and run all tests:
```bash
make check
```
---

## 🛤 Upcoming Enhancements 
- Create a custom app icon  
- Implement Favorites / Saved Campsites feature  
- Build a dynamic list of host languages for filtering  
- Add sorting options, e.g., order by price  
- Add widget testing for UI components  
- Implement "Book Now" functionality

---
