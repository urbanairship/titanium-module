/* Copyright Airship and Contributors */

import Foundation
import AirshipCore

struct CloudSiteName {
    static let map: [String: CloudSite] = [
        eu: CloudSite.eu,
        us: CloudSite.us
    ]

    static let eu = "eu"
    static let us = "us"
}

extension CloudSite {
    static func parse(name: String) throws -> CloudSite {
        guard let site = CloudSiteName.map[name.lowercased()] else {
            throw AirshipErrors.error("Invalid site: \(name)")
        }

        return site
    }
}
