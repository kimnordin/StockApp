//
//  ContentView.swift
//  StockApp
//
//  Created by Kim Nordin on 2021-10-23.
//

import SwiftUI
import Combine

struct ProductDetailView: View {
    @ObservedObject var product: Product
    @State private var toggle = true
    @State private var amountText = "0" {
        didSet {
            verifyAmount()
        }
    }
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                if let image = product.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 250)
                        .padding()
                }
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Size: ")
                        Text(product.size.rawValue)
                            .fontWeight(.bold)
                    }
                    HStack {
                        Text("Type: ")
                        Text(product.type.rawValue)
                            .fontWeight(.bold)
                    }
                    if !product.tags.isEmpty {
                        TagView(tags: product.tags, callback: {_ in})
                            .lineLimit(1)
                    }
                }
                .padding()
            }
            Group {
                VStack(spacing: 8) {
                    Text("Add or Remove Product")
                    TextField("Amount", text: $amountText)
                        .font(.title)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .onReceive(Just(amountText)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                amountText = filtered
                            }
                        }
                    HStack {
                        Button(action: {
                            if let amountNum = Int(amountText) {
                                if amountNum > 0 {
                                    let amountMinusOne = amountNum - 1
                                    amountText = String(amountMinusOne)
                                }
                            }
                        }, label: {
                            Text("- 1")
                                .font(.title2)
                                .frame(width: 120, height: 60)
                                .foregroundColor(.label)
                        })
                            .padding(.horizontal, 8).lineLimit(1).minimumScaleFactor(0.4)
                            .background(Color.red)
                            .cornerRadius(30)
                        
                        Button(action: {
                            if let amountNum = Int(amountText) {
                                let amountPlusOne = amountNum + 1
                                amountText = String(amountPlusOne)
                            }
                        }, label: {
                            Text("+ 1")
                                .font(.title2)
                                .frame(width: 120, height: 60)
                                .foregroundColor(.label)
                        })
                            .padding(.horizontal, 8).lineLimit(1).minimumScaleFactor(0.4)
                            .background(Color.green)
                            .cornerRadius(30)
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle(Text(product.name))
        .onTapGesture {
            self.endTextEditing()
            verifyAmount()
        }
        .onAppear {
            amountText = String(product.amount)
        }
        .onDisappear {
            verifyAmount()
        }
    }
    
    func verifyAmount() {
        if amountText.isEmpty {
            product.amount = 0
            amountText = "0"
        }
        else {
            if let amountNum = Int(amountText) {
                if amountNum >= 0 {
                    product.amount = amountNum
                }
            }
        }
    }
    
    func addNameAndSize(name: String, size: ProductSize) -> String {
        return name + " " + size.rawValue
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: testProductData[0])
    }
}
