//
//  ProfileView.swift
//  LetMeCook
//
//  Created by ais on 23/10/26.
//

import SwiftUI

struct ProfileView: View {
    func InfoView(_ text: String, img imageName: String, url: String) -> some View {
        Link(destination: URL(string: url)!) {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white)
                .frame(height: 50.0)
                .overlay {
                    HStack {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25.0)

                        Text(text)
                            .foregroundColor(.brown)
                    }
                }
        }
    }
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            VStack {
                Image("aisha")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150.0, height: 150.0)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(Color.primary, lineWidth: 3)
                    }
                    .padding(.top, 32)
                Text("Aisha Atiko")
                    .font(.system(size: 40))
                    .bold()
                Text("Mobile Developer")
                    .font(.system(size: 25))
                    .foregroundColor(.primary)
                InfoView(
                    "aisya_h@outlook.com",
                    img: "email-logo",
                    url: "mailto:aisya_h@outlook.com",
                )
                HStack {
                    InfoView(
                        "aisyanuratiko",
                        img: "linkedin-logo",
                        url: "https://www.linkedin.com/in/aisyanuratiko/",
                    )
                    InfoView(
                        "aishaatiko",
                        img: "github-logo",
                        url: "https://github.com/aishaatiko",
                    )
                }
                Spacer()
                Link(
                    "App Icon Source",
                    destination: URL(string: "https://pngtree.com/freepng/cartoon-restaurant-cooking-delicious-food-beautiful-female-chef_6939398.html")!
                )
                .font(.footnote)
                .foregroundStyle(.secondary)
            }
            .padding()
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    ProfileView()
}
