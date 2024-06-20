//
//  Binding.ext.swift
//  AirTickets
//
//  Created by Артём Амаев on 20.06.24.
//

import SwiftUI

extension Binding {
    init(_ source: Binding<Value?>, defaultValue: Value) {
        self.init(
            get: { source.wrappedValue ?? defaultValue },
            set: { newValue in source.wrappedValue = newValue }
        )
    }
}
