//
//  KeyboardResponder.swift
//  AirTickets
//
//  Created by Артём Амаев on 20.06.24.
//

import Foundation
import SwiftUI
import Combine

final class KeyboardResponder: ObservableObject {
    @Published var currentHeight: CGFloat = 0
    var keyboardHeight: AnyCancellable?

    init() {
        keyboardHeight = NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
            .compactMap { notification in
                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            }
            .map { rect in
                rect.height
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] height in
                self?.currentHeight = height
            }
    }

    deinit {
        keyboardHeight?.cancel()
    }
}
