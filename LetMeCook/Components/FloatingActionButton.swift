//
//  FloatingActionButton.swift
//  LetMeCook
//
//  Created by ais on 26/10/26.
//

import SwiftUI

struct FloatingActionButton: View {
    let systemName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.title2.weight(.semibold))
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background(Color.brown, in: Circle())
                .shadow(radius: 4)
        }
    }
}
