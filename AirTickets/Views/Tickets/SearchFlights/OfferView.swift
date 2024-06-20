//
//  OfferView.swift
//  AirTickets
//
//  Created by Артём Амаев on 18.06.24.
//

import SwiftUI

struct OfferView: View {
    let title: String
    let location: String
    let price: String
    let imageName: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 133, height: 133)
                .cornerRadius(16)
                .padding(.bottom, 8)
            
            Text(title)
                .font(.custom("SFProDisplay-Semibold", size: 16))
                .foregroundColor(.white)
                .padding(.bottom, 8)
            
            Text(location)
                .font(.custom("SFProDisplay-Regular", size: 14))
                .foregroundColor(.white)
                .padding(.bottom, 4)
            
            HStack {
                Image(.airplane)
                    .foregroundColor(.gray6)
                Text(price)
                    .font(.custom("SFProDisplay-Regular", size: 14))
                    .foregroundColor(.white)
            }
        }
        .frame(width: 150)
    }
}
