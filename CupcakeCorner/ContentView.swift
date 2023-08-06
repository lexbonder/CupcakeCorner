//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Alex Bonder on 8/6/23.
//

import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var email = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create Account") {
                    print("Creating Account...")
                }
            }
            .disabled(disableForm) // recieves a boolean
        }
    }
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
