//
//  ProductListRow.swift
//  StockApp
//
//  Created by Kim Nordin on 2020-10-17.
//

import SwiftUI

struct ProductListRow: View {
    @ObservedObject var product: Product
    @Binding var edit: Bool
    var body: some View {
        HStack(alignment: .center) {
            if !edit {
                if let image = product.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                }
            }
            Spacer()
            VStack(spacing: 4) {
                Text(product.name).font(.title)
                    .lineLimit(2)
                Text("\(product.amount)")
                    .font(.title2)
            }
            Spacer()
        }
    }
}

struct ProductListRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductListRow(product: testProductData[0], edit: .constant(false))
    }
}
