//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Alex Bonder on 8/6/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
// add scale: for swift to create the 1x, 2x, and 3x versions.
// This image was built to be 1200 pixels. If I label it as 3x, swift knows that 1x is 400 pixels, and displays that.
        // AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3)
        
// Add closure to specify conditions for the returned image. then image responds to frame modifier
        // AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
        //     image
        //         .resizable()
        //         .scaledToFit()
        //     } placeholder: {
        //         ProgressView()
        //     }
        //     .frame(width: 200, height: 200) // frame works only on the pre-loaded view
        
// "phase in" is different from "image in" - phase gives better error handling
        AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
            if let image = phase.image { // successful download
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil { // failed download
                Text("There was an error loading the image.")
            } else { // until success or fail
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
