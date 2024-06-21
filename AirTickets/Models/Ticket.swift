//
//  Ticket.swift
//  AirTickets
//
//  Created by Артём Амаев on 20.06.24.
//

import Foundation

struct Ticket: Identifiable, Codable {
    let id: Int
    let badge: String?
    let price: Price
    let providerName: String
    let company: String
    let departure: FlightDetail
    let arrival: FlightDetail
    let hasTransfer: Bool
    let hasVisaTransfer: Bool
    let luggage: Luggage
    let handLuggage: HandLuggage
    let isReturnable: Bool
    let isExchangable: Bool
    
    struct Price: Codable {
        let value: Int
    }
    
    struct FlightDetail: Codable {
        let town: String
        let date: String
        let airport: String
    }
    
    struct Luggage: Codable {
        let hasLuggage: Bool?
        let price: Price?
    }
    
    struct HandLuggage: Codable {
        let hasHandLuggage: Bool?
        let size: String?
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case badge
        case price
        case providerName = "provider_name"
        case company
        case departure
        case arrival
        case hasTransfer = "has_transfer"
        case hasVisaTransfer = "has_visa_transfer"
        case luggage
        case handLuggage = "hand_luggage"
        case isReturnable = "is_returnable"
        case isExchangable = "is_exchangable"
    }
}

struct TicketsResponse: Decodable {
    let tickets: [Ticket]
}
