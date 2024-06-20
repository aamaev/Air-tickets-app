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
        guard let url = URL(string: "https://run.mocky.io/v3/b2a49dcf-1d65-45d6-a26a-3027b98d328e") else {
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
        guard let url = URL(string: "https://run.mocky.io/v3/5b565a4c-8be7-4ef3-9661-7e7d9dc10a7f") else {
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


