//
//  Item.swift
//  FetchHiring
//
//  Created by Nick Nguyen on 10/19/20.
//

import Foundation

struct Item {
    let id: Int
    let group: Int
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case group = "listId"
        case name = "name"
    }
}

extension Item: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let id = try container.decode(Int.self, forKey: .id)
        let group = try container.decode(Int.self, forKey: .group)
        let name = try container.decodeIfPresent(String.self, forKey: .name)

        self.id = id
        self.group = group
        self.name = name

    }
}

extension Item: Comparable {
    static func < (lhs: Item, rhs: Item) -> Bool {
        lhs.id < rhs.id
    }
}
