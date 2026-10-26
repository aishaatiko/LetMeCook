//
//  FavoriteManager.swift
//  LetMeCook
//
//  Created by ais on 26/10/26.
//

import SwiftData
import Foundation

final class FavoriteManager {
    func toggleFavorite(_ meal: Meal, in context: ModelContext) throws -> Bool {
        let mealID = meal.idMeal

        let descriptor = FetchDescriptor<Meal>(
            predicate: #Predicate { $0.idMeal == mealID }
        )

        if let savedMeal = try context.fetch(descriptor).first {
            context.delete(savedMeal)
            try context.save()
            return false
        } else {
            let favorite = Meal(
                idMeal: meal.idMeal,
                strMeal: meal.strMeal,
                strMealThumb: meal.strMealThumb,
                strCategory: meal.strCategory,
                strArea: meal.strArea,
                strInstructions: meal.strInstructions,
                strTags: meal.strTags,
                strYoutube: meal.strYoutube,
                ingredients: meal.ingredients.map {
                    Ingredient(
                        id: $0.id,
                        name: $0.name,
                        measure: $0.measure
                    )
                }
            )

            context.insert(favorite)
            try context.save()
            return true
        }
    }
    
    func getFavoriteMeals(in context: ModelContext) throws -> [Meal] {
        let descriptor = FetchDescriptor<Meal>(
            sortBy: [SortDescriptor(\.strMeal)]
        )
        return try context.fetch(descriptor)
    }
    
    func getFavoriteMealByID(id: String, in context: ModelContext) throws -> Meal? {
        let descriptor = FetchDescriptor<Meal>(
            predicate: #Predicate { $0.idMeal == id }
        )

        return try context.fetch(descriptor).first
    }
}
