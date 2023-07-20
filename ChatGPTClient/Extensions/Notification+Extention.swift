//
//  Notification+Extantion.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 01.04.2023.
//

import SwiftUI

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}
