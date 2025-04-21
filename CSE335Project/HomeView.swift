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
            VStack(spacing: 20) {
                Text("This is the Home View")
                    .font(.title)
                    .bold()

                NavigationLink(destination: BrowseView()) {
                    Text("Browse by Map")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }

                NavigationLink(destination: SearchFilterStepOne()) {
                    Text("Search")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }

                NavigationLink(destination: SearchHistoryView()) {
                    Text("Viewed History")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }

                NavigationLink(destination: InquiryHistoryView()) {
                    Text("Inquiry History")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }

                Button(action: {
                    isLoggedIn = false
                }) {
                    Text("Log Out")
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
    }
}

#Preview {
    HomeView(isLoggedIn: .constant(true))
        .environmentObject(MapModel())
        .environmentObject(SearchModel())
}
