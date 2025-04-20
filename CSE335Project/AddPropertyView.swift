//
//  AddPropertyView.swift
//  CSE335Project
//
//  Created by Shubham Khalkho on 4/18/25.
//

import SwiftUI
import MapKit

struct AddPropertyView: View {
    @Binding var properties: [Property]
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var price = ""
    @State private var location = ""
    @State private var address = ""
    @State private var errorMessage = ""

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Property Details")) {
                    TextField("Title", text: $title)
                    TextField("Price", text: $price)
                        .keyboardType(.decimalPad)
                    TextField("Location", text: $location)
                    TextField("Street Address", text: $address)
                }
                if !errorMessage.isEmpty {
                    Text(errorMessage).foregroundColor(.red)
                }
                Button("Add Property") {
                    convertAddressAndAddProperty()
                }
                .disabled(!formIsValid)
            }
            .navigationTitle("Add Property")
        }
    }

    private var formIsValid: Bool {
        !title.isEmpty && !price.isEmpty && !location.isEmpty && !address.isEmpty
    }

    private func convertAddressAndAddProperty() {
        let fullAddress = "\(address), \(location)"
        CLGeocoder().geocodeAddressString(fullAddress) { placemarks, error in
            if let coordinate = placemarks?.first?.location?.coordinate {
                addProperty(with: coordinate)
            } else {
                errorMessage = "Couldn't find location. Please check the address."
            }
        }
    }

    private func addProperty(with coordinate: CLLocationCoordinate2D) {
        guard let priceValue = Double(price) else {
            errorMessage = "Invalid price."
            return
        }
        let newProperty = Property(title: title, price: priceValue, location: location, coordinate: coordinate)
        properties.append(newProperty)
        dismiss()
    }
}
