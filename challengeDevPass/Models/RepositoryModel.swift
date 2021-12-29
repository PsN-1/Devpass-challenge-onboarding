//
//  RepositoryModel.swift
//  challengeDevPass
//
//  Created by Pedro Neto on 29/12/21.
//

import Foundation

struct RepositoryModel: Codable {
    let id: Int?
    let name: String?
    let stargazersCount: Int?
    let url: String?
    let language: String?
    let description: String?
    let forksCount: Int?
    let login: String?
    let license: LicenseModel?
    let owner: OwnerModel?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case stargazersCount = "stargazers_count"
        case url
        case language
        case description
        case forksCount = "forks_count"
        case login
        case license
        case owner
    }
}

struct LicenseModel: Codable {
    let name: String?
    let id: String?
}

struct OwnerModel: Codable {
    let login: String?
    let type: String?
    let userPhoto: String?
    
    enum CodingKeys: String, CodingKey {
        case userPhoto = "avatar_url"
        case login, type
    }
}
