//
//  LetMeCookTests.swift
//  LetMeCookTests
//
//  Created by ais on 27/10/26.
//

import Foundation
import SwiftData
import Testing
@testable import LetMeCook

struct LetMeCookTests {
    @Test
    func getFavoriteMealByIDReturnsNilWhenMealDoesNotExist() throws {
        let schema = Schema([Meal.self, Ingredient.self])
        let configuration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true
        )
        let container = try ModelContainer(
            for: schema,
            configurations: [configuration]
        )
        let context = ModelContext(container)
        let manager = FavoriteManager()

        let result = try manager.getFavoriteMealByID(
            id: "nonexistent",
            in: context
        )

        #expect(result == nil)
    }
    
    @Test
    func getFavoriteMealByIDReturnsMealWhenItExists() throws {
        let schema = Schema([Meal.self, Ingredient.self])
        let configuration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true
        )
        let container = try ModelContainer(
            for: schema,
            configurations: [configuration]
        )
        let context = ModelContext(container)
        let manager = FavoriteManager()

        let meal = Meal(
            idMeal: "52772",
            strMeal: "Teriyaki Chicken",
            strMealThumb: nil,
            strCategory: "Chicken",
            strArea: "Japanese",
            strInstructions: nil,
            strTags: nil,
            strYoutube: nil,
            ingredients: []
        )

        context.insert(meal)
        try context.save()

        let result = try manager.getFavoriteMealByID(
            id: "52772",
            in: context
        )

        #expect(result?.idMeal == "52772")
        #expect(result?.strMeal == "Teriyaki Chicken")
    }
    
    @Test
    func toggleFavoriteAddsMealWhenItDoesNotExist() throws {
        let schema = Schema([Meal.self, Ingredient.self])
        let configuration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true
        )
        let container = try ModelContainer(
            for: schema,
            configurations: [configuration]
        )
        let context = ModelContext(container)
        let manager = FavoriteManager()

        let meal = Meal(
            idMeal: "52772",
            strMeal: "Teriyaki Chicken",
            strMealThumb: nil,
            strCategory: "Chicken",
            strArea: "Japanese",
            strInstructions: nil,
            strTags: nil,
            strYoutube: nil,
            ingredients: []
        )

        let result = try manager.toggleFavorite(meal, in: context)

        #expect(result == true)

        let savedMeal = try manager.getFavoriteMealByID(
            id: "52772",
            in: context
        )

        #expect(savedMeal != nil)
        #expect(savedMeal?.strMeal == "Teriyaki Chicken")
    }

    @Test
    func toggleFavoriteRemovesMealWhenItAlreadyExists() throws {
        let schema = Schema([Meal.self, Ingredient.self])
        let configuration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true
        )
        let container = try ModelContainer(
            for: schema,
            configurations: [configuration]
        )
        let context = ModelContext(container)
        let manager = FavoriteManager()

        let meal = Meal(
            idMeal: "52772",
            strMeal: "Teriyaki Chicken",
            strMealThumb: nil,
            strCategory: "Chicken",
            strArea: "Japanese",
            strInstructions: nil,
            strTags: nil,
            strYoutube: nil,
            ingredients: []
        )

        context.insert(meal)
        try context.save()

        let result = try manager.toggleFavorite(meal, in: context)

        #expect(result == false)

        let savedMeal = try manager.getFavoriteMealByID(
            id: "52772",
            in: context
        )

        #expect(savedMeal == nil)
    }
    
    @Test
    func getFavoriteMealsReturnsEmptyArrayWhenNoMealsExist() throws {
        let schema = Schema([Meal.self, Ingredient.self])
        let configuration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true
        )
        let container = try ModelContainer(
            for: schema,
            configurations: [configuration]
        )
        let context = ModelContext(container)
        let manager = FavoriteManager()

        let result = try manager.getFavoriteMeals(in: context)

        #expect(result.isEmpty)
    }

    @Test
    func getFavoriteMealsReturnsMealsSortedByName() throws {
        let schema = Schema([Meal.self, Ingredient.self])
        let configuration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true
        )
        let container = try ModelContainer(
            for: schema,
            configurations: [configuration]
        )
        let context = ModelContext(container)
        let manager = FavoriteManager()

        let chicken = Meal(
            idMeal: "52772",
            strMeal: "Teriyaki Chicken",
            strMealThumb: nil,
            strCategory: "Chicken",
            strArea: "Japanese",
            strInstructions: nil,
            strTags: nil,
            strYoutube: nil,
            ingredients: []
        )

        let pasta = Meal(
            idMeal: "52839",
            strMeal: "Arrabiata",
            strMealThumb: nil,
            strCategory: "Vegetarian",
            strArea: "Italian",
            strInstructions: nil,
            strTags: nil,
            strYoutube: nil,
            ingredients: []
        )

        context.insert(chicken)
        context.insert(pasta)
        try context.save()

        let result = try manager.getFavoriteMeals(in: context)

        #expect(result.count == 2)
        #expect(result[0].strMeal == "Arrabiata")
        #expect(result[1].strMeal == "Teriyaki Chicken")
    }
}
