//
//  MealDetailView.swift
//  LetMeCook
//
//  Created by ais on 24/10/26.
//

import SwiftUI
import SwiftData

struct MealDetailView: View {
    @Environment(\.openURL) private var openURL
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: MealDetailViewModel
    
    let mealID: String
    
    init(
        viewModel: MealDetailViewModel = MealDetailViewModel(),
        mealID: String,
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.mealID = mealID
    }
    
    fileprivate func headerView() -> some View {
        let meal = viewModel.meal
        return HStack(alignment: .top, spacing: 4) {
            VStack(alignment: .leading, spacing: 4) {
                Text(meal.strMeal)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.7)
                Text("\(meal.strCategory ?? "") · \(meal.strArea ?? "")")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 8)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        headerView()
                        if let imageURL = viewModel.meal.imageURL {
                            AsyncImage(url: imageURL) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: .infinity)
                                    
                                case .failure:
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.gray.opacity(0.3))
                                        .overlay {
                                            Image(systemName: "frying.pan.fill")
                                                .font(.largeTitle)
                                                .foregroundStyle(.gray)
                                        }
                                    
                                case .empty:
                                    ProgressView()
                                    
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .frame(minHeight: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(alignment: .bottomTrailing) {
                                if let url = viewModel.meal.youtubeURL {
                                    Spacer()
                                    FloatingActionButton(systemName: "play.rectangle.fill") {
                                        openURL(url)
                                    }
                                    .overlay {
                                        Circle()
                                            .strokeBorder(Color.white, lineWidth: 3)
                                    }
                                    .padding()
                                    
                                }
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Ingredients")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                            ForEach(viewModel.meal.ingredients) { ingredient in
                                HStack(alignment: .top) {
                                    Text("•")
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                    Text(ingredient.measure)
                                    Text(ingredient.name)
                                    Spacer()
                                }
                            }
                            
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color("ItemColor"))
                        }
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Instructions")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                            if let instructions = viewModel.meal.strInstructions {
                                let steps = instructions
                                    .components(separatedBy: .newlines)
                                    .map {
                                        $0.replacingOccurrences(
                                            of: #"^\s*step\s*\d+\s*[:.-]?\s*"#,
                                            with: "",
                                            options: .regularExpression.union(.caseInsensitive)
                                        )
                                        .trimmingCharacters(in: .whitespacesAndNewlines)
                                    }
                                    .filter { !$0.isEmpty }
                                
                                ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                                    HStack(alignment: .top, spacing: 8) {
                                        Text("\(index + 1).")
                                            .fontWeight(.semibold)
                                        
                                        Text(step)
                                    }
                                }
                            }                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color("ItemColor"))
                        }
                        
                    }
                    .padding(.horizontal)
                }
                .onAppear {
//                    isFavorite = favoriteManager.isFavorite(movieID: meal.idMeal)
                }
                
            }
        }
        .task {
            await viewModel.fetchDetailMeal(query: mealID, in: modelContext)
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden()
        .overlay(alignment: .bottomLeading) {
            FloatingActionButton(systemName: "chevron.left") {
                dismiss()
            }
            .padding(.horizontal, 24)
        }
        .overlay(alignment: .bottomTrailing) {
            FloatingActionButton(
                systemName: viewModel.isFavorite ? "heart.fill" : "heart"
            ) {
                viewModel.toggleFavorite(in: modelContext)
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    MealDetailView(mealID: "52772")
}
