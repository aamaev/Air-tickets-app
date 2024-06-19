//
//  Offer.swift
//  AirTickets
//
//  Created by Артём Амаев on 18.06.24.
//

import Foundation

struct OffersResponse: Decodable {
    let offers: [Offer]
}

struct Offer: Identifiable, Decodable {
    let id: Int
    let title: String
    let town: String
    let price: Price
    
    struct Price: Decodable {
        let value: Int
    }
}


