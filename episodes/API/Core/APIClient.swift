//
//  APIClient.swift
//  photobook
//
//  Created by antonio calvo on 13/06/2018.
//  Copyright © 2018 antonio calvo. All rights reserved.
//

import Foundation
import Result

final class APIClient {

  private let session: URLSession
  private let baseURL: URL

  init(baseURL: URL, configuration: URLSessionConfiguration = .default) {
    self.baseURL = baseURL
    self.session = URLSession(configuration: configuration)
  }

  private var isNetworkActivityIndicatorVisible: Bool = false {
    didSet {
      DispatchQueue.main.async {
        UIApplication.shared.isNetworkActivityIndicatorVisible = self.isNetworkActivityIndicatorVisible
      }
    }
  }

  func object<T: Decodable>(_ resource: Resource, completion: @escaping(Result<T, APIClientError>) -> Void) {
    data(resource) { (result: Result) in
      if let error = result.error {
        completion(Result(error: error))
        return
      }

      let jsonDecoder = JSONDecoder()

      guard
        let value = result.value,
        let object:T = try? jsonDecoder.decode(T.self, from: value) else {
          completion(Result(error: .parsingError))
          return
      }

      completion(Result(value: object))
    }
  }

  private func data(_ resource: Resource, completion: @escaping(Result<Data, APIClientError>) -> Void) {
    isNetworkActivityIndicatorVisible = true

    let request = resource.requestWithBaseURL(baseURL)

    let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
      self.isNetworkActivityIndicatorVisible = false
      if let error = error {
        completion(Result(error: APIClientError.httpClientError(error: error)))
        return
      }

      guard let httpResponse = response as? HTTPURLResponse else {
        completion(Result(error: .networkError))
        return
      }

      let bodyData = data ?? Data()

      if (200 ..< 300 ~= httpResponse.statusCode) {
        completion(Result(value: bodyData))
      } else {
        completion(Result(error: .networkError))
      }
    }
    task.resume()
  }
}
