//
//  SearchView.swift
//  KlarnaTest
//
//  Created by Taranjeet Kaur on 27/07/23.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var locManager: LocationManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
            VStack {
             
                List(locManager.searchResults,id: \.self) {res in
                    VStack(alignment: .leading, spacing: 0) {
                        Text("\(res.title), \(res.subtitle)")
                    }
                    .onTapGesture {
                        locManager.name = res.title
                        locManager.reverseUpdate()
                        dismiss()
                    }
                }
            }
            .searchable(text: $locManager.search)
            .navigationTitle("Places")
      
    }
}
