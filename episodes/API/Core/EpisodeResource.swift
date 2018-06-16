//
//  EpisodeResource.swift
//  episodes
//
//  Created by Toni on 17/06/2018.
//  Copyright © 2018 Antonio Calvo. All rights reserved.
//

import Foundation
import Result
import Require

enum EpisodeResource {
  case episodes(page: Int)
}

extension EpisodeResource: Resource {
  var path: String {
    switch self {
    case .episodes:
      return "episode"
    }
  }
  
  var parameters: [(String, String)] {
    switch self {
    case .episodes(let page):
      return [("page", "\(page)")]
    }
  }
}

extension APIClient {
  static var episodeAPIClient: APIClient {
    return APIClient(baseURL: URL.baseURL)
  }
  
  func episodes(page: Int, completion: @escaping (Result<[Episode], APIClientError>) -> Void) {
    let resource = EpisodeResource.episodes(page: page)
    object(resource) { result in
      completion(result)
    }
  }
}
