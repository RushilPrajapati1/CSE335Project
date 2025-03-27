//
//  MapModel.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/27/25.
//

import Foundation
import SwiftUI
class MapModel: ObservableObject {
    @Published var properties: [Property] = []
    init() {
        
    }
}
