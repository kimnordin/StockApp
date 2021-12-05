//
//  ImagePicker.swift
//  StockApp
//
//  Created by Kim Nordin on 2020-10-18.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {

    @Binding var presenting: Bool
    @Binding var uiImage: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        @Binding var presenting: Bool
        @Binding var uiImage: UIImage?

        init(presenting: Binding<Bool>, uiImage: Binding<UIImage?>) {
            _presenting = presenting
            _uiImage = uiImage
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let imagePicked = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            uiImage = imagePicked
            presenting = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presenting = false
        }

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presenting: $presenting, uiImage: $uiImage)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
}
