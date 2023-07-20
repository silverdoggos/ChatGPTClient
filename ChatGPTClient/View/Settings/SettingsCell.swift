//
//  SettingsCell.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 22.03.2023.
//

import SwiftUI

struct SettingsCell: View {
    let viewModel: SettingsCellViewModel
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: viewModel.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)
                    .padding(6)
                    .background( viewModel.imageBackgroundColor)
                    .foregroundColor(.white)
                    .cornerRadius(6)
                
                Text(viewModel.titile)
                    .font(.system(size: 15))
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding([.top, .horizontal])
            
            Divider()
                .padding(.leading )
        }
        .background(.white)
    }
}
