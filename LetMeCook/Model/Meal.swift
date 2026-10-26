//
//  Meals.swift
//  LetMeCook
//
//  Created by ais on 23/10/26.
//

//import Foundation
//
//struct Meal: Codable, Identifiable {
//    let idMeal: String
//    let strMeal: String
//    let strMealThumb: String?
//    let strCategory: String?
//    let strArea: String?
//    let strInstructions: String?
//    let strTags: String?
//    let strYoutube: String?
//
//    var ingredients: [Ingredient] = []
//
//    var id: String { idMeal }
//
//    var imageURL: URL? {
//        guard let strMealThumb,
//              !strMealThumb.isEmpty else {
//            return nil
//        }
//
//        return URL(string: strMealThumb)
//    }
//    
//    var youtubeURL: URL? {
//        guard let strYoutube,
//              let url = URL(string: strYoutube),
//              url.scheme == "https",
//              let host = url.host,
//              ["www.youtube.com", "youtube.com", "youtu.be"].contains(host) else {
//            return nil
//        }
//
//        return url
//    }
//
//    init(
//        idMeal: String = "",
//        strMeal: String = "",
//        strMealThumb: String? = nil,
//        strCategory: String? = nil,
//        strArea: String? = nil,
//        strInstructions: String? = nil,
//        strTags: String? = nil,
//        strYoutube: String? = nil,
//        ingredients: [Ingredient] = []
//    ) {
//        self.idMeal = idMeal
//        self.strMeal = strMeal
//        self.strMealThumb = strMealThumb
//        self.strCategory = strCategory
//        self.strArea = strArea
//        self.strInstructions = strInstructions
//        self.strTags = strTags
//        self.strYoutube = strYoutube
//        self.ingredients = ingredients
//    }
//
//    private enum CodingKeys: String, CodingKey {
//        case idMeal
//        case strMeal
//        case strMealThumb
//        case strCategory
//        case strArea
//        case strInstructions
//        case strTags
//        case strYoutube
//    }
//
//    private struct DynamicCodingKey: CodingKey {
//        let stringValue: String
//        let intValue: Int?
//
//        init?(stringValue: String) {
//            self.stringValue = stringValue
//            self.intValue = nil
//        }
//
//        init?(intValue: Int) {
//            self.stringValue = String(intValue)
//            self.intValue = intValue
//        }
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        idMeal = try container.decode(String.self, forKey: .idMeal)
//        strMeal = try container.decode(String.self, forKey: .strMeal)
//        strMealThumb = try container.decodeIfPresent(String.self, forKey: .strMealThumb)
//        strCategory = try container.decodeIfPresent(String.self, forKey: .strCategory)
//        strArea = try container.decodeIfPresent(String.self, forKey: .strArea)
//        strInstructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
//        strTags = try container.decodeIfPresent(String.self, forKey: .strTags)
//        strYoutube = try container.decodeIfPresent(String.self, forKey: .strYoutube)
//
//        let ingredientContainer = try decoder.container(keyedBy: DynamicCodingKey.self)
//
//        var decodedIngredients: [Ingredient] = []
//
//        for index in 1...20 {
//            let ingredientKey = DynamicCodingKey(stringValue: "strIngredient\(index)")!
//            let measureKey = DynamicCodingKey(stringValue: "strMeasure\(index)")!
//
//            let name = try ingredientContainer.decodeIfPresent(
//                String.self,
//                forKey: ingredientKey
//            )?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
//
//            let measure = try ingredientContainer.decodeIfPresent(
//                String.self,
//                forKey: measureKey
//            )?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
//
//            guard !name.isEmpty else {
//                continue
//            }
//
//            decodedIngredients.append(
//                Ingredient(
//                    id: index,
//                    name: name,
//                    measure: measure
//                )
//            )
//        }
//
//        ingredients = decodedIngredients
//    }
//}
//
//struct Ingredient: Identifiable {
//    let id: Int
//    let name: String
//    let measure: String
//}

import Foundation
import SwiftData

@Model
final class Meal: Codable, Identifiable {
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
        inverse: \Ingredient.meal
    )
    var ingredients: [Ingredient] = []

    var id: String { idMeal }

    var imageURL: URL? {
        guard let strMealThumb,
              !strMealThumb.isEmpty else {
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
        idMeal: String = "",
        strMeal: String = "",
        strMealThumb: String? = nil,
        strCategory: String? = nil,
        strArea: String? = nil,
        strInstructions: String? = nil,
        strTags: String? = nil,
        strYoutube: String? = nil,
        ingredients: [Ingredient] = []
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

    private enum CodingKeys: String, CodingKey {
        case idMeal
        case strMeal
        case strMealThumb
        case strCategory
        case strArea
        case strInstructions
        case strTags
        case strYoutube
    }

    private struct DynamicCodingKey: CodingKey {
        let stringValue: String
        let intValue: Int?

        init?(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = nil
        }

        init?(intValue: Int) {
            self.stringValue = String(intValue)
            self.intValue = intValue
        }
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strMealThumb = try container.decodeIfPresent(String.self, forKey: .strMealThumb)
        strCategory = try container.decodeIfPresent(String.self, forKey: .strCategory)
        strArea = try container.decodeIfPresent(String.self, forKey: .strArea)
        strInstructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
        strTags = try container.decodeIfPresent(String.self, forKey: .strTags)
        strYoutube = try container.decodeIfPresent(String.self, forKey: .strYoutube)

        let ingredientContainer = try decoder.container(keyedBy: DynamicCodingKey.self)
        var decodedIngredients: [Ingredient] = []

        for index in 1...20 {
            let ingredientKey = DynamicCodingKey(
                stringValue: "strIngredient\(index)"
            )!

            let measureKey = DynamicCodingKey(
                stringValue: "strMeasure\(index)"
            )!

            let name = try ingredientContainer.decodeIfPresent(
                String.self,
                forKey: ingredientKey
            )?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

            let measure = try ingredientContainer.decodeIfPresent(
                String.self,
                forKey: measureKey
            )?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

            guard !name.isEmpty else {
                continue
            }

            decodedIngredients.append(
                Ingredient(
                    id: index,
                    name: name,
                    measure: measure
                )
            )
        }

        ingredients = decodedIngredients

        for ingredient in ingredients {
            ingredient.meal = self
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(idMeal, forKey: .idMeal)
        try container.encode(strMeal, forKey: .strMeal)
        try container.encodeIfPresent(strMealThumb, forKey: .strMealThumb)
        try container.encodeIfPresent(strCategory, forKey: .strCategory)
        try container.encodeIfPresent(strArea, forKey: .strArea)
        try container.encodeIfPresent(strInstructions, forKey: .strInstructions)
        try container.encodeIfPresent(strTags, forKey: .strTags)
        try container.encodeIfPresent(strYoutube, forKey: .strYoutube)
    }
}

@Model
final class Ingredient {
    var id: Int
    var name: String
    var measure: String

    var meal: Meal?

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


let sampleMeal = Meal(
    idMeal: "53483",
    strMeal: "Acaraje black-eyed pea fritters with shrimp filling",
    strMealThumb: "https://www.themealdb.com/images/media/meals/dxs5t71782678369.jpg",
    strCategory: "Seafood",
    strArea: "Brazil",
    strInstructions: """
    Preheat oven to 350° F. Spray a 9x13-inch baking pan with non-stick spray.
    Combine soy sauce, ½ cup water, brown sugar, ginger and garlic in a small saucepan and cover. Bring to a boil over medium heat. Remove lid and cook for one minute once boiling.
    Meanwhile, stir together the corn starch and 2 tablespoons of water in a separate dish until smooth. Once sauce is boiling, add mixture to the saucepan and stir to combine. Cook until the sauce starts to thicken then remove from heat.
    Place the chicken breasts in the prepared pan. Pour one cup of the sauce over top of chicken. Place chicken in oven and bake 35 minutes or until cooked through. Remove from oven and shred chicken in the dish using two forks.
    *Meanwhile, steam or cook the vegetables according to package directions.
    Add the cooked vegetables and rice to the casserole dish with the chicken. Add most of the remaining sauce, reserving a bit to drizzle over the top when serving. Gently toss everything together in the casserole dish until combined. Return to oven and cook 15 minutes. Remove from oven and let stand 5 minutes before serving. Drizzle each serving with remaining sauce. Enjoy!
    """,
    strTags: "Meat,Casserole",
    strYoutube: "https://www.youtube.com/watch?v=4aZr5hZXP_s",
    ingredients: [
        Ingredient(id: 1, name: "Black Eyed Peas", measure: "800g"),
        Ingredient(id: 2, name: "Garlic", measure: "1 clove"),
        Ingredient(id: 3, name: "Green Chilli", measure: "1")
    ],
)
