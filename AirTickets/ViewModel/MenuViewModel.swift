//
//  MainViewModel.swift
//  AirTickets
//
//  Created by Артём Амаев on 18.06.24.
//

import SwiftUI

class MenuViewModel: ObservableObject {
    @Published var selectedMenuItem: MenuItem = .tickets
    let coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
}

enum MenuItem: Hashable {
    case tickets, hotels, shortcuts, subscriptions, profile
}



