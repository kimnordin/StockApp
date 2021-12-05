//
//  Product.swift
//  StockApp
//
//  Created by Kim Nordin on 2021-10-23.
//

import Foundation
import SwiftUI

class ProductList: ObservableObject {
    @Published var list = [testProductData[0], testProductData[1], testProductData[2], testProductData[3]]
    
    var count: Int {
        return list.count
    }
    
    func addProduct(_ product: Product) {
        list.append(product)
    }
    
    func clearProducts() {
        list.removeAll()
    }
    
    func deleteProduct(index: Int){
        list.remove(at: index)
    }
    
    func entry(index: Int) -> Product? {
        if index >= 0 && index <= list.count {
            return list[index]
        }
        return nil
    }
}

class Product: Identifiable, ObservableObject {
    let id = UUID()
    var name: String
    var image: UIImage?
    var size: ProductSize = .undefined
    var type: ProductType = .undefined
    @Published var amount: Int = 0
    var tags = [String]()
    
    init(name: String, image: UIImage? = nil, size: ProductSize = .undefined, type: ProductType = .undefined, amount: Int = 0, tags: [String] = [String]()) {
        self.name = name
        self.image = image
        self.size = size
        self.type = type
        self.amount = amount
        self.tags = tags
    }
}

enum ProductType: String, CaseIterable {
    case shirt, sweater, jacket, socks, pants, shoes, scarf, hat, accessory, undefined
}

enum ProductSize: String, CaseIterable {
    case XXS = "XX Small",
         XS = "X Small",
         S = "Small",
         M = "Medium",
         L = "Large",
         XL = "X Large",
         XXL = "XX Large",
         ALL = "Fits all",
         undefined = "Undefined"
}

#if DEBUG
let testProductData = [
    Product(name: "Djurgården Tröja", image: UIImage(named: "difshirt")!, size: .M, type: .shirt, tags: ["DIF", "Erlandsson"]),
    Product(name: "Djurgården Mössa", image: UIImage(named: "difcap")!, size: .ALL, type: .hat, tags: ["DIF", "Winter"]),
    Product(name: "Djurgården Tjocktröja", image: UIImage(named: "difhoodie")!, size: .XL, type: .sweater, tags: ["DIF", "CCM"]),
    Product(name: "Djurgården Halsduk", image: UIImage(named: "difscarf")!, size: .ALL, type: .scarf, tags: ["DIF", "Winter"])
]
#endif
