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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<products.list.count, id: \.self) { product in
                    ZStack(alignment: .leading) {
                        NavigationLink(destination: ProductDetailView(product: products.list[product])) {
                        }
                        .opacity(0)
                        ProductListRow(product: products.list[product], edit: $edit)
                    }
                }
                .onMove(perform: move)
                .onDelete(perform: delete)
            }
            .background(NavigationLink(
                destination: NewProductView(),
                isActive: $presentNew) {
                })
            .navigationBarTitle(Text("Products"))
            .navigationBarItems(leading:
                                    HStack {
                Button("Profile") {
                }
            }
                                , trailing:
                                    HStack {
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
            )
        }
    }
    private func move(at indexSet: IndexSet, to destination: Int) {
        products.list.move(fromOffsets: indexSet, toOffset: destination)
    }
    func delete(at indexSet: IndexSet) {
        products.list.remove(atOffsets: indexSet)
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
