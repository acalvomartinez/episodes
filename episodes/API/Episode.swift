//
//  Episode.swift
//  episodes
//
//  Created by Toni on 13/06/2018.
//  Copyright © 2018 Antonio Calvo. All rights reserved.
//

import Foundation

struct Episode: Codable {
  var identifier: Int
  var name: String
  var airDate: String
  var code: String
  var urlCharacters: [String]
  
  private enum CodingKeys: String, CodingKey {
    case identifier = "id"
    case name
    case airDate = "air_date"
    case code = "episode"
    case urlCharacters = "characters"
  }
}
