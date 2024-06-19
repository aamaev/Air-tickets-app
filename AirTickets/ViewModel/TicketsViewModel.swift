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
    private var cancellable: AnyCancellable?
    
    init() {
        loadData()
    }
    
    func loadData() {
        guard let url = URL(string: "https://run.mocky.io/v3/b2a49dcf-1d65-45d6-a26a-3027b98d328e") else {
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: OffersResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error decoding JSON: \(error)")
                }
            }, receiveValue: { [weak self] decodedResponse in
                self?.offers = decodedResponse.offers
            })
    }
}


