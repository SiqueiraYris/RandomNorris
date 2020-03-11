//
//  NetworkError.swift
//  RandomNorris
//
//  Created by Siqueira on 11/03/20.
//  Copyright © 2020 Siqueira. All rights reserved.
//

import Foundation

// MARK: - Network Errors
enum NetworkErrors: NSInteger, LocalizedError {
    case decoderFailure = -1001
    case malformedUrl = -1002
    case noData = -1003
    case requestFailure = -1004
    case connectionLost = -1005
    case unknownFailure = -1006
    case notConnected = -1009

    enum HTTPErrors: Int, LocalizedError {
        case badRequest = 400
        case unauthorized = 401
        case forbidden = 403
        case notFound = 404
        case timeOut = 408
        case internalServerError = 500

        var code: Int {
            return rawValue
        }

        
        var errorDescription: String? {
            return ""
//            switch self {
//            case .unauthorized:
//                return String.localized(by: "UnauthorizedError")
//
//            case .notFound:
//                return String.localized(by: "NotFoundError")
//
//            case .internalServerError:
//                return String.localized(by: "InternalServerError")
//
//            case .badRequest:
//                return String.localized(by: "BadRequestError")
//
//            case .timeOut:
//                return String.localized(by: "TimeOutError")
//
//            case .forbidden:
//                return String.localized(by: "ForbiddenError")
//            }
        }
    }

    var code: Int {
        return rawValue
    }

    var errorDescription: String? {
        return ""
//        switch self {
//        case .connectionLost:
//            return String.localized(by: "ConnectionLostError")
//
//        case .decoderFailure:
//            return String.localized(by: "UnexpectedError")
//
//        case .malformedUrl:
//            return String.localized(by: "UnknownError")
//
//        case .noData:
//            return String.localized(by: "NoDataError")
//
//        case .notConnected:
//            return String.localized(by: "ConnectionError")
//
//        case .requestFailure:
//            return String.localized(by: "UnexpectedError")
//
//        case .unknownFailure:
//            return String.localized(by: "UnknownError")
//        }
    }
}

// MARK: - Error Handler
struct ErrorHandler: LocalizedError {
    private var message: String
    var code: Int?
    var errorDescription: String? {
        return message
    }

    init(statusCode: Int? = nil, data: Data? = nil, defaultError: Error) {
        self.code = statusCode
        self.message = defaultError.localizedDescription

        guard let data = data else { return }

        do {
            let decoder = JSONDecoder()
            let objectError = try decoder.decode(DefaultError.self, from: data)
            message = objectError.message
        } catch {
            self.message = defaultError.localizedDescription
        }
    }

    init(statusCode: Int? = nil, data: Data? = nil, defaultError: NetworkErrors.HTTPErrors = .badRequest) {
        self.code = statusCode
        self.message = defaultError.errorDescription ?? "ERROR"

        guard let data = data else { return }

        do {
            let decoder = JSONDecoder()
            let objectError = try decoder.decode(DefaultError.self, from: data)
            message = objectError.message
        } catch {
            self.message = defaultError.errorDescription ?? "ERROR"
        }
    }

    init(statusCode: Int? = nil, data: Data? = nil, defaultError: NetworkErrors = .decoderFailure) {
        self.code = statusCode
        self.message = defaultError.errorDescription ?? "ERROR"

        guard let data = data else { return }

        do {
            let decoder = JSONDecoder()
            let objectError = try decoder.decode(DefaultError.self, from: data)
            message = objectError.message
        } catch {
            self.message = defaultError.errorDescription ?? "ERROR"
        }
    }
}

// MARK: - Default Error
struct DefaultError: Decodable {
    var message: String
    var code: String?
}
