//
//  TicketsViewModel.swift
//  AirTickets
//
//  Created by Артём Амаев on 18.06.24.
//

import Foundation
import Combine

class TicketsViewModel: ObservableObject {
    @Published var offers: [Offer] = []
    @Published var ticketsOffers: [TicketOffer] = []
    private var cancellables: Set<AnyCancellable> = []

    init() {
        loadOffers()
    }

    func loadOffers() {
        guard let url = URL(string: "https://run.mocky.io/v3/ad9a46ba-276c-4a81-88a6-c068e51cce3a") else {
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: OffersResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error decoding JSON (offers): \(error)")
                }
            }, receiveValue: { [weak self] decodedResponse in
                self?.offers = decodedResponse.offers
            })
            .store(in: &cancellables)
    }

    func loadTicketsOffers() {
        guard let url = URL(string: "https://run.mocky.io/v3/38b5205d-1a3d-4c2f-9d77-2f9d1ef01a4a") else {
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: TicketOffersResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error decoding JSON (ticketsOffers): \(error)")
                }
            }, receiveValue: { [weak self] decodedResponse in
                self?.ticketsOffers = decodedResponse.ticketsOffers
            })
            .store(in: &cancellables)
    }
}


