//
//  AppEnvironment.swift
//  Repository
//
//  Created by Hao Tran Thien on 06/01/2022.
//

import Foundation

/// Configurable information read from Info.plist file
enum ConfigKey: String {
    case environment = "Environment"
    
    ///
    case apiEnpointUrl = "apiEnpointUrl"
}

/// The environment
enum AppEnvironment: String {
    case dev = "Dev"
    case qc = "QC"
    case production = "Production"
    
    /// Get current environment - from info.plist file
    /// if no data is there - set environment as production
    static var current: AppEnvironment {
        let environmentName = readStringFromConfig(key: .environment)
        return AppEnvironment(rawValue: environmentName)!
    }

    /// Get api endpoint url
    static var apiEnpointUrl: String {
        return readStringFromConfig(key: .apiEnpointUrl)
    }
    
    /// A private method to wrap up the reading confign from the main bundle
    ///
    /// - Parameter key: the key we need to get the string out
    /// - Returns: the config string readed from the config file
    private static func readStringFromConfig(key: ConfigKey) -> String {
        return Bundle.main.readStringFromConfig(key: key)
    }
}

// MARK: - Extension on bundle to read config variable
extension Bundle {

    /// Read one variable from the bundle plist file
    ///
    /// - Parameter key: the config to read
    /// - Returns: the value from config file
    func readStringFromConfig(key: ConfigKey) -> String {
        return Bundle.main.object(forInfoDictionaryKey: key.rawValue) as! String
    }
}
