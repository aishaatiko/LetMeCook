//
//  MealApiService.swift
//  LetMeCook
//
//  Created by ais on 23/10/26.
//
import Foundation

struct MealAPIService {
    private let baseURL = "https://www.themealdb.com/api/json/v1/1/"
    
    func fetchMeals() async throws -> MealsResponse {
        let urlString = "\(baseURL)search.php?f=a"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let request = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(MealsResponse.self, from: data)
    }
    
    func searchMeals(query: String) async throws -> MealsResponse {
        let urlString = "\(baseURL)search.php?s=\(query)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let request = URLRequest(url: url)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return try decoder.decode(MealsResponse.self, from: data)
    }
    
    func fetchDetailMeal(query: String) async throws -> MealsResponse {
        let urlString = "\(baseURL)lookup.php?i=\(query)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let request = URLRequest(url: url)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return try decoder.decode(MealsResponse.self, from: data)
    }

}
