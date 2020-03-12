//
//  RequestConfiguration.swift
//  RandomNorris
//
//  Created by Siqueira on 11/03/20.
//  Copyright © 2020 Siqueira. All rights reserved.
//

import Foundation

struct RequestConfiguration {
    // MARK: - Attributes
    var host: String
    var path: String
    var scheme: String
    var method: HTTPMethod
    var parameters: [String: Any]
    var headers: [String: String]
    var parametersEncoding: ParameterEncoding

    // MARK: - Initializer
    init(host: String = serverHost,
         path: String,
         scheme: String = uriScheme,
         method: HTTPMethod = .get,
         encoding: ParameterEncoding = .url,
         parameters: [String: Any] = [:],
         headers: [String: String] = [:]) {
        self.host = host
        self.path = path
        self.scheme = scheme
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.parametersEncoding = encoding
    }
}

// MARK: - HTTPMethod
public enum HTTPMethod: String {
    case connect = "CONNECT"
    case delete = "DELETE"
    case get = "GET"
    case head = "HEAD"
    case options = "OPTIONS"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
    case trace = "TRACE"
}

// MARK: - ParameterEncoding
public enum ParameterEncoding {
    case body
    case url
}
