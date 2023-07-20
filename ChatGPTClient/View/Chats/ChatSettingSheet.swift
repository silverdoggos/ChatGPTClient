//
//  ChatSettingSheet.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 30.03.2023.
//

import SwiftUI

struct ChatSettingSheet: View {
    var viewModel = ChatSettingViewModel()
    @State var requestTimeout: Int
    @State var temperatureLevel: Double
    
    init() {
        requestTimeout = viewModel.requestTimeout 
        temperatureLevel = viewModel.temperatureLevel
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Settings will applied to all your next requsts until you change them.")
                .font(.system(size: 14, weight: .regular))
                .frame(alignment: .center)
                .foregroundColor(Color(.systemGray3))
            
            Stepper(value: $temperatureLevel, in: 0...20) {
                HStack(spacing: 10) {
                    Text("Temparature level:")
                        .font(.system(size: 16, weight: .semibold))
                    Text("\(Int(temperatureLevel))")
                        .font(.system(size: 16, weight: .semibold))
                }
            }
            .frame(height: 50)
            
            Divider()
            
            Stepper(value: $requestTimeout, in: 20...180, step: 10) {
                HStack(spacing: 10) {
                    Text("Maximum response time:")
                        .font(.system(size: 16, weight: .semibold))
                    Text("\(requestTimeout)")
                        .font(.system(size: 16, weight: .semibold))
                }
            }
            .frame(height: 50)
            
            Spacer()
        }
        .onDisappear {
            viewModel.temperatureLevel = temperatureLevel
            viewModel.requestTimeout = requestTimeout
        }
        .padding()
    }
}
