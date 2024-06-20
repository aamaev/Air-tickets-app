//
//  TicketOffer.swift
//  AirTickets
//
//  Created by Артём Амаев on 19.06.24.
//

import Foundation

struct TicketOffer: Codable, Identifiable {
    let id: Int
    let title: String
    let timeRange: [String]
    let price: Price
    
    struct Price: Codable {
        let value: Int
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, timeRange = "time_range", price
    }
}


struct TicketOffersResponse: Codable {
    let ticketsOffers: [TicketOffer]

    enum CodingKeys: String, CodingKey {
        case ticketsOffers = "tickets_offers"
    }
}

