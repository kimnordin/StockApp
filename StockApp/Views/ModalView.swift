//
//  ModalView.swift
//  StockApp
//
//  Created by Kim Nordin on 2021-08-19.
//

import SwiftUI

struct ModalView<Content: View>: View  {
    @ViewBuilder var contentViews: Content
    var closeModal : () -> ()
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    ScrollView(showsIndicators: false) {
                        contentViews
                    }
                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                    
                    Button(action: {
                        self.closeModal()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 40.0))
                            .foregroundColor(.label)
                    }
                    .shadow(radius: 20)
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 8))
                }
                .padding(geometry.safeAreaInsets)
                .cornerRadius(15)
            }
            .edgesIgnoringSafeArea(.all)
            .background(BackgroundBlurView()
                            .edgesIgnoringSafeArea(.all)
            )
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView() {
            Text("Hello!")
        } closeModal: {}
    }
}


struct BackgroundBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
}
