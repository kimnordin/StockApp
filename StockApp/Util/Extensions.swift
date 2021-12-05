//
//  Extensions.swift
//  StockApp
//
//  Created by Kim Nordin on 2020-02-23.
//  Copyright © 2020 kim. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import CoreMotion

// Types
extension Int {
    func times(_ f: () -> ()) {
        if self > 0 {
            for _ in 0..<self {
                f()
            }
        }
    }
}

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}

extension Color {
    static let lightText = Color(UIColor.lightText)
    static let darkText = Color(UIColor.darkText)

    static let label = Color(UIColor.label)
    static let secondaryLabel = Color(UIColor.secondaryLabel)
    static let tertiaryLabel = Color(UIColor.tertiaryLabel)
    static let quaternaryLabel = Color(UIColor.quaternaryLabel)

    static let systemBackground = Color(UIColor.systemBackground)
    static let secondarySystemBackground = Color(UIColor.secondarySystemBackground)
    static let tertiarySystemBackground = Color(UIColor.tertiarySystemBackground)
}

// UIVIews
extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    public func alert(isPresented: Binding<Bool>, _ alert: AlertConfig) -> some View {
        AlertHelper(isPresented: isPresented, alert: alert, content: self)
    }
    func customDialog<DialogContent: View>(
        isShowing: Binding<Bool>,
        @ViewBuilder dialogContent: @escaping () -> DialogContent
    ) -> some View {
        self.modifier(CustomDialog(isShowing: isShowing, dialogContent: dialogContent))
    }
}

extension UIAlertController {
    convenience init(alert: AlertConfig) {
        self.init(title: alert.title, message: nil, preferredStyle: .alert)
        addTextField { $0.placeholder = alert.placeholder }
        addAction(UIAlertAction(title: alert.cancel, style: .cancel) { _ in
            alert.action(nil)
        })
        let textField = self.textFields?.first
        addAction(UIAlertAction(title: alert.accept, style: .default) { _ in
            alert.action(textField?.text)
        })
    }
}

extension ScrollView {
    // Fixes ScrollView flickering behind navigation-bar glitch
    public func fixFlickering() -> some View {
        return self.fixFlickering { (scrollView) in
            return scrollView
        }
    }
    public func fixFlickering<T: View>(@ViewBuilder configurator: @escaping (ScrollView<AnyView>) -> T) -> some View {
        GeometryReader { geometryWithSafeArea in
            GeometryReader { geometry in
                configurator(
                    ScrollView<AnyView>(self.axes, showsIndicators: self.showsIndicators) {
                        AnyView(
                            VStack {
                                self.content
                            }
                            .padding(.top, geometryWithSafeArea.safeAreaInsets.top)
                            .padding(.bottom, geometryWithSafeArea.safeAreaInsets.bottom)
                            .padding(.leading, geometryWithSafeArea.safeAreaInsets.leading)
                            .padding(.trailing, geometryWithSafeArea.safeAreaInsets.trailing)
                        )
                    }
                )
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
