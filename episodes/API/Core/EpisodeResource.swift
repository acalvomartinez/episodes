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
  var parameters: [(String, String)] {
    switch self {
    case .episodes(let page):
      return [("page", "\(page)")]
    }
  }
}

extension URL {
  static var episodeURL: URL {
    return URL.baseURL.appendingPathComponent("episode")
  }
}

typealias EpisodeResponse = Response<Episode>

extension APIClient {
  static var episodeAPIClient: APIClient {
    return APIClient(baseURL: URL.episodeURL)
  }
  
  func episodes(page: Int, completion: @escaping (Result<EpisodeResponse, APIClientError>) -> Void) {
    let resource = EpisodeResource.episodes(page: page)
    object(resource) { result in
      completion(result)
    }
  }
}
