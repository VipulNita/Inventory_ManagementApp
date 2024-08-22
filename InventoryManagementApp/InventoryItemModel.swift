//
//  InventoryItemModel.swift
//  InventoryManagementApp
//
//  Created by vipul kumar on 22/08/24.
//

import Foundation
import SwiftUI

struct InventoryItem: Identifiable, Equatable {
    let id: UUID
    let name: String
    var quantity: Int
    let image: UIImage
}
