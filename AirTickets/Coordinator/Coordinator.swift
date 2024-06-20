//
//  Coordinator.swift
//  AirTickets
//
//  Created by Артём Амаев on 18.06.24.
//

import Foundation
import SwiftUI

protocol Coordinator: AnyObject {
    func start() -> AnyView
    func showSearchFlights() -> AnyView
    func showHotels() -> AnyView
    func showShortcuts() -> AnyView
    func showSubscriptions() -> AnyView
    func showProfile() -> AnyView
}

class MainCoordinator: ObservableObject, Coordinator {
    func start() -> AnyView {
        let viewModel = MenuViewModel(coordinator: self)
        return AnyView(MenuView(viewModel: viewModel))
    }

    func showSearchFlights() -> AnyView {
        AnyView(SearchFlightsView())
    }

    func showHotels() -> AnyView {
        AnyView(HotelsView())
    }

    func showShortcuts() -> AnyView {
        AnyView(ShortcutsView())
    }

    func showSubscriptions() -> AnyView {
        AnyView(SubscriptionsView())
    }

    func showProfile() -> AnyView {
        AnyView(ProfileView())
    }
}

