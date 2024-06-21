//
//  MenuView.swift
//  AirTickets
//
//  Created by Артём Амаев on 18.06.24.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var viewModel: MenuViewModel

    var body: some View {
        TabView(selection: $viewModel.selectedMenuItem) {
            viewModel.coordinator.showSearchFlights()
                .tabItem {
                    Image(.airplane).renderingMode(.template)
                    Text("Авиабилеты")
                        .font(.custom("SFProDisplay-Regular", size: 10))
                }
                .tag(MenuItem.tickets)
            
            viewModel.coordinator.showHotels()
                .tabItem {
                    Image(.hotels).renderingMode(.template)
                    Text("Отели")
                        .font(.custom("SFProDisplay-Regular", size: 10))
                }
                .tag(MenuItem.hotels)
            
            viewModel.coordinator.showShortcuts()
                .tabItem {
                    Image(.geoPoint).renderingMode(.template)
                    Text("Короче")
                        .font(.custom("SFProDisplay-Regular", size: 10))
                }
                .tag(MenuItem.shortcuts)
            
            viewModel.coordinator.showSubscriptions()
                .tabItem {
                    Image(.notifications).renderingMode(.template)
                    Text("Подписки")
                        .font(.custom("SFProDisplay-Regular", size: 10))
                }
                .tag(MenuItem.subscriptions)
            
            viewModel.coordinator.showProfile()
                .tabItem {
                    Image(.person).renderingMode(.template)
                    Text("Профиль")
                        .font(.custom("SFProDisplay-Regular", size: 10))
                }
                .tag(MenuItem.profile)
        }
    }
}



