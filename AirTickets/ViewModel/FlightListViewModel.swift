//
//  FlightListViewModel.swift
//  AirTickets
//
//  Created by Артём Амаев on 20.06.24.
//

import Foundation
import Combine

class FlightListViewModel: ObservableObject {
    @Published var ticketsList: [Ticket] = []
    private var cancellables: Set<AnyCancellable> = []

    init() {
        loadTickets()
    }

    func loadTickets() {
        guard let url = URL(string: "https://run.mocky.io/v3/c0464573-5a13-45c9-89f8-717436748b69") else {
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: TicketsResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error decoding JSON (offers): \(error)")
                }
            }, receiveValue: { [weak self] decodedResponse in
                self?.ticketsList = decodedResponse.tickets
            })
            .store(in: &cancellables)
    }
}
