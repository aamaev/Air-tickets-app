//
//  TicketDetailView.swift
//  AirTickets
//
//  Created by Артём Амаев on 20.06.24.
//

import Foundation
import SwiftUI

struct DetailedTicketView: View {
    let ticket: TicketOffer
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.left")
                    .padding()
                    .onTapGesture {
                        // Action to go back
                    }
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Москва-Сочи")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("23 февраля, 1 пассажир")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()
            
            ScrollView {
                ForEach(ticket.timeRange, id: \.self) { time in
                    VStack(alignment: .leading) {
                        HStack {
                            Circle()
                                .fill(ticketIconColor(ticket))
                                .frame(width: 10, height: 10)
                            Text(ticket.title)
                                .foregroundColor(.white)
                            Spacer()
                            Text("\(ticket.price.value.formattedWithSeparator) ₽")
                                .foregroundColor(.blue)
                            Image(systemName: "chevron.right")
                                .foregroundColor(.blue)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        
                        Text(ticket.timeRange.joined(separator: " "))
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 8)
                        
                        Divider()
                            .background(Color.white)
                    }
                    .background(Color.gray1)
                    .cornerRadius(16)
                    .padding(16)
                }
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    // Action for filter button
                }) {
                    Text("Фильтр")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(16)
                }
                .padding(.horizontal, 16)
                
                Button(action: {
                    // Action for chart button
                }) {
                    Text("График цен")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(16)
                }
                .padding(.horizontal, 16)
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
    
    private func ticketIconColor(_ ticket: TicketOffer) -> Color {
        switch ticket.title {
        case "Уральские авиалинии":
            return .red
        case "Победа":
            return .blue
        default:
            return .white
        }
    }
}

extension Int {
    var formattedWithSeparator: String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
    

