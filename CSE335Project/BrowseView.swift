//
//  SearchModel.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/27/25.
//

import Foundation
import SwiftUI
import MapKit
//this is the model that is brows.view
struct BrowseView: View{

    @EnvironmentObject var mapView: MapModel

    @State private var region = MKCoordinateRegion( //this is the region of the zipcode aroound 85281
        center: CLLocationCoordinate2D(latitude: 33.4255, longitude: -111.9400),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        VStack{
            Map(coordinateRegion: $region, annotationItems: mapView.properties) { property in
                MapMarker(coordinate: property.location, tint: .blue)
                        }
            
            List(mapView.properties){
                property in
                VStack{
                    Text(property.title)
                    Text("Price: $\(String(format: "%.2f", property.price))")
                    Text("Location: \(property.location)")
                }
            }
        }
        .navigationTitle("Current Listing nearby")
    }
    
    
    
}
