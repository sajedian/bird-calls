//
//  bird_callsTests.swift
//  bird-callsTests
//
//  Created by Renee Sajedian on 7/17/20.
//  Copyright © 2020 Renee Sajedian. All rights reserved.
//

import XCTest
@testable import bird_calls

// swiftlint:disable type_name
class bird_callsTests: XCTestCase {

    var audioFile: AudioFile!

    override func setUpWithError() throws {
        super.setUp()
        audioFile = AudioFile(name: "XC10000 - Thrush-like Antpitta - Myrmothera campanisona signata.mp3")
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testAudioFileNotNil() {
        XCTAssertNotNil(audioFile, "audioFile was nil")
    }

    func testURLNotNil() {
        XCTAssertNotNil(audioFile.url, "audioFile url was nil")
    }

    func testAVPlayerNotNil() {
        XCTAssertNotNil(audioFile.avPlayer, "audioFile avPlayer was nil")
    }

    func testDurationIsCorrect() {
        XCTAssertEqual(audioFile.duration, 29.7, "audioFile duration was not 29.7s")
    }

    func testAVPlayerDuration() {
        XCTAssertEqual(audioFile.avPlayer?.duration, 29.7, "audioFile avPlayer duration was not 29.7s")
    }

    func testPlayFunctionWorks() {
        guard let avPlayer = audioFile.avPlayer else {
            XCTFail("avPlayer is nil")
            return
        }
        audioFile.play()
        XCTAssertTrue(avPlayer.isPlaying, "play function failed to play avPlayer")
    }

    func testPauseFunctionWorks() {
        guard let avPlayer = audioFile.avPlayer else {
            XCTFail("avPlayer is nil")
            return
        }
        audioFile.play()
        audioFile.pause()
        XCTAssertFalse(avPlayer.isPlaying, "pause function failed to pause avPlayer")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
