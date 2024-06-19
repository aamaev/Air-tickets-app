//
//  MainView.swift
//  AirTickets
//
//  Created by Артём Амаев on 18.06.24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        TabView(selection: $viewModel.selectedMenuItem) {
            TicketsView()
                .tabItem {
                    Image(.tickets)
                    Text("Авиабилеты")
                        .font(.system(size: 10))
                }
                .tag(MenuItem.tickets)
            
            HotelsView()
                .tabItem {
                    Image(.hotels)
                    Text("Отели")
                        .font(.system(size: 10))
                }
                .tag(MenuItem.hotels)
            
            ShortcutsView()
                .tabItem {
                    Image(.geoPoint)
                    Text("Короче")
                        .font(.system(size: 10))
                }
                .tag(MenuItem.shortcuts)
            
            SubscriptionsView()
                .tabItem {
                    Image(.notifications)
                    Text("Подписки")
                        .font(.system(size: 10))
                }
                .tag(MenuItem.subscriptions)
            
            ProfileView()
                .tabItem {
                    Image(.profile)
                    Text("Профиль")
                        .font(.system(size: 10))
                }
                .tag(MenuItem.profile)
        }
    }
}


