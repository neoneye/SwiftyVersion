// Copyright © 2017 Simon Strandgaard. All rights reserved.
import Foundation

fileprivate extension Scanner {
	/// Returns a string, scanned as long as characters from a given character set are encountered, or `nil` if none are found.
	func ss_scanCharacters(set: CharacterSet) -> String? {
		var value: NSString? = ""
		if scanCharacters(from: set, into: &value),
			let value = value as String? {
			return value
		}
		return nil
	}
	
	/// Returns the given string if scanned, or `nil` if not found.
	func ss_scanString(string: String) -> String? {
		var value: NSString? = ""
		if scanString(string, into: &value),
			let value = value as String? {
			return value
		}
		return nil
	}
	
	var ss_atEnd: Bool {
		return isAtEnd
	}
}

public struct Version {
	public let major: Int
	public let minor: Int
	public let patch: Int
	
	public init(major: Int, minor: Int, patch: Int) {
		self.major = major
		self.minor = minor
		self.patch = patch
	}
	
	public init?(_ string: String) {
		let s = Scanner(string: string)
		let dd = CharacterSet.decimalDigits
		guard let majorString = s.ss_scanCharacters(set: dd) else {
			return nil
		}
		guard s.ss_scanString(string: ".") != nil else {
			return nil
		}
		guard let minorString = s.ss_scanCharacters(set: dd) else {
			return nil
		}
		guard s.ss_scanString(string: ".") != nil else {
			return nil
		}
		guard let patchString = s.ss_scanCharacters(set: dd) else {
			return nil
		}
		guard s.ss_atEnd else {
			return nil
		}
		guard let major: Int = Int(majorString) else {
			return nil
		}
		guard let minor: Int = Int(minorString) else {
			return nil
		}
		guard let patch: Int = Int(patchString) else {
			return nil
		}
		self.init(major: major, minor: minor, patch: patch)
	}
}

extension Version: CustomStringConvertible {
	public var description: String {
		return "\(major).\(minor).\(patch)"
	}
}

extension Version: Hashable {
	public var hashValue: Int {
		let prime = 31
		return [major.hashValue, minor.hashValue, patch.hashValue].reduce(0) { $0 &* prime &+ $1 }
	}

	public static func ==(lhs: Version, rhs: Version) -> Bool {
		guard lhs.major == rhs.major else { return false }
		guard lhs.minor == rhs.minor else { return false }
		guard lhs.patch == rhs.patch else { return false }
		return true
	}
}

extension Version: Comparable {
	public static func < (lhs: Version, rhs: Version) -> Bool {
		if lhs.major != rhs.major {
			return lhs.major < rhs.major
		} else if lhs.minor != rhs.minor {
			return lhs.minor < rhs.minor
		} else {
			return lhs.patch < rhs.patch
		}
	}
}
