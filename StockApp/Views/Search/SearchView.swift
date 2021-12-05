//
//  SearchView.swift
//  StockApp
//
//  Created by Kim Nordin on 2021-12-05.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    @Binding var searching: Bool
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search ..", text: $searchText) { editing in
                    if editing {
                        withAnimation {
                            searching = true
                        }
                    }
                } onCommit: {
                    withAnimation {
                        searching = false
                    }
                }
            }
            .foregroundColor(.gray)
            .padding(.leading, 13)
        }
        .frame(height: 35)
        .cornerRadius(13)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchText: .constant("Shirt"), searching: .constant(true))
    }
}
