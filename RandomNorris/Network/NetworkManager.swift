//
//  NetworkManager.swift
//  RandomNorris
//
//  Created by Siqueira on 11/03/20.
//  Copyright © 2020 Siqueira. All rights reserved.
//

import Foundation

final class NetworkManager {
    // MARK: - Attributes
    private let session: URLSession
    private var queue: DispatchQueue
    private let decoder = JSONDecoder()

    // MARK: - Initializer
    init(queue: DispatchQueue = DispatchQueue.main,
         networkServiceType: NSURLRequest.NetworkServiceType = .responsiveData,
         session: URLSession = URLSession(configuration: .default)) {
        self.session = session
        self.session.configuration.networkServiceType = networkServiceType
        self.queue = queue
    }

    private func createUrlRequest(with config: RequestConfiguration) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = config.host
        urlComponents.path = config.path

        guard let url = urlComponents.url else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = "\(config.method)"

//        var httpBody: Data?
//
//        if !config.parameters.isEmpty {
//            switch config.parametersEncoding {
//            case .url:
//                urlComponents.setQueryItems(with: config.parameters)
//                request.url = urlComponents.url
//                request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
//
//            case .body:
//                httpBody = try? JSONSerialization.data(withJSONObject: config.parameters, options: [])
//                request.setValue("application/json", forHTTPHeaderField: "Accept")
//                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            }
//        }
//
//        if let body = httpBody {
//            request.httpBody = body
//        }

//        request.allHTTPHeaderFields = config.headers
        
        return request
    }

    private func validateStatusCode(with code: Int) throws {
        switch code {
        case 200...299: break
        case 400: throw NetworkErrors.HTTPErrors.badRequest
        case 401: throw NetworkErrors.HTTPErrors.unauthorized
        case 403: throw NetworkErrors.HTTPErrors.forbidden
        case 404: throw NetworkErrors.HTTPErrors.notFound
        case 408: throw NetworkErrors.HTTPErrors.timeOut
        case 500: throw NetworkErrors.HTTPErrors.internalServerError

        default: throw NetworkErrors.decoderFailure
        }
    }
}

// MARK: - NetworkManagerProtocol
extension NetworkManager: NetworkManagerProtocol {
    func requestObject<T>(with config: RequestConfiguration,
                          completion: @escaping (Result<T, ErrorHandler>) -> Void) where T: Decodable {

        guard let urlRequest = createUrlRequest(with: config) else {
            completion(.failure(ErrorHandler(defaultError: NetworkErrors.malformedUrl)))
            return
        }
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            self.queue.async {
                do {
                    if let error = error {
                        if error._code == NetworkErrors.connectionLost.code {
                            throw NetworkErrors.connectionLost
                        } else if error._code == NetworkErrors.notConnected.code {
                            throw NetworkErrors.notConnected
                        } else {
                            throw NetworkErrors.requestFailure
                        }
                    } else if let response = response as? HTTPURLResponse {
                        try self.validateStatusCode(with: response.statusCode)

                        guard let data = data else {
                            throw NetworkErrors.noData
                        }

                        let object = try self.decoder.decode(T.self, from: data.value)
                        completion(.success(object))
                    } else {
                        throw NetworkErrors.unknownFailure
                    }
                } catch let error as NetworkErrors {
                    completion(.failure(ErrorHandler(statusCode: error.code, data: data, defaultError: error)))
                } catch let error as NetworkErrors.HTTPErrors {
                    completion(.failure(ErrorHandler(statusCode: error.code, data: data, defaultError: error)))
                } catch let error as DecodingError {
                    completion(.failure(ErrorHandler(data: data, defaultError: error)))
                } catch {
                    completion(.failure(ErrorHandler(data: data, defaultError: .unknownFailure)))
                }
            }
        }

        task.resume()
    }

    func receive(on queue: DispatchQueue) -> Self {
        self.queue = queue
        return self
    }
}
