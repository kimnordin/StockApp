//
//  NewProductView.swift
//  StockApp
//
//  Created by Kim Nordin on 2020-10-17.
//

import SwiftUI

struct NewProductView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var products: ProductList
    @State private var permProduct = Product(name: "")
    @State private var showAlert = false
    @State private var showAction = false
    @State private var changeAlert = false
    @State private var presentModal = false
    @State private var showImagePicker = false
    @State private var selectedTag: Tag?
    @State private var tags = [Tag]()
    @State private var measures = [Measure]()
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ScrollView(showsIndicators: false) {
                    if (permProduct.image == nil) {
                        Text("Snap a picture of the Product")
                            .padding()
                        Image(systemName: "camera.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .onTapGesture {
                                displayImagePicker()
                            }
                    } else {
                        Image(uiImage: permProduct.image!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .onTapGesture {
                                displayActionSheet()
                            }
                    }
                    VStack {
                        TextField("Enter a fitting Name for this Product", text: $permProduct.name)
                            .multilineTextAlignment(.center)
                            .padding(EdgeInsets(top: 40, leading: 20, bottom: 20, trailing: 20))
                        
                        HStack {
                            Text("Tags")
                                .font(.headline)
                            Button("+") {
                                showAlert = true
                            }
                            .accentColor(.label)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                        TagView(tags: stringTags(), callback: { tag in
                            selectedTag(tag)
                        })
                            .lineLimit(1)
                            .padding()
                        MeasureView(buttonList: $measures)
                    }
                }
                .fixFlickering()
                .alert(isPresented: $showAlert, AlertConfig(title: "Tag", placeholder: "Add a Tag", action: {
                    if let string = $0 {
                        addTag(string)
                    }
                }))
                .alert(isPresented: $changeAlert, AlertConfig(title: "Change Tag", placeholder: selectedTag?.title ?? "", action: {
                    if let string = $0 {
                        changeTag(string)
                    }
                }))
                .sheet(isPresented: $showImagePicker, onDismiss: {
                    dismissImagePicker()
                }, content: {
                    ImagePicker(presenting: $showImagePicker, uiImage: $permProduct.image)
                })
                .actionSheet(isPresented: $showAction) {
                    sheet
                }
                Group {
                    Button(action: {
                        var newProduct = permProduct
                        for tag in tags {
                            newProduct.tags.append(tag.title)
                        }
                        products.addProduct(newProduct)
                        presentation.wrappedValue.dismiss()
                    }, label: {
                        Text("Add Product")
                            .frame(width: 120, height: 60)
                            .foregroundColor(.label)
                    })
                        .padding(.horizontal, 8).lineLimit(1).minimumScaleFactor(0.4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.label, lineWidth: 4)
                        )
                }
            }
            .navigationBarTitle(Text("New Product"))
            .onAppear {
                createMeasurements()
            }
        }
    }
    var sheet: ActionSheet {
        ActionSheet(
            title: Text("Action"),
            message: Text("Update Image"),
            buttons: [
                .default(Text("Change"), action: {
                    dismissActionSheet()
                    displayImagePicker()
                }),
                .cancel(Text("Close"), action: {
                    dismissActionSheet()
                }),
                .destructive(Text("Remove"), action: {
                    dismissActionSheet()
                    permProduct.image = nil
                })
            ])
    }
    func createMeasurements() {
        measures = [Measure]()
        for measure in 0..<ProductSize.allCases.count {
            var size = String("\(ProductSize.undefined.index(measure))")
            if ProductSize.undefined.index(measure) == .undefined {
                size = "None"
            }
            let newMeasure = Measure(selected: false, title: size)
            measures.append(newMeasure)
        }
    }
    func stringTags() -> [String] {
        var strTags = [String]()
        for tag in tags {
            if tag.title != "" {
                strTags.append(tag.title)
            }
        }
        return strTags
    }
    func canCreate(tag: Tag) -> Bool {
        var titleList = [String]()
        if tag.title.isEmpty {
            return false
        }
        for tag in tags {
            titleList.append(tag.title)
        }
        return true
    }
    func addTag(_ name: String) {
        if canCreate(tag: Tag(title: name)) {
            tags.append(Tag(title: name))
        }
    }
    func removeTag(_ tag: Tag) {
        if let index = tags.firstIndex(of: tag) {
            tags.remove(at: index)
        }
    }
    func changeTag(_ text: String) {
        if let tag = selectedTag {
            if text != "" {
                removeTag(tag)
                addTag(text)
            }
            else {
                removeTag(tag)
            }
        }
    }
    func selectedTag(_ tag: Tag) {
        selectedTag = tag
        changeAlert = true
    }
    private func displayActionSheet() {
        showAction = true
    }
    private func dismissActionSheet() {
        showAction = false
    }
    private func displayImagePicker() {
        showImagePicker = true
    }
    private func dismissImagePicker() {
        showImagePicker = false
    }
}

struct NewProductView_Previews: PreviewProvider {
    static var previews: some View {
        NewProductView()
    }
}
