//
//  MeasureView.swift
//  StockApp
//
//  Created by Kim Nordin on 2021-12-05.
//

import SwiftUI

struct Measure: View {
    var id = UUID()
    @State var selected: Bool = false
    var title: String
    var callback: ((Measure) -> ())?

    var body: some View {
        Text(title)
            .onTapGesture {
                selected.toggle()
                if let closure = callback {
                    closure(self)
                    print(title)
                    
                }
            }
            .padding(8)
            .font(.body)
            .background(RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2)))
            .foregroundColor(selected ? .label : .red)
    }
}

struct MeasureView: View {
    @Binding var buttonList: [Measure]
    var callback : (Measure) -> ()
    var columns = [GridItem(.adaptive(minimum: 50))]
    var body: some View {
        LazyVGrid(columns: columns, spacing: 8, pinnedViews: .sectionHeaders) {
            ForEach(buttonList.indices) { index in
                self.item(for: buttonList[index])
            }
        }
    }
    private func item(for measure: Measure) -> Measure? {
        Measure(title: measure.title, callback: { measure in
            let filteredMeasure = buttonList.filter({ $0.id != measure.id })
            for thisMeasure in filteredMeasure {
                print("to be unselected: ", thisMeasure.title)
                thisMeasure.selected = false
                callback(thisMeasure)
            }
        })
    }
}
