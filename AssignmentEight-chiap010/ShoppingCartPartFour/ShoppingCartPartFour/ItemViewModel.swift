//
//  ItemViewModel.swift
//  ShoppingCartPartFour
//
//  Created by Tommy Chiapete on 3/11/21.
//

import Foundation
import FirebaseFirestore


/*
 This is a class that connects and fetches our Firestore Items document
 that I create in the Firebase console.
 */
class ItemViewModel : ObservableObject {
    
    // items state variable, since we need this for our UI
    @Published var items = [Item]()
    
    // Connect to FireStore instance
    private var db = Firestore.firestore()
    
    // fetchData function.  The data returned is the Item object
    func fetchData() {
        
        // Get a snapshot of our Items collection
        db.collection("Items").addSnapshotListener { (querySnapshot, error ) in
            
            // Unlike an if statement, guard statements only run if the conditions are not met.
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found.")
                return
            }
            
            // Map to Item
            self.items = documents.map { (queryDocumentSnapshot) -> Item in
                
                // Get dictionary data, store in data variable.
                let data = queryDocumentSnapshot.data()
                
                // Read the various parts into local variables.
                // We need to type cast each.  If there a nil value, we need to return a default value for each variable
                
                let name = data["name"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let price = data["price"] as? Double ?? 0.00
                
                // Finally, return the Item object to items
                return Item(name: name, description: description, price: price)
                
            }
        }
        
    }
    
}
