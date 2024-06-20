//
//  SearchFlightsView.swift
//  AirTickets
//
//  Created by Артём Амаев on 18.06.24.
//
import SwiftUI

struct SearchFlightsView: View {
    @ObservedObject private var viewModel = TicketsViewModel()
    
    @State private var departure: String = UserDefaults.standard.string(forKey: "departure") ?? ""
    @State private var arrival: String = UserDefaults.standard.string(forKey: "arrival") ?? ""
    @State private var showingSearchModal: Bool = false
    @State private var departureDate: Date = Date.now
    @State private var arrivalDate: Date? = nil
    @State private var showPicker = true
        
    var body: some View {
        NavigationView {
            VStack {
                if !departure.isEmpty && !arrival.isEmpty {
                    completedSearchFields
                } else {
                    emptySearchFields
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $showingSearchModal) {
                SearchModalView(departure: $departure, arrival: $arrival)
            }
            .navigationBarHidden(true)
        }
    }
    
    var emptySearchFields: some View {
        VStack {
            Text("Поиск дешевых\nавиабилетов")
                .font(.custom("SFProDisplay-Semibold", size: 22))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.top, 26)
                .padding(.bottom, 38)

            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray1)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                    .frame(height: 122)

                HStack(spacing: 16) {
                    Image(.search)
                        .padding(.leading, 16)
                    
                    VStack {
                        TextField("Откуда - Москва", text: $departure)
                            .font(.custom("SFProDisplay-Semibold", size: 16))
                            .onChange(of: departure) { oldValue, newValue in
                                UserDefaults.standard.set(newValue, forKey: "departure")
                            }
                            .frame(height: 21)
                           
                        Divider()
                            .background(.white)
                            .padding(.trailing, 15)
                        
                        TextField("Куда - Турция", text: $arrival)
                            .font(.custom("SFProDisplay-Semibold", size: 16))
                            .onChange(of: arrival) { oldValue, newValue in
                                UserDefaults.standard.set(newValue, forKey: "arrival")
                            }
                            .frame(height: 21)
                            .onTapGesture {
                                showingSearchModal.toggle()
                            }
                    }
                    .padding(.vertical, 16)
                }
                .background(Color.gray4)
                .cornerRadius(16)
                .frame(height: 90)
                .padding(16)
            }
            .padding(.horizontal, 16)
            
            VStack(alignment: .leading) {
                Text("Музыкально отлететь")
                    .font(.custom("SFProDisplay-Semibold", size: 22))
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
            SearchModalView(departure: $departure, arrival: $arrival)
        }
    }
    
    var completedSearchFields: some View {
        VStack {
            HStack {
                Image(.back)
                    .padding(.leading, 16)
                
                VStack {
                    HStack {
                        TextField("Откуда - Москва", text: $departure)
                            .font(.custom("SFProDisplay-Semibold", size: 16))
                            .foregroundColor(.white)
                            .frame(height: 21)
                        Button {
                            if !arrival.isEmpty && !departure.isEmpty {
                                (departure, arrival) = (arrival, departure)
                                UserDefaults.standard.set(arrival, forKey: "arrival")
                                UserDefaults.standard.set(departure, forKey: "departure")
                            }
                        } label: {
                            Image(.change)
                        }
                    }
                    
                    Divider()
                    
                    HStack {
                        TextField("Куда - Турция", text: $arrival)
                            .font(.custom("SFProDisplay-Semibold", size: 16))
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
                .padding(.trailing, 16)
                .padding(.vertical, 16)
            }
            .background(Color.gray1)
            .cornerRadius(16)
            .padding(16)
            
            FilterView(arrivalDate: $arrivalDate, departureDate: $departureDate)
            
            ticketOffersView
            
            NavigationLink(destination: FlightListView(flightInfo: FlightInfo(departure: departure,
                                                                              arrival: arrival,
                                                                              departureDate: departureDate,
                                                                              arrivalDate: arrivalDate))) {
               Text("Посмотреть все билеты")
                   .font(.system(size: 16, weight: .regular))
                   .foregroundColor(.white)
                   .padding()
                   .frame(maxWidth: .infinity)
                   .background(Color.blue1)
                   .cornerRadius(8)
                   .padding(.horizontal, 16)
            }
                 
            Spacer()
        }
        .onAppear {
            if !departure.isEmpty && !arrival.isEmpty {
                viewModel.loadTicketsOffers()
            }
        }
    }
    
    var ticketOffersView: some View {
        VStack(alignment: .leading) {
            Text("Прямые рельсы")
                .font(.custom("SFProDisplay-Semibold", size: 20))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 8)
            
            ForEach(viewModel.ticketsOffers.prefix(3)) { offer in
                TicketOfferView(ticket: offer)
            }
        }
        .background(Color.gray1)
        .cornerRadius(16)
        .padding(16)
    }
}

#Preview {
    SearchFlightsView()
}
