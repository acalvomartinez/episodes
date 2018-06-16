//
//  EpisodeTests.swift
//  episodesTests
//
//  Created by Toni on 17/06/2018.
//  Copyright © 2018 Antonio Calvo. All rights reserved.
//

import Require

import XCTest
@testable import episodes

class EpisodeTests: XCTestCase, ModelTestable {
  func testAValidJSONShouldCreateAAllEpisodesResponse() {
    let object: Response<Episode> = createCodeableFromFile(named: "AllEpisodes").require()
    
    XCTAssertNotNil(object)
    XCTAssertEqual(object.info.count, 31)
    XCTAssertEqual(object.info.pages, 2)
    XCTAssertEqual(object.info.next, "https://rickandmortyapi.com/api/episode?page=2")
    XCTAssertEqual(object.info.prev, "")
    XCTAssertEqual(object.results.count, 20)
  }
  
  func testAValidJSONShouldCreateAEpisode() {
    let object: Episode = createCodeableFromFile(named: "Episode").require()
    
    XCTAssertNotNil(object)
    XCTAssertEqual(object.identifier, 1)
    XCTAssertEqual(object.name, "Pilot")
    XCTAssertEqual(object.code, "S01E01")
    XCTAssertEqual(object.airDate, "December 2, 2013")
    XCTAssertEqual(object.urlCharacters.count, 19)
  }
}
