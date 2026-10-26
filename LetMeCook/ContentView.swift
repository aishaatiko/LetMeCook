//
//  ContentView.swift
//  LetMeCook
//
//  Created by ais on 12/10/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "frying.pan.fill")
                        .labelStyle(IconOnlyLabelStyle())
                }
            FavoritesView()
                .tabItem {
                    Label("Detail", systemImage: "heart")
                        .labelStyle(IconOnlyLabelStyle())
                }
        }
        .tint(.brown)
    }
}

#Preview {
    ContentView()
}
