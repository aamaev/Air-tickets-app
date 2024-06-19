//
//  SearchModalView.swift
//  AirTickets
//
//  Created by Артём Амаев on 18.06.24.
//

import Foundation
import SwiftUI

struct SearchModalView: View {
    @Binding var departure: String
    @Binding var destination: String
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
            VStack {
                Capsule()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 40, height: 5)
                    .padding(.top, 8)
                
                VStack(spacing: 16) {
                    TextField("Откуда - Минск", text: $departure)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .disabled(true)
                    
                    TextField("Куда - Турция", text: $destination)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .keyboardType(.default)
                        .disableAutocorrection(true)
                        .overlay(
                            Button(action: {
                                destination = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                            .padding(.trailing, 8),
                            alignment: .trailing
                        )
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                
                HStack {
//                    OptionButton(icon: "command", title: "Сложный\nмаршрут")
//                    OptionButton(icon: "globe", title: "Куда\nугодно")
//                    OptionButton(icon: "calendar", title: "Выходные")
//                    OptionButton(icon: "flame", title: "Горячие\nбилеты")
                }
                .padding(.top, 24)
                
                List {
//                    DestinationRow(imageName: "istanbul", title: "Стамбул", subtitle: "Популярное направление")
//                    DestinationRow(imageName: "sochi", title: "Сочи", subtitle: "Популярное направление")
//                    DestinationRow(imageName: "phuket", title: "Пхукет", subtitle: "Популярное направление")
                }
                .listStyle(PlainListStyle())
            }
            .background(.grаy1)
        }
}
