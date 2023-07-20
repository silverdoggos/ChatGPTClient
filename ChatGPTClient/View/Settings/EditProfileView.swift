//
//  EditProfileView.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 22.03.2023.
//

import SwiftUI

struct EditProfileView: View {
    @State private var fullname: String = ""
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    
    var body: some View {
       
        
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 44) {
                VStack {
                    HStack {
                        VStack {
                            if let profileImage = profileImage {
                                profileImage
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 64, height: 64)
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "person")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 64, height: 64)
                                    .clipShape(Circle())
                            }
                            
                            Button(action: {
                                showImagePicker.toggle()
                            }, label: {
                                Text("Edit")
                            })
                            
                            .sheet(isPresented: $showImagePicker, onDismiss:
                                loadImage) {
                                ImagePicker(image: $selectedImage)
                            }
                        }
                        .padding(.top)
                        
                        Text("Enter your name or change your profile photo")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .padding([.bottom, .horizontal])
                    }
                    
                    Divider()
                        .padding(.horizontal)
                    
                    TextField("Art Shishkin", text: $fullname)
                        .padding(8)
                }
                .background(.white)
                
                VStack(alignment: .leading) {
                    Text("Status")
                        .padding()
                        .foregroundColor(.gray)

                    NavigationLink(destination: StatusSelectorView(),
                                   label: {
                        HStack {
                            Text("At the movies")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(.white)
                    })
                }
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationTitle("Edit Profile")
    }
    
    private func loadImage() {
        guard let selectedImage = selectedImage else { return }
        
        profileImage = Image(uiImage: selectedImage)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
