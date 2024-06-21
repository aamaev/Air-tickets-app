//
//  TicketView.swift
//  AirTickets
//
//  Created by Артём Амаев on 20.06.24.
//

import SwiftUI

struct TicketView: View {
    let ticket: Ticket
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading) {
                Text("\(ticket.price.value) ₽")
                    .font(.custom("SFProDisplay-Semibold", size: 22))
                    .padding(.horizontal, 16)
                    .padding(.bottom, 4)
                    .padding(.top, 20)
                
                HStack {
                    Circle()
                        .fill(Color.red1)
                        .frame(width: 24, height: 24)
                    
                    VStack {
                        HStack {
                            Text(formattedDate(ticket.departure.date))
                                .font(.custom("SFProDisplay-MediumItalic", size: 14))
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                            Text("-")
                                .foregroundColor(Color.gray6)
                            Text(formattedDate(ticket.arrival.date))
                                .font(.custom("SFProDisplay-MediumItalic", size: 14))
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                        }
                        HStack {
                            Text(ticket.departure.airport)
                                .font(.custom("SFProDisplay-MediumItalic", size: 14))
                                .foregroundColor(Color.gray6)
                            
                            Text("  ")
                            
                            Text(ticket.arrival.airport)
                                .font(.custom("SFProDisplay-MediumItalic", size: 14))
                                .foregroundColor(Color.gray6)
                        }
                    }
                    
                    HStack(alignment: .center) {
                        Text(flightDuration(departure: ticket.departure.date, arrival: ticket.arrival.date))
                            .font(.custom("SFProDisplay-Semibold", size: 14))
                            .foregroundColor(.white)
                        if !ticket.hasTransfer {
                            Text("/")
                                .foregroundColor(Color.gray6)
                            Text("Без пересадок")
                                .font(.custom("SFProDisplay-Semibold", size: 14))
                                .foregroundColor(.white)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    .padding(.top, 8)
                }
                .padding(.leading, 16)
                .padding(.bottom, 16)
                .padding(.top, 4)
                
            }
            .background(Color.gray2)
            .cornerRadius(8)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            if let badge = ticket.badge {
                Text(badge)
                    .font(.custom("SFProDisplay-Semibold", size: 14))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .foregroundColor(.white)
                    .background(Color.blue1)
                    .cornerRadius(50)
                    .offset(y: -3)
                    .padding(.leading, 16)
                    .padding(.top, 5)
            }
        }
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
