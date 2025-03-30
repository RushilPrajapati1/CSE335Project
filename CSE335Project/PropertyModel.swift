//
//  PropertyView.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/26/25.
//

import Foundation
import MapKit

struct PropertyModel: Identifiable {
    let id = UUID()
    let title: String
    let price: String
    let location: CLLocationCoordinate2D
}

extension PropertyModel {
    static let sampleData: [PropertyModel] = [
        PropertyModel(title: "Cozy Apartment", price: "$1,200", location: .init(latitude: 37.77, longitude: -122.42)),
        PropertyModel(title: "Luxury Condo", price: "$3,500", location: .init(latitude: 37.78, longitude: -122.43)),
        PropertyModel(title: "Family House", price: "$2,800", location: .init(latitude: 37.76, longitude: -122.41))
    ]
}

