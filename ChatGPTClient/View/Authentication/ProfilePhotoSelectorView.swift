////
////  ProfilePhotoSelectorView.swift
////  ChatGPTClient
////
////  Created by Artem Shishkin on 25.03.2023.
////
//
//import SwiftUI
//
//struct ProfilePhotoSelectorView: View {
//    @State private var showImagePicker = false
//    @State private var selectedImage: UIImage?
//    @State private var profileImage: Image?
////    @EnvironmentObject var viewModel: AuthViewModel
//    
//    var body: some View {
//        NavigationStack {
//            VStack{
//                Button(action: {
//                    showImagePicker.toggle()
//                }, label: {
//                    if let image = profileImage {
//                        image
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 180, height: 180)
//                            .clipShape(Circle())
//                            .padding(.vertical, 44)
//                    } else {
//                        Image(systemName: "plus.circle")
//                            .resizable()
//                            .renderingMode(.template)
//                            .scaledToFill()
//                            .frame(width: 180, height: 180)
//                            .clipped()
//                            .padding(.vertical, 44)
//                            .foregroundColor(.black)
//                            .fontWeight(.thin)
//                    }
//                })
//                .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
//                    ImagePicker(image: $selectedImage)
//                }
//                
//                Text(profileImage == nil ? "Select a profile photo" : "Great! Tap below to continue")
//                    .font(.system(size: 20, weight: .semibold))
//                
//                Button(action: {
//                    if let image = selectedImage {
//                        viewModel.uploadProfileImage(image)
//                    } else {
//                        viewModel.skipUploadPhoto()
//                    }
//                }, label: {
//                    Text("Continue")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .frame(width: 340, height: 50)
//                        .background(.blue)
//                        .clipShape(Capsule())
//                        .padding()
//                })
//                .shadow(color: .gray, radius: 10)
//                .padding(.top, 24)
//                
//                Spacer()
//            }
//            .navigationBarBackButtonHidden(true)
//        }
//    }
//    
//    private func loadImage() {
//        guard let image = selectedImage else { return }
//        profileImage = Image(uiImage: image)
//    }
//}
