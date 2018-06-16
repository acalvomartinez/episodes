//
//  ResponseTests.swift
//  episodesTests
//
//  Created by Toni on 16/06/2018.
//  Copyright © 2018 Antonio Calvo. All rights reserved.
//

import Require

import XCTest
@testable import episodes

protocol ModelTestable {
  func createCodeableFromFile<T:Codable>(named filename: String) -> T?
}

extension ModelTestable {
  func createCodeableFromFile<T:Codable>(named filename: String) -> T? {
    let decoder = JSONDecoder()
    
    let testBundle = Bundle(for: type(of: self) as! AnyClass)
    let filePath = testBundle.path(forResource: filename, ofType: "json").require()
    
    do {
      let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: [])
      let object = try decoder.decode(T.self, from: data)
      return object
    } catch {
      print("Error decoding JSON: \(error)")
      return nil
    }
  }
}

class ResponseTests: XCTestCase, ModelTestable {
  struct TestModel: Codable {
    var id: Int
    var name: String
  }
  
  func testThatAValidJSONShouldCreateAValidResponse() {
    let object: Response<TestModel> = createCodeableFromFile(named: "Response").require()
    
    XCTAssertNotNil(object)
    XCTAssertEqual(object.info.count, 3)
    XCTAssertEqual(object.info.pages, 1)
    XCTAssertEqual(object.info.next, "https://rickandmortyapi.com/api/tests?page=2")
    XCTAssertEqual(object.info.prev, "")
    XCTAssertEqual(object.results.count, 3)
  }
}


