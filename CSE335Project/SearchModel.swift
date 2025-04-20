//
//  SearchModel.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/27/25.
//

import Foundation
import SwiftUI

class SearchModel: ObservableObject{
    @Published var searchQuery: String = ""
       @Published var results: [Property] = []
    @Published var history: [Property] = []

       
       func performSearch() {
           results = Property.sampleData.filter { $0.title.contains(searchQuery) }
       }
    
    func addToHistory(_ property: Property) {
        
        if !history.contains(where: { $0.id == property.id }) {
                    history.append(property)
                }
        }
}
