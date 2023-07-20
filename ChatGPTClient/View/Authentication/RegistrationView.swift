////
////  RegistrationView.swift
////  ChatGPTClient
////
////  Created by Artem Shishkin on 21.03.2023.
////
//
//import SwiftUI
//
//struct RegistrationView: View {
//    @State private var email = ""
//    @State private var password = ""
//    @State private var username = ""
//    @State private var fullName = ""
//    @Environment(\.dismiss) var dissmiss
//    @EnvironmentObject var viewModel: AuthViewModel
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                VStack(alignment: .leading, spacing: 12) {
//                    HStack{ Spacer() }
//                    
//                    Text("Get Started")
//                        .font(.largeTitle)
//                        .bold()
//                    
//                    Text("Create Your Account")
//                        .font(.largeTitle)
//                        .bold()
//                        .foregroundColor(.blue)
//                    
//                    VStack(spacing: 40) {
//                        CustomTextField(imageName: "envelope", placeholderText: "Email", text: $email)
//                        
//                        CustomTextField(imageName: "person", placeholderText: "Username", text: $username)
//                        
//                        CustomTextField(imageName: "person", placeholderText: "Fullname", text: $fullName)
//                        
//                        CustomTextField(imageName: "lock", placeholderText: "Password", text: $password, isSecureField: true)
//                    }
//                    .padding([.top, .horizontal], 32)
//                }
//                .padding(.leading)
//                
//                Button(action: {
//                    viewModel.register(email: email, username: username, fullname: fullName, password: password)
//                }, label: {
//                    Text("Sign Up")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .frame(width: 340, height: 50)
//                        .background(.blue)
//                        .clipShape(Capsule())
//                        .padding()
//                })
//                .shadow(color: .gray, radius: 10)
//                
//                Spacer()
//                
//                Button(action: {
//                    print("here")
//                    dissmiss()
//                },
//                       label: {
//                    HStack {
//                        Text("Already have an account?")
//                            .font(.system(size: 14))
//                        
//                        Text("Sign Ip")
//                            .font(.system(size: 14, weight: .semibold))
//                    }
//                })
//                
//                .padding(.bottom, 16)
//            }
//            .navigationDestination(isPresented: $viewModel.didAuthenticateUser, destination: {
//                ProfilePhotoSelectorView() })
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//}
//
//struct RegistrationView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegistrationView()
//    }
//}
//
