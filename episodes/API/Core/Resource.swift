//
//  Resource.swift
//  photobook
//
//  Created by antonio calvo on 13/06/2018.
//  Copyright © 2018 antonio calvo. All rights reserved.
//

import Require
import Foundation

enum Method: String {
  case GET = "GET"
  case POST = "POST"
  case PATCH = "PATCH"
  case PUT = "PUT"
  case DELETE = "DELETE"
}

protocol Resource {
  var method: Method { get }
  var path: String { get }
  var parameters: [(String, String)] { get }
  var body: Data? { get }
  var contentType: String? { get }
}

extension Resource {
  var path: String {
    return ""
  }
  var method: Method {
    return .GET
  }
  var parameters: [(String, String)] {
    return []
  }
  var body: Data? {
    return nil
  }
  var contentType: String? {
    return "application/json"
  }

  func requestWithBaseURL(_ baseURL: URL) -> URLRequest {
    let url = !path.isEmpty ? baseURL.appendingPathComponent(path) : baseURL

    var components = URLComponents(url: url, resolvingAgainstBaseURL: false).require(hint: "Unable to create URL components from \(url)")

    components.queryItems = parameters.map {
      URLQueryItem(name: String($0), value: String($1))
    }

    let finalURL = components.url.require(hint: "Unable to retrieve final URL")

    var request = URLRequest(url: finalURL)
    request.httpMethod = method.rawValue

    if let body = self.body {
      request.httpBody = body
    }

    if let contentType = self.contentType {
      request.setValue(contentType, forHTTPHeaderField: "Content-Type")
    }

    return request
  }
}
