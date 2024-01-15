//
//  CoreData+Extansion.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 03.04.2023.
//


import CoreData

extension NSPredicate {
    static var all = NSPredicate(format: "TRUEPREDICATE")
    static var none = NSPredicate(format: "FALSEPREDICATE")
}
