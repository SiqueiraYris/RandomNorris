//
//  ConfigurationConstants.swift
//  RandomNorris
//
//  Created by Siqueira on 12/03/20.
//  Copyright © 2020 Siqueira. All rights reserved.
//

import Foundation

private let configurationJson: [String: Any]? = {
    guard
        let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
        let dicInfo = NSDictionary(contentsOfFile: path),
        let dicConfig = dicInfo["Configurations"] as? [String: Any]
        else { return nil }

    return dicConfig
}()

var serverHost: String = {
    guard let serverHost = configurationJson?["host"] as? String else { return "" }

    return serverHost
}()

var uriScheme: String = {
    guard let uriScheme = configurationJson?["scheme"] as? String else { return "" }

    return uriScheme
}()

var randomPath: String = {
    guard let randomPath = configurationJson?["randomPath"] as? String else { return "" }

    return randomPath
}()
