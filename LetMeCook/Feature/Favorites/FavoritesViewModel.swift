//
//  FavoritesViewModel.swift
//  LetMeCook
//
//  Created by ais on 23/10/26.
//

import Foundation
import Combine
import SwiftData

final class FavoritesViewModel: ObservableObject {
    @Published private(set) var favMeals: [Meal] = []
    @Published private(set) var emptyMessage: String?
    @Published private(set) var totalMeals: String = ""
    
    private let favoriteManager = FavoriteManager()
    
    var displayedFavMeals: [Meal] {
        return favMeals
    }
    
    func fetchFavoriteMeals(in context: ModelContext) async {
        do {
            self.favMeals = try favoriteManager.getFavoriteMeals(in: context)
            totalMeals = "\(favMeals.count) meals"
        } catch {
            self.favMeals = []
            totalMeals = "0 meals"
        }
    }
    
}
