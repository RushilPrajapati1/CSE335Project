//
//  HistoryView.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/26/25.
//

import Foundation
import SwiftUI
struct SearchHistoryView: View {
    @EnvironmentObject var searchView: SearchModel

    
    let history: [String] = [
            "Tempe - 2 Bedroom House -$2000",
            "Scottsdale - Condo",
            "Phoenix - 3 Bedroom House",
            "Tempe - Studio under $1500",
            "Mesa - Townhouse with Pool"
        ]
    var body: some View {
        VStack {
            Text("Search History")
                .font(.headline)
            
            if searchView.history.isEmpty {
                            Text("No properties added yet.")
                                .foregroundColor(.gray)
                                .padding()
                        } else {
                            List(searchView.history) { property in
                                VStack(alignment: .leading) {
                                    Text(property.title).bold()
                                    Text("Price: $\(String(format: "%.2f", property.price))")
                                    Text("Location: \(property.location)")
                                }
                                .padding(.vertical, 4)
                            }
            }
        }
    }
}

#Preview {
    SearchHistoryView()
        .environmentObject(MapModel())
        .environmentObject(SearchModel())
    
}
