//
//  HistoryView.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/26/25.
//

import Foundation
import SwiftUI
struct SearchFilter: View {
    
    @EnvironmentObject var searchView: SearchModel
    @State private var selectedPrice: String = ""
    @State private var selectedType: String = ""

    
    var body: some View {
        Form{
            Section(header: Text("Filters")){
                TextField("Max Price", text: $selectedPrice)
                TextField("Property Type", text: $selectedType)
            }
            Button("Apply Filters") {
                      }
        }
        .navigationTitle("Search")

    }
}
