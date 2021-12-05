//
//  StockAppApp.swift
//  StockApp
//
//  Created by Kim Nordin on 2021-10-23.
//

import SwiftUI

@main
struct StockAppApp: App {
    @StateObject private var productList = ProductList()
    var body: some Scene {
        WindowGroup {
            ProductListView()
                .environmentObject(productList)
        }
    }
}
