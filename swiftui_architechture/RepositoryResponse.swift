//
//  RepositoryResponse.swift
//  swiftui_architechture
//
//  Created by michael on 2024/8/18.
//

import Foundation


struct OwnerResponse: Decodable, Identifiable, Hashable {
    var id: Int
    var login: String? = ""
    var avatar_url: String? = ""
}

struct RepositoryResponse: Decodable, Identifiable, Hashable {
    var id: Int
    var name: String? = ""
    var full_name: String? = ""
    var description: String? = ""
    var owner: OwnerResponse?
    var stargazers_count: Int? = 0
    var forks: Int? = 0
    var watchers: Int? = 0
    var language: String? = ""
    var html_url: String? = ""
}

struct SearchRepositoryResponse: Decodable {
    var total_count: Int? = 0
    var incomplete_results: Bool? = false
    var items: [RepositoryResponse]?
}
