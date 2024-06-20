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
    @State private var showingSearchModal: Bool = false
    @State private var departureDate: Date = Date.now
    @State private var destinationDate: Date? = nil
    @State private var showPicker = true
    
    var body: some View {
        NavigationView {
            VStack {
                if !departure.isEmpty && !destination.isEmpty {
                    completedSearchFields
                } else {
                    emptySearchFields
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $showingSearchModal) {
                SearchModalView(departure: $departure, destination: $destination)
            }
            .navigationBarHidden(true)
        }
    }
    
    var emptySearchFields: some View {
        VStack {
            Text("Поиск дешевых\nавиабилетов")
                .font(.custom("SFProDisplay-Bold", size: 24))
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
                            .onChange(of: departure) { oldValue, newValue in
                                UserDefaults.standard.set(newValue, forKey: "departure")
                            }
                            .frame(height: 21)
                           
                        Divider()
                            .background(.white)
                            .padding(.trailing, 15)
                        
                        TextField("Куда - Турция", text: $destination)
                            .onChange(of: destination) { oldValue, newValue in
                                UserDefaults.standard.set(newValue, forKey: "destination")
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
    
    var completedSearchFields: some View {
        VStack {
            HStack {
                Image(.back)
                    .padding(.leading, 16)
                
                VStack {
                    HStack {
                        TextField("Откуда - \(departure)", text: $departure)
                            .foregroundColor(.white)
                            .frame(height: 21)
                        Button {
                            if !destination.isEmpty && !departure.isEmpty {
                                (departure, destination) = (destination, departure)
                                UserDefaults.standard.set(destination, forKey: "destination")
                                UserDefaults.standard.set(departure, forKey: "departure")
                            }
                        } label: {
                            Image(.change)
                        }
                    }
                    
                    Divider()
                    
                    HStack {
                        TextField("Куда - \(destination)", text: $destination)
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
                .padding(.trailing, 16)
                .padding(.vertical, 16)
            }
            .background(Color.gray1)
            .cornerRadius(16)
            .padding(16)
            
            filterView
            
            ticketOffersView
            
            Button(action: {
                // Action to view all tickets
            }) {
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
            if !departure.isEmpty && !destination.isEmpty {
                viewModel.loadTicketsOffers()
            }
        }
        
    }
    
    
    var ticketOffersView: some View {
        VStack(alignment: .leading) {
            Text("Прямые рельсы")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 8)
            
            ForEach(viewModel.ticketsOffers.prefix(3)) { offer in
                TicketView(ticket: offer)
            }
        }
        .background(Color.gray1)
        .cornerRadius(16)
        .padding(16)
    }
    
    var filterView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                
                Button(action: {
                    //action
                }) {
                    if destinationDate != nil {
                        Text(dateFormatter.string(from: destinationDate!))
                            .padding(12)
                            .background(Color.gray1)
                            .cornerRadius(50)
                            .foregroundColor(.white)
                            .font(.system(size: 14, design: .default))
                    } else {
                        HStack {
                            Image(systemName: "plus")
                            Text("обратно")
                        }
                        .font(.system(size: 14))
                        .padding(12)
                        .background(Color.gray1)
                        .foregroundColor(.white)
                        .cornerRadius(50)
                    }
                }
                .overlay(
                    DatePicker("", selection: Binding($destinationDate, defaultValue: Date()), displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.clear)
                        .blur(radius: 1000)
                )
                                                
                Button(action: {
                    //action
                }) {
                    Text(dateFormatter.string(from: departureDate))
                        .padding(12)
                        .background(Color.gray1)
                        .cornerRadius(50)
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                }
                .overlay(
                    DatePicker("", selection: $departureDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.clear)
                        .blur(radius: 1000)
                )
                

                Button(action: {
                    //action
                }) {
                    HStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 10, height: 10)
                        Text("1,эконом")
                            .font(.system(size: 14))
                    }
                    .padding(10)
                    .background(Color.gray1)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                }
                
                Button(action: {
                    //action
                }) {
                    HStack {
                        Image(.settings)
                        Text("фильтры")
                    }
                    .font(.system(size: 14))
                    .padding(12)
                    .background(Color.gray1)
                    .foregroundColor(.white)
                    .cornerRadius(50)
                }
                
            }
            .padding(.horizontal)
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "dd MMM, EEE"
        return formatter
    }
    
}

struct TicketView: View {
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
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                        Spacer()
                        Text("\(ticket.price.value) ₽")
                            .foregroundColor(.blue)
                            .font(.system(size: 14))
                        Image(systemName: "chevron.right")
                            .foregroundColor(.blue)
                    }
                    
                    Text(ticket.timeRange.joined(separator: " "))
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .padding(.top, 4)
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



extension Binding {
    init(_ source: Binding<Value?>, defaultValue: Value) {
        self.init(
            get: { source.wrappedValue ?? defaultValue },
            set: { newValue in source.wrappedValue = newValue }
        )
    }
}

#Preview {
    TicketsView()
}
