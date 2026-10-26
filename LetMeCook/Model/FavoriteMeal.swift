//
//  FavoriteMeal.swift
//  LetMeCook
//
//  Created by ais on 26/10/26.
//


import SwiftData
import Foundation

@Model
final class FavoriteMeal {
    @Attribute(.unique) var idMeal: String
    var strMeal: String
    var strMealThumb: String?
    var strCategory: String?
    var strArea: String?
    var strInstructions: String?
    var strTags: String?
    var strYoutube: String?

    @Relationship(
        deleteRule: .cascade,
        inverse: \FavoriteIngredient.meal
    )
    var ingredients: [FavoriteIngredient] = []

    var id: String { idMeal }

    var imageURL: URL? {
        guard let strMealThumb, !strMealThumb.isEmpty else {
            return nil
        }

        return URL(string: strMealThumb)
    }

    var youtubeURL: URL? {
        guard let strYoutube,
              let url = URL(string: strYoutube),
              url.scheme == "https",
              let host = url.host,
              ["www.youtube.com", "youtube.com", "youtu.be"].contains(host) else {
            return nil
        }

        return url
    }

    init(
        idMeal: String,
        strMeal: String,
        strMealThumb: String? = nil,
        strCategory: String? = nil,
        strArea: String? = nil,
        strInstructions: String? = nil,
        strTags: String? = nil,
        strYoutube: String? = nil,
        ingredients: [FavoriteIngredient] = []
    ) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
        self.strCategory = strCategory
        self.strArea = strArea
        self.strInstructions = strInstructions
        self.strTags = strTags
        self.strYoutube = strYoutube
        self.ingredients = ingredients

        for ingredient in ingredients {
            ingredient.meal = self
        }
    }

    convenience init(from meal: Meal) {
        let favoriteIngredients = meal.ingredients.map {
            FavoriteIngredient(
                id: $0.id,
                name: $0.name,
                measure: $0.measure
            )
        }

        self.init(
            idMeal: meal.idMeal,
            strMeal: meal.strMeal,
            strMealThumb: meal.strMealThumb,
            strCategory: meal.strCategory,
            strArea: meal.strArea,
            strInstructions: meal.strInstructions,
            strTags: meal.strTags,
            strYoutube: meal.strYoutube,
            ingredients: favoriteIngredients
        )
    }
}

@Model
final class FavoriteIngredient {
    var id: Int
    var name: String
    var measure: String

    var meal: FavoriteMeal?

    init(
        id: Int,
        name: String,
        measure: String
    ) {
        self.id = id
        self.name = name
        self.measure = measure
    }
}
