//
//  SearchTicketsViewModal.swift
//  AirTickets
//
//  Created by Артём Амаев on 19.06.24.
//

import Foundation
import Combine

class SearchTicketsViewModel: ObservableObject {
    @Published var ticketsOffers: [TicketOffer] = []
    private var cancellable: AnyCancellable?
    
    init() {
        loadData()
    }
    
    func loadData() {
        guard let url = URL(string: "https://run.mocky.io/v3/5b565a4c-8be7-4ef3-9661-7e7d9dc10a7f") else {
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: TicketOffersResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error decoding JSON: \(error)")
                }
            }, receiveValue: { [weak self] decodedResponse in
                self?.ticketsOffers = decodedResponse.ticketsOffers
            })
    }
}
