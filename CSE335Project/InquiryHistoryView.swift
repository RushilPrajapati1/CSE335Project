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
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 10) {
                Image(systemName: "tray.full.fill")
                    .font(.title2)
                    .foregroundColor(.black)
                Text("Inquiry History")
                    .font(.title2)
                    .bold()
            }
            .padding(.top)
            .transition(.opacity.combined(with: .move(edge: .top)))

            if searchView.history.isEmpty {
                Spacer()
                VStack(spacing: 12) {
                    Image(systemName: "tray")
                        .resizable()
                        .frame(width: 60, height: 50)
                        .foregroundColor(.gray)
                    Text("No inquiries sent yet.")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity)
            } else {
                List(searchView.history.indices, id: \.self) { index in
                    let property = searchView.history[index]
                    NavigationLink(destination: InquiryDetailView(property: property)) {
                        HStack(spacing: 12) {
                            Image(systemName: "doc.text.fill")
                                .font(.title3)
                                .foregroundColor(.orange)
                            VStack(alignment: .leading) {
                                Text(property.title).bold()
                                Text(String(format: "$%.2f", property.price))
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text(property.location)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 6)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                        .animation(.easeOut.delay(Double(index) * 0.04), value: searchView.history.count)
                    }
                }
                .listStyle(.plain)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Inquiry History")
        .background(Color(.systemGroupedBackground))
    }
}
