//
//  HomeViewModel.swift
//  LetMeCook
//
//  Created by ais on 23/10/26.
//

import Foundation
import Combine

enum ViewState {
    case loading
    case error
    case empty
    case success
}

final class HomeViewModel: ObservableObject {
    @Published private(set) var meals: [Meal] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let service = MealAPIService()

    var displayedMeals: [Meal] {
        return meals
    }
    
    var viewState: ViewState {
        if isLoading {
            return .loading
        } else if errorMessage != nil {
            return .error
        } else if meals.isEmpty {
            return .empty
        } else {
            return .success
        }
    }
    
    init(meals: [Meal] = []) {
        self.meals = meals
    }
    
    func fetchMeals() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await service.fetchMeals()
            meals = response.meals
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func handleSearch(query: String) async {
        await searchMeals(query: query)
    }
        
    func searchMeals(query: String) async {
        guard !query.isEmpty else {
            await fetchMeals()
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await service.searchMeals(query: query)
            meals = response.meals
        } catch {
            print(error)
        }
        
        isLoading = false
    }

}
