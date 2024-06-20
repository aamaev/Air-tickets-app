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
    @ObservedObject var viewModel = TicketsViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(flightInfo.departure)-\(flightInfo.arrival)")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.top, 8)
                
                Text("23 февраля, 1 пассажир")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .padding(.bottom, 16)
                
//                ScrollView {
//                    ForEach($viewModel.tickets) { ticket in
//                        TicketView(ticket: ticket)
//                    }
//                }
//                .padding(.horizontal, 16)
                
                Spacer()
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .onAppear {
                //viewModel.loadTickets()
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}

struct TicketView: View {
    let ticket: Ticket
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let badge = ticket.badge {
                Text(badge)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.blue)
                    .padding(.top, 8)
            }
            
            Text("\(ticket.price.value) ₽")
                .font(.system(size: 24, weight: .bold))
            
            HStack {
                Circle()
                    .fill(Color.red)
                    .frame(width: 8, height: 8)
                
                Text("\(formattedDate(ticket.departure.date)) — \(formattedDate(ticket.arrival.date))")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("\(ticket.departure.airport) — \(ticket.arrival.airport)")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
            }
            
            Text("В пути \(flightDuration(departure: ticket.departure.date, arrival: ticket.arrival.date)) / \(ticket.hasTransfer ? "" : "Без пересадок")")
                .font(.system(size: 14))
                .foregroundColor(.white)
            
            Divider()
                .background(Color.white)
                .padding(.vertical, 8)
        }
        .padding()
        .background(Color.gray)
        .cornerRadius(8)
    }
    
    private func formattedDate(_ dateStr: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = formatter.date(from: dateStr) else { return "" }
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    private func flightDuration(departure: String, arrival: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let departureDate = formatter.date(from: departure), let arrivalDate = formatter.date(from: arrival) else { return "" }
        let duration = arrivalDate.timeIntervalSince(departureDate)
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        return "\(hours)ч \(minutes)м"
    }
}
