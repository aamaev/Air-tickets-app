//
//  ContentView.swift
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
                    Image(.airplane).renderingMode(.template)
                    Text("Авиабилеты")
                        .font(.system(size: 10))
                }
                .tag(MenuItem.tickets)
            
            HotelsView()
                .tabItem {
                    Image(.hotels).renderingMode(.template)
                    Text("Отели")
                        .font(.system(size: 10))
                }
                .tag(MenuItem.hotels)
            
            ShortcutsView()
                .tabItem {
                    Image(.geoPoint).renderingMode(.template)
                    Text("Короче")
                        .font(.system(size: 10))
                }
                .tag(MenuItem.shortcuts)
            
            SubscriptionsView()
                .tabItem {
                    Image(.notifications).renderingMode(.template)
                    Text("Подписки")
                        .font(.system(size: 10))
                }
                .tag(MenuItem.subscriptions)
            
            ProfileView()
                .tabItem {
                    Image(.person).renderingMode(.template)
                    Text("Профиль")
                        .font(.system(size: 10))
                }
                .tag(MenuItem.profile)
        }
    }
}

