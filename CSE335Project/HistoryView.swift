//
//  HistoryView.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/26/25.
//

import Foundation
import SwiftUI
struct SearchHistoryView: View {
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
            
            List(history, id: \.self) { entry in
                Text(entry)
            }
        }
    }
}

#Preview {
    SearchHistoryView()
        .environmentObject(MapModel())
        .environmentObject(SearchModel())
    
}
