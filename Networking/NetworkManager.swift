//
//  NetworkManager.swift
//  Productivity app
//
//  Created by Larry Tao on 12/31/23.
//
import Alamofire
import Foundation

class NetworkManager {
    
    /// Shared singleton instance
    static let shared = NetworkManager()
    
    private init() {}
    
    /// Endpoint for dev server
    private let devEndpoint: String = "http://34.86.136.171"
    
    // MARK: - Requests
    func fetchAllUsers(completion: @escaping ([User]) -> Void ) {
        let endpoint = "\(devEndpoint)/api/users/"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: UserResponse.self, decoder: decoder) {response in
                switch  response.result {
                case .success(let users):
                    print("Successfully fetched users")
                    completion(users.users)
                case .failure(let error):
                    print("Error in NetworkManager.fetchAllUsers: \(error)")
                }
            }
    }
    
    func createUser(username: String, password: String, pfp: String, skin: String, completion: @escaping (User) -> Void ) {
        let endpoint = "\(devEndpoint)/api/users/\(username)/"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let parameters: Parameters = [
            "password": password,
            "pfp": pfp,
            "skin": skin
        ]
        
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: User.self, decoder: decoder) {response in
                switch  response.result {
                case .success(let user):
                    print("Successfully created user")
                    completion(user)
                case .failure(let error):
                    print("Error in NetworkManager.createUser: \(error)")
                }
            }
    }
    
    func fetchUser(user_id: Int, completion: @escaping (User) -> Void) {
        let endpoint = "\(devEndpoint)/api/users/\(user_id)/"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: User.self, decoder: decoder) {response in
                switch  response.result {
                case .success(let user):
                    print("Successfully fetched user")
                    completion(user)
                case .failure(let error):
                    print("Error in NetworkManager.fetchUser: \(error)")
                }
            }
    }
    
    func login(username: String, password: String, completion: @escaping (User) -> Void) {
        let endpoint = "\(devEndpoint)/api/users/login/\(username)/\(password)/"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: User.self, decoder: decoder) {response in
                switch  response.result {
                case .success(let user):
                    print("Successfully logged in")
                    completion(user)
                case .failure(let error):
                    print("Error in NetworkManager.login: \(error)")
                }
            }
    }
    
    func deleteUser(user_id: Int, completion: @escaping (User) -> Void) {
        let endpoint = "\(devEndpoint)/api/users/\(user_id)"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(endpoint, method: .delete)
            .validate()
            .responseDecodable(of: User.self, decoder: decoder) {response in
                switch  response.result {
                case .success(let user):
                    print("Successfully deleted user")
                    completion(user)
                case .failure(let error):
                    print("Error in NetworkManager.deleteUser: \(error)")
                }
            }
    }
    
    func createSession(user_id: Int, completion: @escaping (Session) -> Void) {
        let endpoint = "\(devEndpoint)/api/sessions/\(user_id)"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(endpoint, method: .post)
            .validate()
            .responseDecodable(of: Session.self, decoder: decoder) {response in
                switch  response.result {
                case .success(let user):
                    print("Successfully created session")
                    completion(user)
                case .failure(let error):
                    print("Error in NetworkManager.createSession: \(error)")
                }
            }
    }
    
    func endSession(user_id: Int, completion: @escaping (Session) -> Void) {
        let endpoint = "\(devEndpoint)/api/sessions/\(user_id)"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(endpoint, method: .put)
            .validate()
            .responseDecodable(of: Session.self, decoder: decoder) {response in
                switch  response.result {
                case .success(let user):
                    print("Successfully ended session")
                    completion(user)
                case .failure(let error):
                    print("Error in NetworkManager.createSession: \(error)")
                }
            }
    }
}
