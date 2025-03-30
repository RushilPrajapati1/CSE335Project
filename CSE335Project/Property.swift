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
    var id: UUID = UUID()
    var title: String
    var price: Double
    var location: String
    var coordinate: CLLocationCoordinate2D
}

extension Property {
    static let sampleData: [Property] = [
        Property(title: "Cozy Apartment", price: 1200, location: "Tempe",
                       coordinate: CLLocationCoordinate2D(latitude: 33.4240, longitude: -111.9280)),
              
              Property(title: "Luxury Condo", price: 3500, location: "Tempe",
                       coordinate: CLLocationCoordinate2D(latitude: 33.4275, longitude: -111.9405)),
              
              Property(title: "Family House", price: 2800, location: "Tempe",
                       coordinate: CLLocationCoordinate2D(latitude: 33.4220, longitude: -111.9430)),
              
              Property(title: "Downtown Studio", price: 1500, location: "Tempe",
                       coordinate: CLLocationCoordinate2D(latitude: 33.4255, longitude: -111.9390)),
              
              Property(title: "Spacious Duplex", price: 2100, location: "Tempe",
                       coordinate: CLLocationCoordinate2D(latitude: 33.4215, longitude: -111.9350))
          
    ]
}
 
