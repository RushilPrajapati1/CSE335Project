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

    var body: some View {
        LoginView()
            .environmentObject(mapView)
            .environmentObject(searchView)
    }
}

#Preview {
    ContentView()
}

