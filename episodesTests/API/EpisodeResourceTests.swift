//
//  EpisodeResource.swift
//  episodesTests
//
//  Created by Toni on 17/06/2018.
//  Copyright © 2018 Antonio Calvo. All rights reserved.
//

import Require

import XCTest
@testable import episodes

class EpisodeResourceTests: XCTestCase {
  
  func testEpisodeResourceIsCreatedProperlly() {
    let resource = EpisodeResource.episodes(page: 1)
    let resourceURLString = resource.requestWithBaseURL(URL.episodeURL).url?.absoluteString
    let URLString = "https://rickandmortyapi.com/api/episode?page=1"
    
    XCTAssertEqual(URLString, resourceURLString)
  }
}
