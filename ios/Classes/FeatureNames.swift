/* Copyright Airship and Contributors */

import Foundation
import AirshipCore

struct FeatureNames {
    static let map: [String: Features] = [
        FeatureNames.push: Features.push,
        FeatureNames.chat: Features.chat,
        FeatureNames.contacts: Features.contacts,
        FeatureNames.location: Features.location,
        FeatureNames.messageCenter: Features.messageCenter,
        FeatureNames.analytics: Features.analytics,
        FeatureNames.tagsAndAttributes: Features.tagsAndAttributes,
        FeatureNames.inAppAutomation: Features.inAppAutomation,
        FeatureNames.all: Features.all,
        FeatureNames.none: []
    ]

    static let none = "none"
    static let all = "all"
    static let push = "push"
    static let chat = "chat"
    static let contacts = "contacts"
    static let location = "location"
    static let messageCenter = "message_center"
    static let analytics = "analytics"
    static let tagsAndAttributes = "tags_and_attributes"
    static let inAppAutomation = "in_app_automation"
}

extension Features {
    func toStringArray() -> [String] {
        var names: [String] = []
        FeatureNames.map.forEach { key, value in
            if (key != FeatureNames.none && key != FeatureNames.all) {
                if (self.contains(value)) {
                    names.append(key)
                }
            }
        }

        return names
    }

    static func parse(_ names: [String]) throws -> Features {
        var features: Features = []

        try names.forEach { name in
            guard let feature = FeatureNames.map[name.lowercased()] else {
                throw AirshipErrors.error("Invalid feature \(name)")
            }

            features.update(with: feature)
        }

        return features
    }
}
