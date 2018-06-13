//
//  Episode.swift
//  episodes
//
//  Created by Toni on 13/06/2018.
//  Copyright © 2018 Antonio Calvo. All rights reserved.
//

import Foundation

struct Episode: Codable {
  var identifier: String
  var name: String
  var airDate: Date
  var code: String
  
  private enum CodingKeys: String, CodingKey {
    case identifier = "id"
    case name
    case airDate = "air_date"
    case code = "code"
  }
}
