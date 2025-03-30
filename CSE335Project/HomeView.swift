//
//  HomeView.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/26/25.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var mapView: MapModel
    @EnvironmentObject var searchView: SearchModel
    
    var body: some View {
        @EnvironmentObject var mapView: MapModel
        @EnvironmentObject var searchView: SearchModel
        
        
        NavigationStack{
            Text("This is the Home View")
                .font(.headline)
                .padding()
            
            NavigationLink(destination: SearchFilter()) {
                    Text("Search")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

            
            NavigationLink(destination: SearchHistoryView()) {
                   Text("Search History")
                       .frame(maxWidth: .infinity)
                       .padding()
                       .background(Color.blue)
                       .foregroundColor(.white)
                       .cornerRadius(10)
                       .padding(.horizontal)
               }
            
            NavigationLink(destination: BrowseView()) {
                   Text("Search History")
                       .frame(maxWidth: .infinity)
                       .padding()
                       .background(Color.blue)
                       .foregroundColor(.white)
                       .cornerRadius(10)
                       .padding(.horizontal)
               }
            
          
        }
        .padding()
    }
}

