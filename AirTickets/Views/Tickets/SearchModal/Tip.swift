//
//  Tip.swift
//  AirTickets
//
//  Created by Артём Амаев on 20.06.24.
//

import SwiftUI

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
                    .font(.custom("SFProDisplay-Regular", size: 14))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(width: 80)
            }
        }
    }
}
