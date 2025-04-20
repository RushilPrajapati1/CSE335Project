//
//  AddPropertyView.swift
//  CSE335Project
//
//  Created by Shubham Khalkho on 4/18/25.
//

import SwiftUI
import MapKit
import SwiftUI

struct AddPropertyView: View {
    @Binding var properties: [Property]
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var price = ""
    @State private var location = ""
    @State private var address = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Add Property")
                .font(.largeTitle).bold()

            Text("PROPERTY DETAILS")
                .font(.caption)
                .foregroundColor(.secondary)

            VStack() {
                TextField("Title", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("Price", text: $price)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("Location", text: $location)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("Street Address", text: $address)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Button(action: addProperty) {
                Text("Add Property")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top)

            Spacer()
        }
        .padding()
        .background(Color(.systemGroupedBackground))
    }

    private func addProperty() {
        guard let priceValue = Double(price), !title.isEmpty, !location.isEmpty else { return }

        let newProperty = Property(
            title: title,
            price: priceValue,
            location: location,
            coordinate: CLLocationCoordinate2D(latitude: 33.4242, longitude: -111.9281) // Dummy for now
        )

        properties.append(newProperty)
        dismiss()
    }
}

#Preview {
    AddPropertyView(properties: .constant([]))
}
