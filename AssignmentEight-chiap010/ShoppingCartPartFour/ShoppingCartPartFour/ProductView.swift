//
//  ProductView.swift
//  ShoppingCartPartTwo
//
//  Created by Tommy Chiapete on 3/3/21.
//

import SwiftUI
import Combine

/*
 ProductView will show the product information screen, with a passed in
 product name, description, and price.
 */
struct ProductView: View {
    
    // Using an environmental object cart -- environment objects can be shared among different screens
    @EnvironmentObject var cart: Cart
    
    // State variable for showing alert
    @State private var showingAlert: Bool = false
    
    // Variables we need to each thing we need to pass in
    let name: String
    let description: String
    let price: Double
    
    // Constructor with parameters.  Set parameter arguments to ProductView variables
    init(name: String, description: String, price: Double) {
        
        self.name = name
        self.description = description
        self.price = price
    }
    
    // Default Constructor
    init() {
        name = "Default Name"
        description = "Default Description"
        price = 0.00
    }
    
    
    /*
     My goal here is to show a clean display of information we
     want to show on screen.  This can be done with a VStack and some
     Spacers.
     */
    
    var body: some View {
        
        // Vertically stack these elements
        VStack {
            
            // Show product name passed in.  Bold it.  Make is large.
            Text(name)
                .fontWeight(.bold)
                .font(.largeTitle)
            
            // Add a spacer to space things nicely!
            Spacer()
            
            // Show the product description passed in.
            // I'm fine with its default formatting
            // so I didn't put on any modifiers at this time.
            Text(description)
            
            // Another spacer to space things nicely.
            Spacer()
            
            
            // Show the price passed in.  Format it to two decimal places.
            // I like a little letter spacing with the heavy font weight.
            
            Text("$" + String(format: "%.2f", price))
                .kerning(2.5)
                .fontWeight(.heavy)
                .font(.largeTitle)
            
            
            
            // Create button
            Button(action: {
                
                // Print statement for debugging purposes.
                print("Adding " + name)
                
                // Add this item listed to the cart
                cart.addToCart(name: name, description: description, price: price)
                
                // When the item has been added, update state variable
                showingAlert = true
                
            }) {
                
                // Add the "Add To Cart" text.  Center align with a font size that
                // looks good for the button.
                Text("Add To Cart")
                    .bold()
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .center)
                
            }
            
            // Present the alert verifying adding of the item
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Added to Cart"), message: Text(name), dismissButton: .default(Text("Awesome!")))
            }
            .padding(5.0)  // give it some padding to give it some space
            
            // The button color will be a blue and purple gradient.
            // I thought it looked kind of cool.
            .background(
                ZStack {
                    Color.blue
                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing)
                }
                
            )
            
            // White letters looks good on the dark button.
            .foregroundColor(.white)
            
            
            // Round the corners a bit, because I think it looks better.
            .cornerRadius(5.0)
            
            // Finally, add some spacing between the button and the bottom of the screen
            Spacer()
        }
        .padding()
        
    }

    
}



/*
 Create some previews.
 This will help me picture what this screen will look like in the simulator.
 I want to see one using the light color scheme and another one with the dark color scheme.
 */
struct ProductView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        
        ProductView(name: "Item Name", description: "Description", price: 49.99)
            .preferredColorScheme(.light)
        
        ProductView(name: "Item Name", description: "Description", price: 49.99)
            .preferredColorScheme(.dark)
        
    }
}

