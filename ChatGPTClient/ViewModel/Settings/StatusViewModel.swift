//
//  StatusCellViewModel.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 23.03.2023.
//

import Foundation

enum UserStatus: Int, CaseIterable {
    case notConfigured
    case available
    case busv
    case school
    case movies
    case work
    case batteryLow
    case meeting
    case gym
    case sleeping
    case urgentCallsOnly
    
    var title: String {
        switch self {
            
        case .notConfigured:
            return "Click here to update your status"
        case .available:
             return "Available"
        case .busv:
            return "Busv"
        case .school:
            return "At school"
        case .movies:
            return "At movies"
        case .work:
            return "At work"
        case .batteryLow:
            return "Battery about to die"
        case .meeting:
            return "I a meeting"
        case .gym:
            return "At the gym"
        case .sleeping:
            return "Sleeping"
        case .urgentCallsOnly:
            return "Urgent calls only"
        }
    }
}

class StatusViewModel: ObservableObject {
    @Published var status: UserStatus = .notConfigured
    
    func updateStatus(_ status: UserStatus) {
        self.status = status
    }
}
