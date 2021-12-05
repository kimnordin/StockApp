//
//  ProductListView.swift
//  StockApp
//
//  Created by Kim Nordin on 2021-12-04.
//

import SwiftUI

struct ProductListView: View {
    @EnvironmentObject var products: ProductList
    @State private var presentNew = false
    @State private var edit = false
    @State var searching = false
    @State private var searchText = ""
    
    var searchResults: [Product] {
        if searchText.isEmpty {
            return products.list
        } else {
            let matching = products.list.filter {
                $0.name.range(of: searchText, options: .caseInsensitive) != nil
            }
            return matching
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchView(searchText: $searchText, searching: $searching)
                List {
                    ForEach(0..<searchResults.count, id: \.self) { product in
                        ZStack(alignment: .leading) {
                            NavigationLink(destination: ProductDetailView(product: searchResults[product])) {
                            }
                            .opacity(0)
                            ProductListRow(product: searchResults[product], edit: $edit)
                        }
                    }
                    .onDelete(perform: delete)
                }
                .background(NavigationLink(
                    destination: NewProductView(),
                    isActive: $presentNew) {
                    })
            }
            .navigationBarTitle(Text("Products"))
            .navigationBarItems(trailing:
            HStack {
                if searching {
                    Button("Cancel") {
                        searchText = ""
                        withAnimation {
                            searching = false
                            self.endTextEditing()
                        }
                    }
                }
                else {
                    EditButton()
                        .simultaneousGesture(TapGesture().onEnded {
                            withAnimation {
                                edit.toggle()
                            }
                        })
                    Button("+") {
                        presentNew = true
                    }
                }
            })
        }
    }
    func delete(at indexSet: IndexSet) {
        let productsFilteredById = indexSet.map { searchResults[$0].id }
        _ = productsFilteredById.compactMap { [self] id in
            products.list.removeAll { $0.id == id }
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
