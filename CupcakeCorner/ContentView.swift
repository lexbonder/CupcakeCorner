//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Alex Bonder on 8/6/23.
//

import SwiftUI

struct Response: Codable {
    let results: [Result]
}

struct Result: Codable {
    let trackId: Int
    let trackName: String
    let collectionName: String
}

struct ContentView: View {
    @State private var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        // build url
        guard let url = URL(string: "https://itunes.apple.com/search?term=bug+hunter&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            // get data from url
            let (data, _) = try await URLSession.shared.data(from: url)
            // decode data
            if let decoded = try? JSONDecoder().decode(Response.self, from: data) {
                results = decoded.results
            }
        } catch {
            print("Failed to retrieve data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
