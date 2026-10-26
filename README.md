Let Me Cook

Let Me Cook is an iOS recipe application built with SwiftUI. It allows users to discover meals, explore recipe details, and manage their favorite recipes in one place.

Features

* Home — Discover meals and browse available recipes.
* Meal Details — View meal information, ingredients, measurements, and cooking instructions.
* Favorites — Save and access favorite meals.
* Profile — Access the profile screen.
* Search — Find meals by name.

Tech Stack

* Swift — Programming language.
* SwiftUI — User interface framework.
* TheMealDB API — Recipe and meal data.
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

Getting Started

1. Clone this repository.
2. Open the Xcode project (.xcodeproj) in Xcode.
3. Select an available iOS Simulator.
4. Build and run the application.

API

This application uses [TheMealDB](https://www.themealdb.com/) to retrieve meal and recipe information.

Author

Developed as an iOS learning project. [Belajar Membuat Aplikasi iOS untuk Pemula](https://www.dicoding.com/academies/171)
