//
//  MealDetailViewModel.swift
//  LetMeCook
//
//  Created by ais on 24/10/26.
//

import Foundation
import Combine
import SwiftData

final class MealDetailViewModel: ObservableObject {
    @Published private(set) var meal = Meal.init()
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var isFavorite = false
    
    private let service = MealAPIService()
    private let favoriteManager = FavoriteManager()
    
    func fetchDetailMeal(query: String, in context: ModelContext) async {
        isLoading = true
        errorMessage = nil

        do {
            if let favoriteMeal = try favoriteManager.getFavoriteMealByID(
                id: query,
                in: context
            ) {
                meal = Meal(
                    idMeal: favoriteMeal.idMeal,
                    strMeal: favoriteMeal.strMeal,
                    strMealThumb: favoriteMeal.strMealThumb,
                    strCategory: favoriteMeal.strCategory,
                    strArea: favoriteMeal.strArea,
                    strInstructions: favoriteMeal.strInstructions,
                    strTags: favoriteMeal.strTags,
                    strYoutube: favoriteMeal.strYoutube,
                    ingredients: favoriteMeal.ingredients.map {
                        Ingredient(
                            id: $0.id,
                            name: $0.name,
                            measure: $0.measure
                        )
                    }
                )
                isFavorite = true
            } else {
                let response = try await service.fetchDetailMeal(query: query)

                guard let fetchedMeal = response.meals.first else {
                    errorMessage = "Meal not found."
                    isLoading = false
                    return
                }

                meal = fetchedMeal
                isFavorite = false
            }
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
    
    func toggleFavorite(in context: ModelContext) {
        do {
            isFavorite = try favoriteManager.toggleFavorite(meal, in: context)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
