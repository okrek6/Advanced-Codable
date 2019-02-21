//
//  Food.swift
//  Advanced Codable
//
//  Created by Brendan Krekeler on 2/20/19.
//  Copyright © 2019 Brendan Krekeler. All rights reserved.
//

import Foundation

struct Food {
    var type: String
    var size: Size
    
    enum CodingKeys: String, CodingKey {
        case type = "title"
        case width
        case height
    }
}

extension Food: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(size.width, forKey: .width)
        try container.encode(size.height, forKey: .height)
    }
}

extension Food: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decode(String.self, forKey: .type)
        let width = try values.decode(Double.self, forKey: .width)
        let height = try values.decode(Double.self, forKey: .height)
        size = Size(width: width, height: height)
    }
}

struct Size {
    var width: Double
    var height: Double
}
