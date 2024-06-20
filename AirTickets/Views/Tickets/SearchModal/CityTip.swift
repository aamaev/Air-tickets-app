//
//  CityTip.swift
//  AirTickets
//
//  Created by Артём Амаев on 20.06.24.
//

import SwiftUI

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
                            .font(.custom("SFProDisplay-Semibold", size: 16))
                            .foregroundColor(.white)
                            .padding(.bottom, 4)
                        Text("Популярное направление")
                            .font(.custom("SFProDisplay-Regular", size: 14))
                            .foregroundColor(Color.gray5)
                    }
                    Spacer()
                }
                .padding(.top, 16)
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
                .background(Color.gray1)
                .cornerRadius(8)
                
                Divider()
                    .background(Color.gray4)
                    .padding(.horizontal, 16)
            }
        }
    }
}
