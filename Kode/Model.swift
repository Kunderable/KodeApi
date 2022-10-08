//
//  Model.swift
//  Kode
//
//  Created by Илья Сутормин on 07.10.2022.
//

import Foundation


struct Kode: Codable {
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let id: String
    let avatarURL: String
    let firstName, lastName, userTag, department: String
    let position, birthday, phone: String

    enum CodingKeys: String, CodingKey {
        case id
        case avatarURL = "avatarUrl"
        case firstName, lastName, userTag, department, position, birthday, phone
    }
}
