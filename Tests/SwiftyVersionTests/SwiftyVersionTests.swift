// Copyright © 2017 Simon Strandgaard. All rights reserved.
import XCTest
@testable import SwiftyVersion

class SwiftyVersionTests: XCTestCase {
	func testParseSuccess() {
		let version = Version("1.2.3")!
		XCTAssertEqual(version.major, 1)
		XCTAssertEqual(version.minor, 2)
		XCTAssertEqual(version.patch, 3)
	}

	func testParseFail() {
		XCTAssertNil(Version(""))
		XCTAssertNil(Version("1"))
		XCTAssertNil(Version("1."))
		XCTAssertNil(Version("1.2"))
		XCTAssertNil(Version("1.2."))
		XCTAssertNil(Version("1.2.3."))
		XCTAssertNil(Version("."))
		XCTAssertNil(Version(".."))
		XCTAssertNil(Version("..."))
		XCTAssertNil(Version("x.y.z"))
		XCTAssertNil(Version("1.2.3garbage"))
		XCTAssertNil(Version("garbage1.2.3garbage"))
		XCTAssertNil(Version("garbage1.2.3"))
	}
	
	func testDescription() {
		let version: Version = Version("1.2.3")!
		let actual = "\(version)"
		XCTAssertEqual(actual, "1.2.3")
	}
	
	func testHashSame() {
		let v0 = Version("1.2.3")!
		let v1 = Version("1.2.3")!
		XCTAssertEqual(v0.hashValue, v1.hashValue)
		XCTAssertEqual(v0, v1)
	}

	func testHashDifferent() {
		let v0 = Version("1.2.3")!
		let v1 = Version("1.2.4")!
		XCTAssertNotEqual(v0.hashValue, v1.hashValue)
		XCTAssertNotEqual(v0, v1)
	}

	func testCompareMajor() {
		let v0 = Version("1.2.3")!
		let v1 = Version("2.1.1")!
		XCTAssertGreaterThan(v1, v0)
	}
	
	func testCompareMinor() {
		let v0 = Version("1.2.3")!
		let v1 = Version("1.3.0")!
		XCTAssertGreaterThan(v1, v0)
	}
	
	func testComparePatch() {
		let v0 = Version("1.2.3")!
		let v1 = Version("1.2.4")!
		XCTAssertGreaterThan(v1, v0)
	}

	func testSorting() {
		let unorderedVersions: [Version] = [
			Version("3.3.3")!,
			Version("2.3.0")!,
			Version("1.0.0")!,
			Version("2.2.3")!,
			Version("1.0.1")!,
			Version("2.3.2")!
		]
		let versions = unorderedVersions.sorted()
		let s = versions.map { "\($0)" }.joined(separator: " ")
		XCTAssertEqual(s, "1.0.0 1.0.1 2.2.3 2.3.0 2.3.2 3.3.3")
	}

	static var allTests = [
		("testCompareMajor", testCompareMajor),
		("testCompareMinor", testCompareMinor),
		("testComparePatch", testComparePatch),
		("testDescription", testDescription),
		("testHashDifferent", testHashDifferent),
		("testHashSame", testHashSame),
		("testParseFail", testParseFail),
		("testParseSuccess", testParseSuccess),
		("testSorting", testSorting),
		]
}
