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
       @Published var results: [PropertyModel] = []
       
       func performSearch() {
           results = PropertyModel.sampleData.filter { $0.title.contains(searchQuery) }
       }
}
