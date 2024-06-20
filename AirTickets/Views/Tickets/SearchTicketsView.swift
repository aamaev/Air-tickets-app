//
//  SearchTicketsView.swift
//  AirTickets
//
//  Created by Артём Амаев on 19.06.24.
//

import Foundation
import SwiftUI

struct SearchTicketsView: View {
    @ObservedObject var viewModel = SearchTicketsViewModel()
    
    @Binding var departure: String
    @Binding var destination: String
    
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    HStack {
                        Image(.airplane2)
                        TextField("Откуда - Минск", text: $departure)
                            .foregroundColor(.white)
                            .frame(height: 21)
                        Button {
                            if !destination.isEmpty && !departure.isEmpty {
                                (departure, destination) = (destination, departure)
                            }
                        } label: {
                            Image(.change)
                        }

                    }
                    
                    Divider()
                    
                    HStack {
                        Image(.search)
                        TextField("Куда - Турция", text: $destination)
                            .foregroundColor(.white)
                            .frame(height: 21)
                        Button(action: {
                            if !destination.isEmpty {
                                destination = ""
                            }
                        }) {
                            Image(.close)
                        }
                    }
                }
                .padding(16)
            }
            .background(Color.gray1)
            .cornerRadius(16)
            .padding(.horizontal, 16)
            .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 5)
        }
        
        List {
            
        }
        
        VStack {
            Text("Прямые рельсы")
                .font(.title)
            
            NavigationStack {
                
            }
        }
        
    }
}



