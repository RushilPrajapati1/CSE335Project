//
//  ContentView.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/24/25.
//

import SwiftUI

struct ContentView: View {
    //test this
    @StateObject private var mapView = MapModel()
        @StateObject private var searchView = SearchModel()
    var body: some View {
        
        VStack {
            HomeView()
            .environmentObject(mapView)
            .environmentObject(searchView)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(MapModel())
        .environmentObject(SearchModel())
    
}
