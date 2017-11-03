// Copyright © 2017 Simon Strandgaard. All rights reserved.
import Foundation

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
		let components: [String] = string.components(separatedBy: ".")
		if components.count != 3 {
			return nil
		}
		guard let major: Int = Int(components[0]) else {
			return nil
		}
		guard let minor: Int = Int(components[1]) else {
			return nil
		}
		guard let patch: Int = Int(components[2]) else {
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
