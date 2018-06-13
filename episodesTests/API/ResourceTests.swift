//
//  ResourceTests.swift
//  photobookTests
//
//  Created by antonio calvo on 13/06/2018.
//  Copyright © 2018 antonio calvo. All rights reserved.
//

import Require

import XCTest
@testable import episodes

class ResourceTests: XCTestCase {

  func testRequestWithBaseURL() {

    enum TestResource: Resource {
      case example

      var method: episodes.Method {
        return .POST
      }
      var path: String {
        return "example"
      }
      var parameters: [(String, String)] {
        return [
          ("foo", "bar"),
          ("bar", "foo")
        ]
      }
    }

    let baseURL = URL(string: "https://example.com/api/v2").require()
    let request = TestResource.example.requestWithBaseURL(baseURL)
    let expectedURL = URL(string: "https://example.com/api/v2/example?foo=bar&bar=foo").require()
    let url = request.url.require()

    XCTAssertEqual(expectedURL, url)
  }
}

