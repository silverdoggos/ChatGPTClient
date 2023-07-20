//
//  ItemsWrapper.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 28.03.2023.
//

import Foundation

struct ItemsWrapper<T: Decodable>: Decodable {
    let items: [T]
}
