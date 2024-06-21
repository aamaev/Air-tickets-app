//
//  FlightListView.swift
//  AirTickets
//
//  Created by Артём Амаев on 20.06.24.
//

import Foundation
import SwiftUI

struct FlightListView: View {
    let flightInfo: FlightInfo
    @ObservedObject var viewModel = FlightListViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                
                ScrollView {
                    ForEach(viewModel.ticketsList) { ticket in
                        TicketView(ticket: ticket)
                    }
                }
                .padding(.top, 65)
                
                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                            //action
                        }) {
                            HStack(spacing: 5) {
                                HStack {
                                    Image(.settings)
                                    Text("Фильтр")
                                        .foregroundColor(.white)
                                        .font(.custom("SFProDisplay-Semibold", size: 14))
                                }
                                .padding(.trailing, 8)
                                HStack {
                                    Image(.chart)
                                    Text("График цен")
                                        .foregroundColor(.white)
                                        .font(.custom("SFProDisplay-MediumItalic", size: 14))
                                }
                            }
                            .padding()
                            .background(Color.blue1)
                            .cornerRadius(25)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
                    .background(.clear)
                }
                
                VStack {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .renderingMode(.template)
                                .foregroundColor(.blue)
                        }
                        .padding(.trailing, 5)
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(flightInfo.departure)-\(flightInfo.arrival)")
                                .font(.custom("SFProDisplay-Semibold", size: 16))
                                .foregroundColor(.white)
                            Text("\(formatDate(flightInfo.departureDate)), 1 пассажир")
                                .font(.custom("SFProDisplay-Semibold", size: 14))
                                .foregroundColor(Color.gray6)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .background(Color.gray0)
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
            }
        }

        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button(action: {
//                    presentationMode.wrappedValue.dismiss()
//                }) {
//                    Image(.back)
//                        .renderingMode(.template)
//                        .foregroundColor(.blue)
//                }
//            }
//            ToolbarItem(placement: .topBarLeading) {
//                VStack(spacing: 4) {
//                    Text("\(flightInfo.departure)-\(flightInfo.arrival)")
//                        .font(.custom("SFProDisplay-Semibold", size: 16))
//                        .foregroundColor(.white)
//                    
//                    Text("\(formatDate(flightInfo.departureDate)), 1 пассажир")
//                        .font(.custom("SFProDisplay-Semibold", size: 14))
//                        .foregroundColor(Color.gray6)
//                        .padding(.leading, 6)
//                }
//            }
//        }
        .padding(.top, 10)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM"
        return formatter.string(from: date)
    }
}
