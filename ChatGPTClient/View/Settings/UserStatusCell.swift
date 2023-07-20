//
//  StatusCell.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 23.03.2023.
//

import SwiftUI

struct UserStatusCell: View {
    let status: UserStatus
    
    var body: some View {
        HStack {
            Text(status.title )
                .foregroundColor(.black)
            
            Spacer()
        }
        .frame(height: 56)
        .padding(.horizontal)
        .background(.white)
    }
}
