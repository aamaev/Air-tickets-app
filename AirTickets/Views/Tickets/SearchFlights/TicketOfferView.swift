//
//  TicketView.swift
//  AirTickets
//
//  Created by Артём Амаев on 20.06.24.
//

import SwiftUI

struct TicketOfferView: View {
    let ticket: TicketOffer
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Circle()
                    .fill(ticketIconColor(ticket))
                    .frame(width: 24, height: 24)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(ticket.title)
                            .font(.custom("SFProDisplay-MediumItalic", size: 14))
                            .foregroundColor(.white)
                        Spacer()
                        Text("\(ticket.price.value) ₽")
                            .foregroundColor(.blue)
                            .font(.custom("SFProDisplay-MediumItalic", size: 14))
                        Image(systemName: "chevron.right")
                            .foregroundColor(.blue)
                    }
                    
                    Text(ticket.timeRange.joined(separator: " "))
                        .font(.custom("SFProDisplay-Regular", size: 14))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .padding(.top, 2)
                }
            }
            
            Divider()
                .background(Color.white)
                .padding(.bottom, 8)
        }
        .padding(.horizontal, 16)
    }
    
    private func ticketIconColor(_ ticket: TicketOffer) -> Color {
        switch ticket.title {
        case "Уральские авиалинии":
            return Color.red1
        case "Победа":
            return Color.blue1
        default:
            return .white
        }
    }
}
