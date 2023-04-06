//
//  ContentView.swift
//  ShoppingCart
//
//  Created by Tommy Chiapete on 2/18/21.
//

import SwiftUI

/*
 This is an extension method that I found that lets me control the color of
 the NavigationBar, since I can't find a direct way to modify the color using
 Swift.  The NavigationBarColor is defined as a an asset in Assets.xcassets.
 */
extension UINavigationController {
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // When you scroll or you have title (small one)
        let standard = UINavigationBarAppearance()
        standard.backgroundColor = UIColor(named: "NavigationBarColor")
        
        // Compact-height
        let compact = UINavigationBarAppearance()
        compact.backgroundColor = UIColor(named: "NavigationBarColor")
        
        // Large title
        let scrollEdge = UINavigationBarAppearance()
        scrollEdge.backgroundColor = UIColor(named: "NavigationBarColor")
        
        // Apply colors to different navigation bar appearances
        navigationBar.standardAppearance = standard
        navigationBar.compactAppearance = compact
        navigationBar.scrollEdgeAppearance = scrollEdge
        
        
    }
}

/*
 The ContentView will call other UI elements to show as well.
 Show the header, and the ScrollView will load the ListView struct
 inside a vertical stack to show the items.
 */
struct ContentView: View {
    
    // State variable to construct cart.  I can use environment objects on other screens to reference the cart.
    @StateObject var cart = Cart()
    
    // State variable for our ItemViewModel.
    @StateObject private var viewModel = ItemViewModel()
    
    var body: some View {
        
        // Used this as a resource
        // https://www.youtube.com/watch?v=IopCl8sOyFA
        
        // Using a NavigationView so we can create navigation between screens
        NavigationView {
            
            
            // Using a ScrollView allows us to create a
            // scrolling container of Views.
            ScrollView {
                VStack(spacing: 5) {
                    
                    // Call the ListView to show.  Give it some padding on the left and right side.
                    ListView()
                        .padding(.leading)
                        .padding(.trailing)
                    
                }
                .padding(.top) // add a little padding to the top of the stack
            }
            //.navigationTitle("Start Shopping!")
            .navigationBarTitle(Text("Start Shopping!"))
            //.navigationBarItems(trailing: CartButton())
            
            // Attach the Cart button to the toolbar
            .toolbar {
                CartButton()
            }
            
        }
        
        // When NavigationView appears, go and fetch the Item data from Firebase.
        .onAppear() {
            
            print("fetchdata")
            self.viewModel.fetchData()
            
        }
        
        // Write the cart and viewModel to the environment
        .environmentObject(cart)
        .environmentObject(viewModel)
        
    }
}

/*
 Construct the Cart Button to specs.
 It will have a shopping cart icon, along with some "Cart Text"
 */
struct CartButton : View {
    var body: some View {
        
        // Create a link that will navigate to CartView()
        NavigationLink(destination: CartView())
        {
            
            // Use an HStack in order to construct the button.
            HStack {
                
                // Left side:  Show shopping cart image
                Image("ShoppingCartImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32.0, height: 32.0)
                
                // Right side:  Show "Cart" Text
                Text("Cart")
            }
            .frame(width: 100.0, height: 42.0)
            
            // Show a border around the button, and make the button rounded
            .background(Color.white)
            .border(Color.black, width: 2.0)
            .cornerRadius(5.0)
            
        }
        
    }
}


/*
 The ListView struct will loop through our list of items,
 calling another struct called RowView which builds the actual
 item information, price, and Add button UI.
 */
struct ListView : View {
    
    @EnvironmentObject var viewModel: ItemViewModel
    
    var body: some View {
        
        
        
        // For each item in our Item list that came from our ItemViewModel,
        // we'll grab the name, description, and price of each Item from Firebase.
        // Pass that information into RowView which creats the Row UI on the screen.
        // While I don't use the description in the Row UI in the item list,
        // I need it to pass to the ProductView, which contains the description on that screen.
        
        
        ForEach(viewModel.items) { i in
            
            RowView(name: i.name, description: i.description, price: i.price)
            
        }
        
    }

}


/*
 This RowView struct builds the item's row user interface.
 To act like a table, I decided to use two vertical stacks inside a
 horizontal stack.  In another words, one row with two columns for each item.
 In the first column, I display the item name and description.
 In the second column, I display the price and the "Add" button.
 */
struct RowView: View {
    
    // Each RowView needs an item name, description, and price.
    let name: String
    let description: String
    let price: Double
    
    var body: some View {
        

        // Use a horizontal stack to act like a row in a table
        HStack {
            
            // The first vertical stack (left side)
            VStack {
                
                // Show item name.  Extend the width.  Align left.
                Text(name)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
            }
            
            
            // The second vertical stack (right side)
            VStack {
                
                // Show price with dollar sign.  Format it to two decimal places.  Bold it.  Limit width to 100.  Align right.
                Text("$" + String(format: "%.2f", price))
                    .bold()
                    .frame(maxWidth: 100, alignment: .trailing)
                
                // Using the spacer for a bit of spacing
                Spacer()
                
                // Create a NavigationLink that goes to the ProductView screen,
                // passing in the name of the product, description, and the price.
                // Give it a label of "Detail >".  Align right.
                
                NavigationLink(
                    destination: ProductView(name: name, description: description, price: price),
                                            
                    label: {
                        Text("Details >")
                            .frame(maxWidth: 95, alignment: .trailing)
                            .font(.subheadline)
                            .foregroundColor(.blue)
                            
                            
                    })
                    
                
            }
            
            
        }.padding(.bottom)  // Give this vertical stack some bottom padding.
        
        // Add a separation line.  When all items are rendered, items will
        // be separated by a line break to help readability.
        Rectangle()
            .frame(height: 1.0, alignment: .bottom)
            .foregroundColor(Color.gray)

    }

}



/*
 Preview our views in Xcode.  Call ContentView.
 ContentView will show all UI elements on the screen when
 previewing is enabled.
 
 I have it showing it for light and dark view, since there is a slight change of
 background color of the navigation bar.
 */
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
    
            ContentView()
                .preferredColorScheme(.light)
            
            
            ContentView()
                .preferredColorScheme(.dark)
        
        
            CartButton()
        
    }
}

 
