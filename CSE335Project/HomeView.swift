//
//  HomeView.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/26/25.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var mapView: MapModel
    @EnvironmentObject var searchView: SearchModel
    
    var body: some View {
        VStack {
            Text("This is the Home View")
            NavigationLink(destination: SearchHistoryView()) {
                Text("Search")
            }
        
        }
    }
}
