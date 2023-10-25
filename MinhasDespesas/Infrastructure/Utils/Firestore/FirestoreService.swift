//
//  FirestoreService.swift
//  MinhasDespesas
//
//  Created by Felipe Augusto Silva on 25/10/23.
//

import Foundation
import FirebaseFirestore
import SDKCommon

public protocol FirestoreServiceLogic {
    func saveUserData(completion: @escaping (Bool) -> Void)
    func getFirestoreDocument<T: Decodable>(_ collectionName: String, documentID: String, objectType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

public final class FirestoreService: FirestoreServiceLogic {
    
    public static var shared: FirestoreServiceLogic = FirestoreService()
    
    var service: AuthServiceLogic
    
    public init(service: AuthServiceLogic = AuthService()) {
        self.service = service
    }
    
    public func saveUserData(completion: @escaping (Bool) -> Void) {
        guard let userID = service.getCurrentUser()?.uid else {
            completion(false)
            return
        }
        let db = Firestore.firestore()
        let userCollection = db.collection("Users").document(userID)
        
        getFirestoreDocument("Users", documentID: userID, objectType: User.self) { userResponse in
            switch userResponse {
            case .success(let userResult):
                var user = userResult
                UserRepository.shared.user = user
                completion(true)
            case .failure:
                completion(false) // Notify the caller that the operation failed
            }
        }
    }
    
    public func getFirestoreDocument<T: Decodable>(_ collectionName: String, documentID: String, objectType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let db = Firestore.firestore()
        let documentReference = db.collection(collectionName).document(documentID)
        
        documentReference.getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists {
                do {
                    if let data = document.data() {
                        let jsonData = try JSONSerialization.data(withJSONObject: data)
                        let decodedObject = try JSONDecoder().decode(objectType, from: jsonData)
                        completion(.success(decodedObject))
                    } else {
                        let decodingError = NSError(domain: "FirestoreDecodingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to decode Firestore data"])
                        completion(.failure(decodingError))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else {
                let documentNotFoundError = NSError(domain: "FirestoreDocumentNotFoundError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Document not found"])
                completion(.failure(documentNotFoundError))
            }
        }
    }
}
