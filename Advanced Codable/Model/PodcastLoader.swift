//
//  PodcastLoader.swift
//  Advanced Codable
//
//  Created by Brendan Krekeler on 2/20/19.
//  Copyright © 2019 Brendan Krekeler. All rights reserved.
//

import Foundation

class PodcastLoader {
    
    class func load(jsonFileName: String) -> RSSFeed? {
        var podcasts: RSSFeed?
        
        var jsonDecoder: JSONDecoder {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .custom { decoder in
                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
                if let date = formatter.date(from: dateString) {
                    return date
                }
                formatter.dateFormat = "yyyy-MM-dd"
                if let date = formatter.date(from: dateString) {
                    return date
                }
                throw DecodingError.dataCorruptedError(in: container,
                                                       debugDescription: "Cannot decode date string \(dateString)")
            }
            return jsonDecoder
        }
        
        if let jsonFileUrl = Bundle.main.url(forResource: jsonFileName, withExtension: ".json") {
            if let jsonData = try? Data(contentsOf: jsonFileUrl) {
                do {
                    podcasts = try jsonDecoder.decode(RSSFeed.self, from: jsonData)
                } catch let error {
                    print("bad decoding")
                    print(error)
                }
            } else {
                print("bad data")
            }
        } else {
            print("bad url")
        }
        
        return podcasts
    }
}
