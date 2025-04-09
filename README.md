# ⚡ Rentronix - Electronics Rental App

**Rentronix** is a cross-platform electronics rental application built using **Flutter** for both **Web and Android**. It allows users to browse, rent, and manage electronic devices with a seamless user experience. The app features a dark-themed **Black + Purple** UI and is fully integrated with **Firebase** for backend services including authentication and real-time data handling.

---

## 🚀 Features

- 🔐 **Authentication**
  - Sign Up / Log In with Email & Password
  - Google Sign-In via Firebase Auth

- 🖼️ **Splash Screen**
  - Beautiful animated splash screen on launch

- 🏠 **Home Screen**
  - Displays a list of available electronic items
  - Clickable cards that show detailed features and specifications

- 📄 **Product Detail Page**
  - View item details, specs, images
  - "Rent Now" button leading to payment and booking flow

- 💳 **Payment & Booking**
  - Simulated payment and confirmation of rental booking
  - Displays booking status

- 💬 **Chat Screen**
  - In-app messaging interface

- 📜 **Rental History**
  - Track your previous rentals and statuses

- ✍️ **Feedback Form**
  - Submit your feedback for service improvement

- 👤 **Profile Section**
  - View and update profile information

---

## 🛠️ Tech Stack

- **Flutter** (Web & Android)
- **Firebase**
  - Authentication (Email/Password, Google)
  - Firestore / Realtime Database
  
- **Dart**

---


## 📦 Setup Instructions

### Prerequisites

- Flutter SDK installed
- Firebase project set up
- Android Studio / VS Code
- Internet connection (for Firebase & Google Sign-in)
- Android 11+ version

### Install Dependency 
- flutter pub get

### Connect Firebase
- Download google-services.json for Android and place it in android/app/
- Download firebase_options.dart (if using FlutterFire CLI) and place it in lib/
- Enable Authentication in Firebase Console

### Run the app
- flutter run -d chrome     # For Web
- flutter run -d emulator   # For Android


