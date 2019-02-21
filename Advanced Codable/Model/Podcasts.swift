//
//  Podcasts.swift
//  Advanced Codable
//
//  Created by Brendan Krekeler on 2/20/19.
//  Copyright © 2019 Brendan Krekeler. All rights reserved.
//

import Foundation

struct RSSFeed: Codable {
    struct Feed: Codable {
        struct Podcast: Codable {
            let name: String
            let artistName: String
            let url: URL
            let releaseDate: Date
        }
        
        let title: String
        let country: String
        let updated: Date
        let podcasts: [Podcast]
        
        private enum CodingKeys: String, CodingKey {
            case title
            case country
            case updated
            case podcasts = "results"
        }
    }
    
    let feed: Feed
}

typealias Feed = RSSFeed.Feed
typealias Podcast = Feed.Podcast


extension Podcast {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        artistName = try container.decode(String.self, forKey: .artistName)
        url = try container.decode(URL.self, forKey: .url)
        
        let dateString = try container.decode(String.self, forKey: .releaseDate)
        let formatter = DateFormatter.yyyyMMdd
        if let date = formatter.date(from: dateString) {
            releaseDate = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .releaseDate,
                                                   in: container,
                                                   debugDescription: "Date string does not match format expected by formatter.")
        }
    }
}

extension DateFormatter {
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
