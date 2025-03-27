//
//  SearchModel.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/27/25.
//

import Foundation
import SwiftUI

class SearchModel: ObservableObject{
    @Published var searchHistory: [String] = []
    
    func saveSearchHistory(_ searchText: String){
        if !searchHistory.contains(searchText){
            searchHistory.insert(searchText, at: 0) 
        }
    }
}
