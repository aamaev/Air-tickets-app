//
//  MenuView.swift
//  AirTickets
//
//  Created by Артём Амаев on 18.06.24.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var selectedMenuItem: MenuItem = .tickets
    
    func selectMenuItem(_ item: MenuItem) {
        selectedMenuItem = item
    }
}

enum MenuItem: Hashable {
    case tickets, hotels, shortcuts, subscriptions, profile
}


