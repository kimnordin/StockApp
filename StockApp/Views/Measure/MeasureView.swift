//
//  MeasureView.swift
//  StockApp
//
//  Created by Kim Nordin on 2021-12-05.
//

import SwiftUI

struct Measure {
    var id = UUID()
    var selected: Bool
    var title: String
}

struct MeasureView: View {
    @Binding var buttonList: [Measure]
    var columns = [GridItem(.adaptive(minimum: 50))]
    var body: some View {
        LazyVGrid(columns: columns, spacing: 8, pinnedViews: .sectionHeaders) {
            ForEach(buttonList.indices) { index in
                Button(action: {
                    print("Pressed: ", index)
                    buttonList[index].selected = true
                }) {
                    Text(buttonList[index].title)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
                }
            }
        }
    }
}

struct MeasureView_Previews: PreviewProvider {
    static var previews: some View {
        MeasureView(buttonList: .constant([Measure]()))
    }
}
