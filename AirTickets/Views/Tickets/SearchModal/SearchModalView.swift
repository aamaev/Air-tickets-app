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
    @Binding var arrival: String
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var keyboardResponder = KeyboardResponder()

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 26) {
                Capsule()
                    .fill(Color.gray5)
                    .frame(width: 40, height: 5)
                    .padding(.top, 16)

                VStack {
                    VStack {
                        HStack {
                            Image(.airplane2)
                            TextField("Откуда - Минск", text: $departure)
                                .font(.custom("SFProDisplay-Semibold", size: 16))
                                .onChange(of: departure) { oldValue, newValue in
                                    UserDefaults.standard.set(newValue, forKey: "departure")
                                }
                                .foregroundColor(.white)
                                .frame(height: 21)
                        }
                        
                        Divider()
                        
                        HStack {
                            Button {
                                if !arrival.isEmpty {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            } label: {
                                Image(.search)
                            }

                            TextField("Куда - Турция", text: $arrival, onCommit: {
                                if !arrival.isEmpty {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            })
                            .font(.custom("SFProDisplay-Semibold", size: 16))
                            .onChange(of: arrival) { oldValue, newValue in
                                UserDefaults.standard.set(newValue, forKey: "arrival")
                            }
                            .foregroundColor(.white)
                            .frame(height: 21)
                            Button(action: {
                                if !arrival.isEmpty {
                                    arrival = ""
                                    UserDefaults.standard.set(arrival, forKey: "arrival")
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

                HStack(alignment: .top, spacing: 16) {
                    Tip(image: .command, bgColor: Color.green1, cardText: "Сложный\nмаршрут", action: { presentationMode.wrappedValue.dismiss() })
                    Tip(image: .planet, bgColor: Color.blue1, cardText: "Куда угодно", action: {
                        arrival = "Куда угодно"
                    })
                    Tip(image: .calendar, bgColor: Color.blue2, cardText: "Выходные", action: {
                        presentationMode.wrappedValue.dismiss()
                    })
                    Tip(image: .fire, bgColor: .red1, cardText: "Горячие\nбилеты", action: {
                        presentationMode.wrappedValue.dismiss()
                    })
                }

                VStack {
                    CityTip(image: .istanbul, cityName: "Стамбул", action: { arrival = "Стамбул" })
                    CityTip(image: .sochi, cityName: "Сочи", action: { arrival = "Сочи" })
                    CityTip(image: .phuket, cityName: "Пхукет", action: { arrival = "Пхукет" })
                }
                .background(Color.gray1)
                .cornerRadius(16)
                .padding(.top, 8)
                .padding(.horizontal, 16)

                Spacer()
            }
            .padding(.bottom, keyboardResponder.currentHeight)
            .background(Color.gray0)
            .edgesIgnoringSafeArea(.bottom)
            .animation(.easeOut(duration: 0.16), value: keyboardResponder.currentHeight)
        }
    }
}

