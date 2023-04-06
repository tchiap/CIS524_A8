//
//  CartView.swift
//  ShoppingCartPartThree
//
//  Created by Tommy Chiapete on 3/8/21.
//

import SwiftUI


/*
 CartView will show the shopping cart items currently in the cart.
 At the bottom of the screen, show the total price of everything in the cart.
 */
struct CartView: View {
    
    // Using an environmental object cart -- environment objects can be shared among different screens
    @EnvironmentObject var cart: Cart
    
    var body: some View {
        
        // Stack the list and the total vertically.
        VStack {
            
            // Build the list and output the items currently in the cartArray of type Item.
            List {
                ForEach(cart.cartArray, id: \.id) { cart in
                    ItemView(name: cart.name, price: cart.price)
                }
                
                // Delete functionality -- call delete() to eliminate items and update the total.
                .onDelete(perform: { indexSet in
                    cart.delete(at: indexSet)
                })
                
            }
            
            // Finally, show the Total.  Bold it and align it to the right.
            // I gave it a backgcolor to make it a little more prominent.
            
            Text("Total:  $"+String(format: "%.2f", cart.total))
                .bold()
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                .background(
                    ZStack {
                        Color("NavigationBarColor")
                    }
                    
                )
        }
        
    }
}

/*
 ItemView -- A view to show each cart item
 It takes in a item name and a price.
 Each item I want to show the item name on one side and the price on the other.
 */
struct ItemView: View {
    
    let name: String
    let price: Double
    
    var body: some View {
        
        // Using an HStack since I want to show two pieces of information horizontally
        HStack {
            
            // Left side:  Show the item name
            Text(name)
            
            // Using a spacer to generate some spacing between the item name and price
            Spacer()
            
            // Right side:  Show the item price.  I'll format it to 2 decimals and bolden it.
            Text("$" + String(format: "%.2f", price))
                .bold()
            
        }
        
        // Define navigation bar title to be "Cart"
        .navigationBarTitle(Text("Cart"))
    }
    
    
}

/*
 Cart class
 This holds a cartArray and total.
 This has a cart item add and a delete function.
 */
class Cart: ObservableObject {
    
    // Total of cart.  @Published so I can use this in state.
    @Published var total: Double = 0.00
    
    // Cart array of type Item.  @Published so I can use this in state.
    @Published var cartArray = [Item]()
        
    init() {
        cartArray = [Item]()
        total = 0.00
    }
    

    // addToCart() function.  Takes in an item name, description, and price.
    // Add then adds the Item constructed and appends it to the cart array.
    func addToCart(name: String, description: String, price: Double) {
        
        cartArray.append(
            Item(name: name, description: description, price: price)
        )
        
        // Finally, update the total by adding the item price to the total.
        total += price
        
    }
    
    // delete() function.  Takes in an IndexSet.
    func delete(at offsets: IndexSet) {
        
        // IndexSet is a set of indexes, so we'll need to loop through the set.
        offsets.forEach { (i) in
            
            // Update the total by subtracting the item price to the total.
            total -= cartArray[i].price
            
            // Remote the item at position "i" from the cart array.
            cartArray.remove(at: i)
        }
        
    }
 
 }
 
    



/*

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
 */
 
