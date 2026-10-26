//
//  FavoritesView.swift
//  LetMeCook
//
//  Created by ais on 23/10/26.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: FavoritesViewModel
    @Query(sort: \Meal.strMeal)
    private var favoriteMeals: [Meal]
    
    init(
        viewModel: FavoritesViewModel = FavoritesViewModel(),
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    fileprivate func headerView() -> some View {
        return Group {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Fav Me Cook")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("nom nom or never!")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            HStack(alignment: .bottom) {
                Text("fav nom")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                Spacer()
                Text(viewModel.totalMeals)
                    .font(.system(size: 16))
                    .foregroundStyle(Color.secondary)
                
            }
            .padding(.vertical, 8)
        }
        .padding(.horizontal, 20)
    }
    
    fileprivate func listView() -> some View {
        List {
            ForEach(favoriteMeals) { meal in
                NavigationLink {
                    MealDetailView(mealID: meal.id)
                } label: {
                    MealCardView(meal: meal)
                }
                .listRowBackground(Color("ItemColor"))
            }
        }
        .scrollContentBackground(.hidden)
        .contentMargins(.top, 8)
    }
    
    private func emptyStateView() -> some View {
        VStack(spacing: 16) {
            Image(systemName: "heart")
                .font(.system(size: 32))
                .foregroundStyle(.brown)
                .padding(20)
                .background(
                    Color("BackgroundColor"),
                    in: Circle()
                )
            
            Text("No noms yet")
                .font(.title3)
                .fontWeight(.semibold)
            
            Text("Your nom meals will appear here once you save them")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("ItemColor"))
        }
        .padding()
    }
    
    @ViewBuilder
    private func contentView() -> some View {
        if viewModel.displayedFavMeals.isEmpty {
            emptyStateView()
        } else {
            listView()
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ZStack {
                    Color("BackgroundColor").ignoresSafeArea()
                    VStack(alignment: .leading, spacing: 4) {
                        headerView()
                        contentView()
                    }
                    .padding(.horizontal, 4)
                    .frame(maxHeight: .infinity, alignment: .top)
                }
            }
        }
        .task {
            await viewModel.fetchFavoriteMeals(in: modelContext)
        }
    }
}

#Preview {
    FavoritesView()
}
