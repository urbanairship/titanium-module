/* Copyright Airship and Contributors */

import TitaniumKit
import AirshipCore;

@objc(TiAirshipPrivacyManagerProxy)
public class TiAirshipPrivacyManagerProxy: TiProxy {

    @objc
    public let featureAll = FeatureNames.all

    @objc
    public let featureNone = FeatureNames.none

    @objc
    public let featurePush = FeatureNames.push

    @objc
    public let featureChat = FeatureNames.chat

    @objc
    public let featureLocation = FeatureNames.location

    @objc
    public let featureMessageCenter = FeatureNames.messageCenter

    @objc
    public let featureInAppAutomation = FeatureNames.inAppAutomation

    @objc
    public let featureContacts = FeatureNames.contacts

    @objc
    public let featureTagsAndAttributes = FeatureNames.tagsAndAttributes

    @objc
    public let featureAnalytics = FeatureNames.analytics
    
    @objc
    public var enabledFeatures: [String] {
        Airship.shared.privacyManager.enabledFeatures.toStringArray()
    }

    @objc(setEnabledFeatures:)
    public func setEnabledFeatures(arg: Any) {
        AirshipLogger.debug(describe(arg))
        guard let names = arg as? [String] else {
            rejectArguments(arg)
        }
        Airship.shared.privacyManager.enabledFeatures = try! Features.parse(names)
    }
    
    @objc(enable:)
    public func enable(arguments: [Any]?) {
        AirshipLogger.debug(describe(arguments))
        let features = try! parseFeatures(arguments)
        Airship.shared.privacyManager.enableFeatures(features)
    }

    @objc(disable:)
    public func disable(arguments: [Any]?) {
        AirshipLogger.debug(describe(arguments))
        let features = try! parseFeatures(arguments)
        Airship.shared.privacyManager.disableFeatures(features)
    }

    private func parseFeatures(_ arguments: [Any]?) throws -> Features {
        if let names = arguments?.first as? [String] {
            return try Features.parse(names)
        } else if let name = arguments?.first as? String {
            return try Features.parse([name])
        } else {
            rejectArguments(arguments)
        }
    }
}
