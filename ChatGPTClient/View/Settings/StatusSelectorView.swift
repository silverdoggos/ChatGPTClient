//
//  StatusSelectionView.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 23.03.2023.
//

import SwiftUI

struct StatusSelectorView: View {
    @ObservedObject var viewModel: StatusViewModel = StatusViewModel()
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text("CURRENTLY SET TO")
                        .foregroundColor(.gray)
                        .padding()
                    
                    UserStatusCell(status: viewModel.status)
                    
                    Text("SELECT YOUR STATUS")
                        .foregroundColor(.gray)
                        .padding()

                    VStack(spacing: 0) {
                        ForEach(UserStatus.allCases.filter({ $0 != .notConfigured}), id: \.self) { status in
                            Button(action: {
                                viewModel.updateStatus(status)
                            }, label: {
                                VStack(spacing: 0) {
                                    UserStatusCell(status: status)
                                    
                                    Divider()
                                        .foregroundColor(.gray)
                                        .padding(.leading)
                                }
                            })
                        }
                    }
                }
            }
        }
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct StatusSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        StatusSelectorView()
    }
}
