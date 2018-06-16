//
//  APIClientTests.swift
//  photobookTests
//
//  Created by antonio calvo on 13/06/2018.
//  Copyright © 2018 antonio calvo. All rights reserved.
//

import Result
import Require
import OHHTTPStubs

import XCTest
@testable import episodes

class APIClientTests: XCTestCase {

  struct TestModel: Codable {
    let foo: String
  }

  struct TestResource: Resource {
    let path = "object"
    let parameters = [("name", "value")]
  }

  var client: APIClient?

  override func setUp() {
    super.setUp()

    let url = URL(string: "http://test.com").require()

    client = APIClient(baseURL: url)
  }

  override func tearDown() {
    OHHTTPStubs.removeAllStubs()
    super.tearDown()
  }

  func testValidResponse() {
    stub(condition: isHost("test.com")) { _ in
      let stubPath = OHPathForFile("Test.json", type(of: self)).require()
      return fixture(filePath: stubPath, headers: ["Content-Type":"application/json"])
    }

    let expectation = XCTestExpectation()

    client?.object(TestResource()) { (resultData: Result<TestModel, APIClientError>) in
      let foo = resultData.value?.foo
      XCTAssertEqual(foo, "hello, world!")

      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 5.0)
  }

  func testReturnsNetworkErrorIfThereIsNoConnection() {
    stub(condition: isHost("test.com")) { _ in
      return OHHTTPStubsResponse(error: NSError.networkError())
    }

    let expectation = XCTestExpectation()

    client?.object(TestResource()) { (resultData: Result<TestModel, APIClientError>) in
      let error = APIClientError.httpClientError(error: NSError.networkError())
      XCTAssertEqual(resultData.error, error)

      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 5.0)
  }
}

extension NSError {
  static func networkError() -> NSError {
    return NSError(domain: NSURLErrorDomain,
                   code: NSURLErrorNetworkConnectionLost,
                   userInfo: nil)
  }

  static func itemNotFoundError() -> NSError {
    return NSError(domain: NSURLErrorDomain,
                   code: 404,
                   userInfo: nil)
  }
}
