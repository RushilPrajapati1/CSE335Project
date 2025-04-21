//
//  InquiryHistoryView.swift
//  CSE335Project
//
//  Created by Shubham Khalkho on 4/20/25.
//

import SwiftUI

struct InquiryHistoryView: View {
    @EnvironmentObject var searchView: SearchModel

    var body: some View {
        VStack {
            Text("Inquiries Sent")
                .font(.headline)

            if searchView.history.isEmpty {
                Text("No inquiries sent yet.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(searchView.history) { property in
                    NavigationLink(destination: InquiryDetailView(property: property)) {
                        VStack(alignment: .leading) {
                            Text(property.title).bold()
                            Text(String(format: "Price: $%.2f", property.price))
                            Text("Location: \(property.location)")
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("Inquiry History")
    }
}
