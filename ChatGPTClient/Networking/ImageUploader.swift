//
//  ImageUploader.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 25.03.2023.
//
import UIKit


struct ImageUploader {
    
    
    static func uploadImage(image: UIImage, complition: @escaping (String) -> Void) {
//        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
//
//
//        let filename = NSUUID().uuidString
//        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
//
//        ref.putData(imageData) { _, error in
//            if let error = error {
//                debugPrint("DEBUG: error with image upload. Error \(error.localizedDescription)")
//                return
//            }
//
//            debugPrint("DEBUG: success upload image to firebase")
//
//            ref.downloadURL(completion: { url, _ in
//                guard let imageUrl = url?.absoluteString else { return }
//                debugPrint("DEBUG: success get image firebase url")
//                complition(imageUrl)
//            })
//        }
    }
}
