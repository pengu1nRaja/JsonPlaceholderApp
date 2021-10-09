//
//  NetworkManager.swift
//  JsonPlaceholderApp
//
//  Created by PenguinRaja on 09.10.2021.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let url = "https://jsonplaceholder.typicode.com"
    
    private init() {}
    
    func fetchUsersData(completion: @escaping (Result<[User], Error>) -> Void) {
        let usersURL = url + "/users"
        
        guard let url = URL(string: usersURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "no description")
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchUserPhotos(photoId: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        
        let usersURL = url + "/photos?" + "\(photoId)"
        guard let url = URL(string: usersURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "no description")
                return
            }
            do {
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                completion(.success(photos))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
