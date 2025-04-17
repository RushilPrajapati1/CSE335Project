//
//  HistoryView.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/26/25.
//

import Foundation
import SwiftUI

struct SearchFilter: View {
    @EnvironmentObject var searchView: SearchModel
    
    @State private var city: String = ""
    @State private var zip: String = ""
    @State private var propertyType: String = "Buy" // Buy or Rent
    @State private var distance: Double = 50
    @State private var price: Double = 500000

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Filter search")
                    .font(.title2)
                    .bold()

                VStack(alignment: .leading, spacing: 8) {
                    Text("Add City")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    TextField("City", text: $city)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }

                Picker("Type", selection: $propertyType) {
                    Text("Buy").tag("Buy")
                    Text("Rent").tag("Rent")
                }
                .pickerStyle(SegmentedPickerStyle())

                VStack(alignment: .leading, spacing: 8) {
                    Text("ZipCode")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    TextField("Zip", text: $zip)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }

                VStack(alignment: .leading) {
                    Text("Distance")
                    Slider(value: $distance, in: 0...100, step: 1)
                    HStack {
                        Text("0").foregroundColor(.gray)
                        Spacer()
                        Text("100").foregroundColor(.gray)
                    }
                }

                VStack(alignment: .leading) {
                    Text("Price")
                    Slider(value: $price, in: 100000...1000000, step: 10000)
                    HStack {
                        Text("$100000").foregroundColor(.gray)
                        Spacer()
                        Text("$1000000").foregroundColor(.gray)
                    }
                }

                Button(action: {
                    // Hook up filter logic
                    print("Apply Filters: \(city), \(zip), \(propertyType), Distance: \(distance), Price: \(price)")
                }) {
                    Text("Search")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .navigationTitle("Search")
    }
}

