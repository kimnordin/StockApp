//
//  CustomDialog.swift
//  StockApp
//
//  Created by Kim Nordin on 2021-08-13.
//

import SwiftUI

struct CustomDialog<DialogContent: View>: ViewModifier {
    @Binding var isShowing: Bool // set this to show/hide the dialog
    let dialogContent: DialogContent
    
    init(isShowing: Binding<Bool>,
         @ViewBuilder dialogContent: () -> DialogContent) {
        _isShowing = isShowing
        self.dialogContent = dialogContent()
    }
    
    func body(content: Content) -> some View {
        // wrap the view being modified in a ZStack and render dialog on top of it
        ZStack {
            content
            if isShowing {
                // the semi-transparent overlay
                Rectangle().foregroundColor(Color.black.opacity(0.6))
                // the dialog content is in a ZStack to pad it from the edges
                // of the screen
                ZStack {
                    dialogContent
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.label))
                }.padding(40)
            }
        }
    }
}
