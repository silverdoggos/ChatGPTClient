//
//  AuthViewModel.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 25.03.2023.
//

//import UIKit
////import Firebase
//
//class AuthViewModel: NSObject, ObservableObject {
//    @Published var didAuthenticateUser: Bool = false
//    @Published var currentUser: User?
//    @Published var userSession: FirebaseAuth.User?
//    private var tempCurrentUser: FirebaseAuth.User?
//
//
//    static let shared = AuthViewModel()
//
//    override init() {
//        super.init()
//        userSession = Auth.auth().currentUser
//        fetchUser()
//    }
//
//    func register(email: String, username: String, fullname: String, password: String) {
//        Auth.auth().createUser(withEmail: email, password: password) {result , error in
//            if let error = error {
//                debugPrint("FAILED: Failed to register with error \(error.localizedDescription)")
//                return
//            }
//
//            guard let user = result?.user else { return }
//            self.tempCurrentUser = user
//
//            let data: [String: Any] = [
//                "email": email,
//                "username": username,
//                "fullname": fullname
//            ]
//
//            COLLECTION_USERS.document(user.uid).setData(data) { _ in
//                self.didAuthenticateUser = true
//            }
//        }
//    }
//
//    func login(email: String, password: String ) {
//        Auth.auth().signIn(withEmail: email, password: password) { result, error in
//            if let error = error {
//                debugPrint("FAILED: Failed to sing in with error \(error.localizedDescription)")
//                return
//            }
//
//            self.userSession = result?.user
//            self.fetchUser()
//        }
//    }
//
//    func uploadProfileImage(_ image: UIImage) {
//        guard let uid = tempCurrentUser?.uid else { return }
//
//        ImageUploader.uploadImage(image: image) { image in
//            COLLECTION_USERS.document(uid).updateData(["profileImageUrl": image]) { _ in
//                debugPrint("SUCCESS: success image uoload")
//                self.userSession = self.tempCurrentUser
//            }
//        }
//    }
//
//    func skipUploadPhoto() {
//        self.userSession = self.tempCurrentUser
//
//    }
//
//    func signout() {
//        self.userSession = nil
//        self.currentUser = nil
//        try? Auth.auth().signOut()
//    }
//
//    func fetchUser() {
//        guard let uid = userSession?.uid else { return }
//
//        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
//            guard let user = try? snapshot?.data(as: User.self) else { return }
//            debugPrint("DEBUG: fetching user \(user)")
//            self.currentUser = user
//        }
//    }
//}
