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
                                .onChange(of: departure) { oldValue, newValue in
                                    UserDefaults.standard.set(newValue, forKey: "departure")
                                }
                                .foregroundColor(.white)
                                .frame(height: 21)
                        }
                        
                        Divider()
                        
                        HStack {
                            Image(.search)
                            TextField("Куда - Турция", text: $destination, onCommit: {
                                if !destination.isEmpty {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            })
                            .onChange(of: destination) { oldValue, newValue in
                                UserDefaults.standard.set(newValue, forKey: "destination")
                            }
                            .foregroundColor(.white)
                            .frame(height: 21)
                            Button(action: {
                                if !destination.isEmpty {
                                    destination = ""
                                    UserDefaults.standard.set(destination, forKey: "destination")
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
                        destination = "Куда угодно"
                    })
                    Tip(image: .calendar, bgColor: Color.blue2, cardText: "Выходные", action: {
                        presentationMode.wrappedValue.dismiss()
                    })
                    Tip(image: .fire, bgColor: .red1, cardText: "Горячие\nбилеты", action: {
                        presentationMode.wrappedValue.dismiss()
                    })
                }

                VStack {
                    CityTip(image: .istanbul, cityName: "Стамбул", action: { destination = "Стамбул" })
                    CityTip(image: .sochi, cityName: "Сочи", action: { destination = "Сочи" })
                    CityTip(image: .phuket, cityName: "Пхукет", action: { destination = "Пхукет" })
                }
                .background(Color.gray1)
                .cornerRadius(16)
                .padding(16)

                Spacer()
            }
            .padding(.bottom, keyboardResponder.currentHeight)
            .background(Color.gray0)
            .edgesIgnoringSafeArea(.bottom)
            .animation(.easeOut(duration: 0.16), value: keyboardResponder.currentHeight)
        }
    }
}

struct Tip: View {
    let image: UIImage
    let bgColor: Color
    let cardText: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(bgColor)
                    .frame(width: 48, height: 48)
                    .overlay(
                        Image(uiImage: image)
                            .foregroundColor(.white)
                    )
                    .padding(.bottom, 8)
                
                Text(cardText)
                    .font(.caption)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(width: 80)
            }
        }
    }
}

struct CityTip: View {
    let image: UIImage
    let cityName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                HStack {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                    VStack(alignment: .leading) {
                        Text(cityName)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.bottom, 4)
                        Text("Популярное направление")
                            .font(.subheadline)
                            .foregroundColor(Color.gray5)
                    }
                    Spacer()
                }
                .padding(.top, 24)
                .padding(.bottom, 16)
                .padding(.horizontal, 16)
                .background(Color.gray1)
                .cornerRadius(8)
                
                Divider()
            }
        }
    }
}
