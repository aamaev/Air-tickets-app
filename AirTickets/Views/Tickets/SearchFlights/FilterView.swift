//
//  FilterView.swift
//  AirTickets
//
//  Created by Артём Амаев on 20.06.24.
//

import SwiftUI

struct FilterView: View {
    @Binding var arrivalDate: Date?
    @Binding var departureDate: Date

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                Button(action: {
                    // action
                }) {
                    if let arrivalDate = arrivalDate {
                        Text(dateFormatter.string(from: arrivalDate))
                            .font(.custom("SFProDisplay-MediumItalic", size: 14))
                            .padding(12)
                            .background(Color.gray1)
                            .cornerRadius(50)
                            .foregroundColor(.white)
                    } else {
                        HStack {
                            Image(systemName: "plus")
                            Text("обратно")
                                .font(.custom("SFProDisplay-MediumItalic", size: 14))
                        }
                        .padding(12)
                        .background(Color.gray1)
                        .foregroundColor(.white)
                        .cornerRadius(50)
                    }
                }
                .overlay(
                    DatePicker("", selection: Binding($arrivalDate, defaultValue: Date()), displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.clear)
                        .blur(radius: 1000)
                )
                                                
                Button(action: {
                    // action
                }) {
                    Text(dateFormatter.string(from: departureDate))
                        .font(.custom("SFProDisplay-MediumItalic", size: 14))
                        .padding(12)
                        .background(Color.gray1)
                        .cornerRadius(50)
                        .foregroundColor(.white)
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
                    // action
                }) {
                    HStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 10, height: 10)
                        Text("1,эконом")
                            .font(.custom("SFProDisplay-MediumItalic", size: 14))
                    }
                    .padding(10)
                    .background(Color.gray1)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                }
                
                Button(action: {
                    // action
                }) {
                    HStack {
                        Image(.settings)
                        Text("фильтры")
                            .font(.custom("SFProDisplay-MediumItalic", size: 14))
                    }
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

