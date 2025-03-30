//
//  Property.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/27/25.
//

import Foundation
import SwiftUI
import MapKit

struct Property: Identifiable{
    var id: UUID
    var title: Double
    var price: Double
    var location: String
    var coodinate: CLLocationCoordinate2D
}
