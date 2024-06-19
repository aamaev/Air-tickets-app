//
//  Coordinator.swift
//  AirTickets
//
//  Created by Артём Амаев on 18.06.24.
//

import Foundation
import SwiftUI

protocol Coordinator {
    func start() -> AnyView
}

class MainCoordinator: Coordinator {
    func start() -> AnyView {
        return AnyView(MainView(viewModel: MainViewModel()))
    }
}
