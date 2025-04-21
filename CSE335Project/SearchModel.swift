//
//  SearchModel.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/27/25.
//

import Foundation
import SwiftUI

class SearchModel: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var results: [Property] = []

    /// Properties the user has tapped on to view details
    @Published var viewed: [Property] = []

    /// Properties the user has sent an inquiry for
    @Published var history: [Property] = []

    func performSearch() {
        results = Property.sampleData.filter { $0.title.contains(searchQuery) }
    }

    func addToViewed(_ property: Property) {
        guard !viewed.contains(where: { $0.id == property.id }) else { return }
        viewed.append(property)
    }

    func addToHistory(_ property: Property) {
        guard !history.contains(where: { $0.id == property.id }) else { return }
        history.append(property)
    }
}
