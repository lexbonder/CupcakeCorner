//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Alex Bonder on 8/7/23.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.data.name)
                TextField("Street address", text: $order.data.streetAddress)
                TextField("City", text: $order.data.city)
                TextField("Zip code", text: $order.data.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
                .disabled(!order.data.hasValidAddress)
            }
        }
        .navigationBarTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(order: Order())
        }
    }
}
