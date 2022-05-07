//
//  Utils.swift
//  TiAirship
//
//  Created by Ryan Lepinski on 5/6/22.
//

import Foundation
import AirshipCore

struct Utils {
    static func parseFeatures(_ stringArray: [String]?) -> Features {
        var feature: Features = []
        stringArray?.map { $0.toFeature() }.forEach { feature.update(with: $0) }
        return feature
    }
}

extension String {
    func toFeature() -> Features {
        switch (self) {
        case "inAppAutomation": return .inAppAutomation
        case "messageCenter": return .messageCenter
        case "push": return .push
        case "analytics": return .analytics
        case "chat": return .chat
        case "location": return .location
        case "tagsAndAttributes": return .tagsAndAttributes
        case "all": return .all
        case "none": return []
        default: return []
        }
    }
}

