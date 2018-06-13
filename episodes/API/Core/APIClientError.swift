//
//  APIClientError.swift
//  photobook
//
//  Created by antonio calvo on 13/06/2018.
//  Copyright © 2018 antonio calvo. All rights reserved.
//

enum APIClientError: Error {
  case networkError
  case httpClientError(error: Error)
  case parsingError
  case unsupportedURLScheme
  case retry
}

extension APIClientError: CustomStringConvertible {
  var description: String {
    switch self {
    case .networkError:
      return "Network Error!"
    case .httpClientError(let error):
      return "HTTP Client Error \(error)"
    case .parsingError:
      return "Parsing Error!"
    case .unsupportedURLScheme:
      return "Unsupported URL Scheme!"
    case .retry:
      return "Retry!"
    }
  }
}

extension APIClientError: CustomDebugStringConvertible {
  var debugDescription: String {
    return description
  }
}

extension APIClientError: Equatable {
  static func == (lhs: APIClientError, rhs: APIClientError) -> Bool {
    return lhs.debugDescription == rhs.debugDescription
  }
}

