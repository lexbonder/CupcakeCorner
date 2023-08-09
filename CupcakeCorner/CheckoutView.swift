//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Alex Bonder on 8/7/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var failedMessage = ""
    @State private var showingFailed = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.data.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
        .alert("Order Failed", isPresented: $showingFailed) {
            Button("OK") { }
        } message: {
            Text(failedMessage)
        }
    }
    
    func placeOrder() async {
        // convert order object to JSON
        guard let encoded = try? JSONEncoder().encode(order.data) else {
            print("Failed to encode order")
            return
        }
        
        // tell swift how to send data - create and configure urlRequest object
        let url = URL(string: "https://reqres.in/api/cupcakes")! // live api testint site
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        // do something with resopnse
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Data.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Data.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            
            showingConfirmation = true
        } catch {
            failedMessage = error.localizedDescription
            showingFailed = true
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckoutView(order: Order())
        }
    }
}
