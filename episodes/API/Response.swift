//
//  Response.swift
//  episodes
//
//  Created by Toni on 16/06/2018.
//  Copyright © 2018 Antonio Calvo. All rights reserved.
//

import Foundation

struct Response<T>: Codable where T: Codable {
  struct Info: Codable {
    var count: Int
    var pages: Int
    var next: String
    var prev: String
  }
  
  var info: Info
  var results: [T]
}
