//
//  InventoryHomeView.swift
//  InventoryManagementApp
//
//  Created by vipul kumar on 22/08/24.
//

import SwiftUI
import UIKit

struct InventoryHomeView: View {
    let shopName: String

    @State private var inventoryItems: [InventoryItem] = []
    @State private var isImagePickerPresented = false
    @State private var newImage: UIImage?
    @State private var newName: String = ""
    @State private var newQuantity: Int = 0

    var body: some View {
        VStack {
            Text("Inventory for \(shopName)")
                .font(.largeTitle)
                .padding()

            List {
                ForEach(inventoryItems) { item in
                    HStack {
                        Image(uiImage: item.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(Rectangle())

                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)

                            Stepper(value: $inventoryItems[inventoryItems.firstIndex(of: item)!].quantity, in: 0...100) {
                                Text("Quantity: \(item.quantity)")
                            }
                        }
                    }
                }
            }

            Spacer()

            VStack {
                if let image = newImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding()
                } else {
                    Button(action: {
                        isImagePickerPresented = true
                    }) {
                        Text("Add Product Image")
                            .foregroundColor(.blue)
                    }
                }

                TextField("Enter Product Name", text: $newName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Stepper(value: $newQuantity, in: 0...100) {
                    Text("Quantity: \(newQuantity)")
                }
                .padding()

                Button(action: addInventoryItem) {
                    Text("Save Product")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(8)
                }
                .padding()
                .disabled(newImage == nil || newName.isEmpty)
            }
        }
        .padding()
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $newImage)
        }
    }

    func addInventoryItem() {
        guard let image = newImage else { return }
        let newItem = InventoryItem(id: UUID(), name: newName, quantity: newQuantity, image: image)
        inventoryItems.append(newItem)
        newImage = nil
        newName = ""
        newQuantity = 1
    }
}

#Preview {
    InventoryHomeView(shopName: "Sample Shop")
}
