//
//  Color.ext.swift
//  AirTickets
//
//  Created by Артём Амаев on 19.06.24.
//

import SwiftUI

extension Color {
    static let gray0 = Color(hex: "242529")
    static let gray1 = Color(hex: "2F3035")
    static let gray2 = Color(hex: "1D1E20")
    static let gray4 = Color(hex: "3E3F43")
    static let gray5 = Color(hex: "5E5F61")
    static let gray6 = Color(hex: "9F9F9F")
    static let red1 = Color(hex: "FF5E5E")
    static let green1 = Color(hex: "3A633B")
    static let black1 = Color(hex: "0C0C0C")
    static let blue1 = Color(hex: "2261BC")
    static let blue2 = Color(hex: "00427D")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
