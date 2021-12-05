//
//  TagView.swift
//  StockApp
//
//  Created by Kim Nordin on 2021-08-13.
//

import SwiftUI

struct TagView: View {
    var tags: [String]
    var callback : (Tag) -> ()
    
    @State private var totalHeight = CGFloat.infinity
    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(maxHeight: totalHeight)
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.tags, id: \.self) { tag in
                self.item(for: tag)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == self.tags.last! {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { d in
                        let result = height
                        if tag == self.tags.last! {
                            height = 0
                        }
                        return result
                    })
            }
        }
        .background(viewHeightReader($totalHeight))
    }

    private func item(for text: String) -> Tag {
        Tag(title: text, callback: { tag in
            callback(tag)
        })
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

struct Tag: View, Equatable {
    static func == (lhs: Tag, rhs: Tag) -> Bool {
        return lhs.title == rhs.title
    }
    
    var title: String
    var selected: Bool = false
    var callback: ((Tag) -> ())?
    
    var body: some View {
        Text(title)
            .onTapGesture {
                if let closure = callback {
                    closure(self)
                }
            }
            .padding(8)
            .font(.body)
            .background(RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2)))
            .foregroundColor(.label)
    }
}
