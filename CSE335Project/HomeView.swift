//
//  HomeView.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/26/25.
//

import SwiftUI

struct HomeView: View {
    @Binding var isLoggedIn: Bool

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Image(systemName: "house.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.black)

                    Text("")
                        .font(.title)
                        .bold()
                }
                .padding(.top, 40)

                VStack(spacing: 16) {
                    NavigationLink(destination: BrowseView()) {
                        Label("Browse by Map", systemImage: "map.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }

                    NavigationLink(destination: SearchFilterStepOne()) {
                        Label("Search", systemImage: "magnifyingglass")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }

                    NavigationLink(destination: SearchHistoryView()) {
                        Label("Viewed History", systemImage: "clock")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }

                    NavigationLink(destination: InquiryHistoryView()) {
                        Label("Inquiry History", systemImage: "tray.full")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }

                Spacer()

                Button(action: {
                    isLoggedIn = false
                }) {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.left")
                        Text("Log Out")
                    }
                    .foregroundColor(.red)
                }
            }
            .padding()
            .background(Color(.systemGroupedBackground))
        }
    }
}

#Preview {
    HomeView(isLoggedIn: .constant(true))
        .environmentObject(MapModel())
        .environmentObject(SearchModel())
}

