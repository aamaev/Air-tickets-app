//
//  TicketsView.swift
//  AirTickets
//
//  Created by Артём Амаев on 18.06.24.
//

import SwiftUI

struct TicketsView: View {
    @ObservedObject var viewModel = TicketsViewModel()
    
    @State private var departure: String = UserDefaults.standard.string(forKey: "departure") ?? ""
    @State private var destination: String = UserDefaults.standard.string(forKey: "destination") ?? ""
    @State private var showingSearchModal = false
    
    var body: some View {
        VStack {
            Text("Поиск дешевых\nавиабилетов")
                .font(.custom("SFProDisplay-Bold", size: 24))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.top, 26)
                .padding(.bottom, 38)

            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.grаy1)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                    .frame(height: 122)

                HStack(spacing: 16) {
                    Image(.search)
                        .padding(.leading, 16)
                    
                    VStack {
                        TextField("Откуда - Москва", text: $departure)
                            .onChange(of: departure) { oldValue, newValue in
                                UserDefaults.standard.set(newValue, forKey: "departure")
                            }
                            .frame(height: 21)
                           
                        Divider()
                        
                        TextField("Куда - Турция", text: $destination)
                            .onChange(of: departure) { oldValue, newValue in
                                UserDefaults.standard.set(newValue, forKey: "destination")
                            }
                            .frame(height: 21)
                            .onTapGesture {
                                showingSearchModal.toggle()
                            }
                    }
                    .padding(.vertical, 16)
                }
                .background(.grаy4)
                .cornerRadius(16)
                .frame(height: 90)
                .padding(16)
            }
            .padding(.horizontal, 16)
            
            VStack(alignment: .leading) {
                Text("Музыкально отлететь")
                    .font(.custom("SFProDisplay-Bold", size: 22))
                    .padding(.top, 33)
                    .padding(.bottom, 25)
                    .padding(.horizontal, 16)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 67) {
                        ForEach(viewModel.offers) { offer in
                            OfferView(
                                title: offer.title,
                                location: offer.town,
                                price: "от \(offer.price.value) ₽",
                                imageName: "\(offer.id)"
                            )
                        }
                    }
                }
                .padding(.leading, 8)
            }
            Spacer()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .sheet(isPresented: $showingSearchModal) {
            SearchModalView(departure: $departure, destination: $destination)
        }
    }
    
}

#Preview {
    TicketsView()
}
