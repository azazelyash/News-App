# Flutter News App

<!-- ![App Screenshot](/assets/news.gif) -->
<img src="./assets/news.gif" alt="App Screenshot" height="500">

## Overview

This Flutter News App is a mobile application designed to provide users with up-to-date news articles from various sources. The app allows users to sign in or sign up using Firebase authentication and securely stores their login status using Shared Preferences. It fetches news data in real-time from a designated API and displays it in an organized tile format.

## Features

- **Firebase Authentication**: Users can create accounts, sign in, and securely store their login status.

- **Real-time News Feed**: The app fetches news articles from an external API in real-time, ensuring users receive the latest updates.

- **International Phone Number Input**: The `intl_phone_number_input` package is integrated for efficient phone number input validation and formatting.

- **User Preferences**: The app utilizes the `shared_preferences` package to remember user login status, providing a personalized experience.

## Installation

To set up and run this Flutter News App on your local machine, follow these steps:

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/your-repo.git
   ```

2. Create a .env file in the root folder.
3. Add your api key as:

   ```bash
   API_KEY = [YOUR_API_KEY]
   ```

4. Install Packages:

   ```bash
   flutter pub get
   ```

5. Configure Firebase:
   - Create a Firebase project at https://console.firebase.google.com/.
   - Add your Android and iOS apps to the Firebase project.
   - Download and place the Firebase configuration (google-services.json and GoogleService-Info.plist) in the respective platform folders android/app and ios/Runner).
6. Run the app.

## Dependencies

This project utilizes several Flutter packages, including:

1. **intl_phone_number_input**: Provides a user-friendly input for international phone numbers.

2. **flutter_dotenv**: Loads environment variables from a .env file.
3. **shared_preferences**: Stores key-value data for user preferences.
4. **http**: Facilitates HTTP requests and API data retrieval.
5. **rename_app**: Allows easy renaming of the Flutter app.
