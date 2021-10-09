//
//  UserModel.swift
//  JsonPlaceholderApp
//
//  Created by PenguinRaja on 09.10.2021.
//

import Foundation

struct User: Codable {
    let name: String
    let username: String
    let id: Int
}

struct Photo: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
}
