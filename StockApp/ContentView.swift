//
//  ContentView.swift
//  StockApp
//
//  Created by Kim Nordin on 2021-10-23.
//

import SwiftUI

var number = 5
var numbertext = "five"

struct ContentView: View {
    @State var toggle = true
    @State var product: Product = Product(name: "Djurgårds Tröja", image: UIImage(named: "difshirt")!, size: "M")
    var body: some View {
        Image(uiImage: product.image)
        Text(addNameAndSize(name: product.name, size: product.size))
    }
    
    func addNameAndSize(name: String, size: String) -> String {
        return product.name + " " + product.size
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
