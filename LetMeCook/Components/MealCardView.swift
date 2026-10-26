//
//  MealCardView.swift
//  LetMeCook
//
//  Created by ais on 23/10/26.
//

import SwiftUI

struct MealCardView: View {
    let meal: Meal
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if let imageURL = meal.imageURL {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                    case .failure:
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.gray.opacity(0.3))
                            .overlay {
                                Image(systemName: "frying.pan")
                                    .foregroundStyle(.gray)
                            }
                        
                    case .empty:
                        ProgressView()
                        
                    @unknown default:
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.gray.opacity(0.3))
                    }
                }
                .frame(width: 70, height: 70)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.gray.opacity(0.3))
                    .frame(width: 70, height: 70)
                    .overlay {
                        Image(systemName: "frying.pan")
                            .foregroundStyle(.gray)
                    }
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(meal.strMeal)
                    .font(.headline)
                Text("\(meal.strCategory ?? "Unknown") · \(meal.strArea ?? "Unknown")")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

            }
        }
        
    }
}

#Preview {
    MealCardView(
        meal: sampleMeal
    )
}
