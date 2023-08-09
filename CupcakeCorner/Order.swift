//
//  Order.swift
//  CupcakeCorner
//
//  Created by Alex Bonder on 8/7/23.
//

import SwiftUI

class Order: ObservableObject {
    @Published var data = Data()
}

struct Data: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty
            || streetAddress.isEmpty
            || city.isEmpty
            || zip.isEmpty
            || trimmed(name).isEmpty
            || trimmed(streetAddress).isEmpty
            || trimmed(city).isEmpty
            || trimmed(zip).isEmpty
        {
            return false
        }
        return true
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // Complicated cakes cost more
        cost += Double(type) / 2
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
    private func trimmed(_ str: String) -> String {
        str.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
