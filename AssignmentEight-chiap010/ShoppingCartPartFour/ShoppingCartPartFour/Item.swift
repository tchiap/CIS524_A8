//
//  Item.swift
//  ShoppingCart
//
//  Created by Tommy Chiapete on 2/18/21.
//

import Foundation
import SwiftUI

/*
 Created the Item struct.
 Each Item will have a name, description, and price.

 */

struct Item: Identifiable {
    
    let id = UUID()
    
    let name: String
    let description: String
    let price: Double
    
    // Initializer with parameters
    init(name: String, description: String, price: Double) {
        
        self.name = name
        self.description = description
        self.price = price
        
    }
    
    
    
    // Note:  I purged the Item data from previous assignments.
    // Item data is now in Firebase.  That code fetching data from Firebase is in ItemViewModel.swift.
    
}





