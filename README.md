Let Me Cook
Let Me Cook is an iOS recipe application built with SwiftUI. It allows users to discover meals, explore recipe details, search for recipes, and manage their favorite meals in one place.

Features
* Home — Discover meals and browse available recipes.
* Meal Details — View meal information, ingredients, measurements, and cooking instructions.
* Favorites — Save and access favorite meals.
* Profile — Access the profile screen.
* Search — Find meals by name.

Tech Stack
* Swift — Programming language.
* SwiftUI — User interface framework.
* TheMealDB API — Provides meal and recipe data.
* SwiftData — Local persistence for favorite meals.

Project Structure
* Features/
    * Home/ — Home screen and ViewModel
    * MealDetail/ — Meal details and ViewModel
    * Favorites/ — Favorite meals and ViewModel
    * Profile/ — Profile screen
* Models/ — Meal and favorite data models
* Data/ — API service and SwiftData persistence
* Components/ — Reusable UI components
* Assets.xcassets/ — App images and other assets
* LetMeCookApp.swift — App entry point

Running a CI Build
You can download a prebuilt iOS Simulator app from GitHub Actions without building the project locally.

Requirements
* macOS
* Xcode with a compatible iOS Simulator runtime

1. Download the Build
* Open the GitHub Actions page.
* Select a successful workflow run.
* Find the Artifacts section in the workflow summary.
* Download LetMeCook-iOS-Simulator.
* Extract the downloaded ZIP file to access LetMeCook.app.

2. Run in the iOS Simulator
* Open Xcode’s Simulator app.
* Start a compatible iOS Simulator.
* Open Terminal and install the downloaded app:

xcrun simctl install booted /path/to/LetMeCook.app

4. Launch the app:

xcrun simctl launch booted com.alicea.LetMeCook

The app should now launch in the booted simulator.

Notes
* This artifact is built for the iOS Simulator and cannot be installed directly on a physical iPhone or iPad.
* GitHub Actions artifacts are retained for a limited period, so older builds may no longer be available.
* To run the app on a physical iOS device, open the project in Xcode and configure the appropriate device signing settings.

API
This application uses [TheMealDB](https://www.themealdb.com/) to retrieve meal and recipe information.
Acknowledgments
Developed as an iOS learning project. [Belajar Membuat Aplikasi iOS untuk Pemula](https://www.dicoding.com/academies/171)
