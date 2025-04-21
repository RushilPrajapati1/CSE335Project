//
//  ContentView.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/24/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var mapView = MapModel()
    @StateObject private var searchView = SearchModel()
    @State private var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            HomeView(isLoggedIn: $isLoggedIn)
                .environmentObject(mapView)
                .environmentObject(searchView)
        } else {
            LoginView(isLoggedIn: $isLoggedIn)
                .environmentObject(mapView)
                .environmentObject(searchView)
        }
    }
}

#Preview {
    ContentView()
}


