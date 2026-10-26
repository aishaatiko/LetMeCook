//
//  PersistenceController.swift
//  LetMeCook
//
//  Created by ais on 26/10/26.
//

import SwiftData

enum PersistenceController {
    static let sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Meal.self,
            Ingredient.self
        ])

        let configuration = ModelConfiguration(schema: schema)

        do {
            return try ModelContainer(
                for: schema,
                configurations: [configuration]
            )
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }()
}
