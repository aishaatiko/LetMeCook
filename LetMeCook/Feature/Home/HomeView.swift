//
//  HomeView.swift
//  LetMeCook
//
//  Created by ais on 23/10/26.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @StateObject private var viewModel: HomeViewModel
    
    init(
        viewModel: HomeViewModel = HomeViewModel(),
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private func stateView(
        image: String,
        title: String,
        description: String,
        buttonTitle: String? = nil,
        action: (() -> Void)? = nil
    ) -> some View {
        VStack(spacing: 16) {
            Image(systemName: image)
                .font(.system(size: 32))
                .foregroundStyle(.brown)
                .padding(20)
                .background(
                    Color("BackgroundColor"),
                    in: Circle()
                )
            
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            
            if let buttonTitle, let action {
                Button(action: action) {
                    Text(buttonTitle)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 14))
                .tint(Color("ButtonColor"))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("ItemColor"))
        }
        .padding()
    }
    
    fileprivate func headerView() -> some View {
        return HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Let Me Cook")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("nom nom or never!")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            NavigationLink {
                ProfileView()
            } label: {
                VStack(spacing: 4) {
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 28, weight: .medium))
                    Text("profile")
                        .font(.system(size: 16, weight: .medium))
                }
                .foregroundColor(.primary)
            }
        }
        .padding(.horizontal, 24)
    }
    
    fileprivate func searchField() -> some View {
        return HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            
            TextField("Search nom nom...", text: $searchText)
                .autocorrectionDisabled()
            
            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
                .padding()
            }
        }
        .padding(12)
        .background(Color("ItemColor"))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
    
    fileprivate func listView() -> some View {
        List {
            ForEach(viewModel.displayedMeals) { meal in
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
    
    @ViewBuilder
    private func contentView() -> some View {
        switch viewModel.viewState {
        case .loading:
            stateView(
                image: "hourglass",
                title: "Loading Meals",
                description: "Please wait while we fetch your meals."
            )
            
        case .error:
            stateView(
                image: "wifi.slash",
                title: "Couldn't load the noms",
                description: "Unable to load meals. Please try again.",
                buttonTitle: "Try again"
            ) {
                Task {
                    await viewModel.fetchMeals()
                }
            }
            
        case .empty:
            stateView(
                image: "magnifyingglass",
                title: "No meals found",
                description: "Try searching with a different keyword.",
                buttonTitle: "Clear search"
            ) {
                Task {
                    searchText = ""
                }
            }
            
        case .success:
            listView()
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { _ in
                ZStack {
                    Color("BackgroundColor").ignoresSafeArea()
                    VStack(alignment: .leading, spacing: 4) {
                        headerView()
                        searchField()
                        contentView()
                    }
                    .padding(.horizontal, 4)
                    .frame(maxHeight: .infinity, alignment: .top)
                }
            }
        }
        .onChange(of: searchText) {
            Task {
                await viewModel.handleSearch(query: searchText)
            }
        }
        .task {
            await viewModel.fetchMeals()
            searchText = ""
        }
        .onDisappear() {
            searchText = ""
        }
    }
}

#Preview {
    HomeView()
}
