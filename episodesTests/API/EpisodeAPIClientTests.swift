//
//  EpoisodeAPIClient.swift
//  episodesTests
//
//  Created by Toni on 17/06/2018.
//  Copyright © 2018 Antonio Calvo. All rights reserved.
//

import Require
import Result
import OHHTTPStubs

import XCTest
@testable import episodes

class EpisodeAPIClientTests: XCTestCase {
  var client: APIClient!
  
  override func setUp() {
    super.setUp()
    
    client = APIClient.episodeAPIClient
  }
  
  override func tearDown() {
    OHHTTPStubs.removeAllStubs()
    super.tearDown()
  }
  
  func testReturnsAllEpisodes() {
    stub(condition: isHost("rickandmortyapi.com")) { _ in
      let stubPath = OHPathForFile("Episodes.json", type(of: self)).require()
      return fixture(filePath: stubPath, headers: ["Content-Type":"application/json"])
    }
    
    let expectation = XCTestExpectation()
    
    client.episodes(page: 1) { (resultData: Result<EpisodeResponse, APIClientError>) in
      let object = resultData.value.require()
      
      XCTAssertEqual(object.info.count, 31)
      XCTAssertEqual(object.info.pages, 2)
      XCTAssertEqual(object.info.next, "https://rickandmortyapi.com/api/episode?page=2")
      XCTAssertEqual(object.info.prev, "")
      XCTAssertEqual(object.results.count, 20)
      
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 5.0)
  }
}
